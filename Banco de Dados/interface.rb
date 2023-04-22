# -*- coding: utf-8 -*-
$:.push "./"
require "review.rb"
require "livro.rb"
require "editora.rb"
require "autor.rb"

$todas_tabelas = {
  "autores" => Autor,
  "livros" => Livro,
  "reviews" => Review,
  "editoras" => Editora,
}

def obtemTabela(nome_tabela)
  if not $todas_tabelas.has_key?(nome_tabela)
    puts "Tabela #{nome_tabela} não encontrada"
    return nil
  end
  return $todas_tabelas[nome_tabela]
end

# insere, altera, exclui, lista

def listaTabela(tabela, ordena = [])
  return if tabela == nil
  entradas = tabela.all
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
    puts "#{info.join(", ")}"
  end
end

def insereTabela(tabela, valores_chaves)
  return if tabela == nil

  h = Hash.new

  val = valores_chaves
  colunas = tabela.column_names

  while val != nil
    # vamos separar os valores para inserir entre campo e valor
    val = val.split("\" ", 2)
    separa = val[0].split("\=")

    campo = separa[0]
    if not colunas.include? campo
      puts "Campo \"#{campo}\" não pertence à tabela"
      return
    end
    valor = separa[1]
    # tira as aspas e pula linha do valor
    valor = valor.gsub("\"", "")
    valor = valor.gsub("\n", "")

    h[campo] = valor
    val = val[1]
  end

  insere = tabela.new(h)
  if insere.valid?
    insere.save
  else
    puts "Campo(s) inválido(s)"
  end
end

def excluiTabela(tabela, valores_chaves)
  return if tabela == nil

  h = Hash.new

  val = valores_chaves

  while val != nil
    # vamos separar os valores para inserir entre campo e valor
    val = val.split("\" ", 1)
    separa = val[0].split("\=")

    campo = separa[0]
    valor = separa[1]
    # tira as aspas e pula linha do valor
    valor = valor.gsub("\"", "")
    valor = valor.gsub("\n", "")

    h[campo] = valor
    val = val[1]
  end

  tabela.find_by(h).destroy
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
    tabela = obtemTabela(restante[0])
    restante.delete_at(0)
    listaTabela(tabela, restante)
  when "exclui"
    tabela = obtemTabela(restante[0])
    excluiTabela(tabela, restante[1])
  when "tabelas"
    getTabelas()
  when "colunas"
    tabela = obtemTabela(restante[0])
    printColunasTabela(tabela)
  when "limpar"
    puts `clear`
  when "insere"
    tabela = obtemTabela(restante[0])
    insereTabela(tabela, restante[1])
  when "associa"
    tabela = obtemTabela(restante[0])
    associaTabelas(tabela, restante[1])
  when "sair"
    puts "Saindo..."
    exit 0
  else
    puts "Comando \"#{comando}\" não reconhecido"
  end
end

loop do
  entrada = gets.split(" ", 3)
  comando = entrada[0]
  entrada.delete_at(0)
  trataComando(comando, entrada)
end
