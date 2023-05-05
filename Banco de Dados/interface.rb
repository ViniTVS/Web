# -*- coding: utf-8 -*-
$:.push "./"
require "sinopse/sinopse.rb"
require "livro/livro.rb"
require "editora/editora.rb"
require "autor/autor.rb"

$todas_tabelas = {
  "autores" => Autor,
  "livros" => Livro,
  "sinopses" => Sinopse,
  "editoras" => Editora,
}
# transforma o padrão de entrada em um hash
def strToHash(val)
  return nil if val == ""
  h = Hash.new

  while val != nil
    # vamos separar os valores para inserir entre campo e valor
    val = val.split("\" ", 2)
    separa = val[0].split("\=")

    campo = separa[0]
    valor = separa[1]
    # tira as aspas e pula linha do valor
    valor = valor.gsub("\"", "")
    valor = valor.gsub("\n", "")

    h[campo] = valor
    val = val[1]
  end
  return h
end

def obtemTabela(nome_tabela)
  if not $todas_tabelas.has_key?(nome_tabela)
    puts "Tabela #{nome_tabela} não encontrada"
    return nil
  end
  return $todas_tabelas[nome_tabela]
end

def listaTabela(tabela, restante = "")
  return if tabela == nil

  entradas = tabela.all

  if restante != ""
    h = strToHash(restante)
    entradas = tabela.where(h)
  end

  if entradas.empty?
    puts "Entrada(s) não encontrada(s)"
    return
  end

  colunas = tabela.column_names

  entradas.each do |entrada|
    info = []
    colunas.each do |col|
      impressao = ""
      impressao << col
      impressao << ": "
      impressao << entrada[col].to_s
      info.push(impressao)
    end
    puts "#{info.join(" | ")}"
  end
end

def insereLivros(hash)
  sinopse = Sinopse.new(texto: hash["sinopse"])
  hash.delete("sinopse")

  livro = Livro.new(hash)
  livro.sinopse = sinopse

  if sinopse.valid? and livro.valid?
    sinopse.save
    livro.save
    puts "ID da nova inserção: #{livro.id}"
  else
    puts "Inserção inválida. Erro(s) gerado(s):"
    puts livro.errors.full_messages
    puts sinopse.errors.full_messages
  end
end

def insereAutoresLivros(hash)
  ids_autores = hash["autores"].split(",")
  ids_livros = hash["livros"].split(",")

  ids_livros.each do |id_livro|
    ids_autores.each do |id_autor|
      livro = Livro.find_by(id: id_livro.to_i)
      autor = Autor.find_by(id: id_autor.to_i)
      autor.livro << livro if livro != nil and autor != nil
    end
  end
end

def insereTabela(tabela, hash)
  insere = tabela.new(hash)
  if insere.valid?
    insere.save
    puts "ID da nova inserção: #{insere.id}"
  else
    puts "Inserção inválida. Erro(s) gerado(s):"
    puts insere.errors.full_messages
  end
end

def excluiTabela(tabela, valores_chaves)
  return if tabela == nil

  h = strToHash(valores_chaves)
  item = tabela.find_by(h)
  if item == nil
    puts "Item(s) para eclusão não encontrado(s)"
  else
    item.destroy
  end
end

def printColunasTabela(tabela)
  colunas = tabela.options.includes(:model_options)
  colunas.each do |col|
    puts col
  end
end

def getTabelas()
  tabelas = ActiveRecord::Base.connection.tables

  tabelas.each do |tabela|
    puts tabela
  end
end

def trataComando(comando, restante)
  case comando
  when "lista"
    if restante[0] == "autores_livros"
    listaTabela(obtemTabela(restante[0]), restante[1])
  when "exclui"
    tabela = obtemTabela(restante[0])
    excluiTabela(tabela, restante[1])
  when "tabelas"
    getTabelas()
  when "colunas", "campos"
    tabela = obtemTabela(restante[0])
    printColunasTabela(tabela)
  when "limpa", "limpar"
    print `clear`
  when "insere"
    h = strToHash(restante[1])

    case restante[0]
    when "livros"
      insereLivros(h)
    when "autores_livros"
      insereAutoresLivros(h)
      # when "autores"
    else
      insereTabela(obtemTabela(restante[0]), h)
    end
  when "associa"
    tabela = obtemTabela(restante[0])
    associaTabelas(tabela, restante[1])
  when "sair"
    puts "Saindo..."
    exit 0
  else
    puts "Comando \"#{comando}\" não reconhecido"
  end

  puts ""
end

loop do
  entrada = gets.split(" ", 3)
  comando = entrada[0]
  entrada.delete_at(0)
  trataComando(comando, entrada)
end
