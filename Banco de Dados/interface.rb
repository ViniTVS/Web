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

def strToHash(val)
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

def insereTabela(tabela, valores_chaves)
  return if tabela == nil

  h = strToHash(valores_chaves)
  colunas = tabela.column_names

  h.each do |key, val|
    if not colunas.include? key
      puts "Campo \"#{key}\" não pertence à tabela"
      return
    end
  end

  insere = tabela.new(h)
  if insere.valid?
    insere.save
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
    tabela = obtemTabela(restante[0])
    # if restante[0] == "autores_livros"
    listaTabela(tabela, restante[1])
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

  puts ""
end

loop do
  entrada = gets.split(" ", 3)
  comando = entrada[0]
  entrada.delete_at(0)
  trataComando(comando, entrada)
end
