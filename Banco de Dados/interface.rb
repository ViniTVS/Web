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

# Transforma uma string de entrada em uma hash conforme o padrão
# dado de exemplo pelo professor.
# Exemplo de entrada: 'id="3" nome="Exemplo"'
# Saida: {"id"=>"3", "nome"=>"Exemplo"}
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
    if not valor.is_a? String
      puts "Formatação incorreta"
      return nil
    end
    valor = valor.gsub("\"", "")
    valor = valor.gsub("\n", "")

    h[campo] = valor
    val = val[1]
  end
  return h
end

# Verifica se o resultado na busca do active_record é vazio
def resultadoVazio(res_busca)
  vazio = false
  # Se a hash de busca tiver erros, o método blank? 
  # encerra o programa e joga erros na sua cara
  begin
    vazio = res_busca.blank?
  rescue => e
    vazio = true
  end
  return vazio
end

# Transforma a string de entrada em uma classe do active_record
# com base no hash definido em $todas_tabelas
def obtemTabela(nome_tabela)
  if not $todas_tabelas.has_key?(nome_tabela)
    puts "Tabela #{nome_tabela} não encontrada"
    return nil
  end
  return $todas_tabelas[nome_tabela]
end

# Imprime na saida padrão os dados da tabela de nome nome_tabela.
# Opcionalmente pode ser passada uma String que se tornará hash
# com a função strToHash com condições para buscar entradas que as atendam
def listaTabela(nome_tabela, condicoes = "")
  tabela = obtemTabela(nome_tabela)
  return if tabela == nil

  entradas = tabela.all
  # busca por entradas que atendam à condição
  if condicoes != ""
    h = strToHash(condicoes)
    entradas = tabela.where(h)
  end

  # não tem o que listar
  if resultadoVazio(entradas)
    puts "Entrada(s) não encontrada(s)"
    return
  end

  colunas = entradas.column_names
  entradas.each do |entrada|
    info = []
    colunas.each do |col|
      impressao = ""
      impressao << col
      impressao << ": "
      impressao << entrada[col].to_s
      info.push(impressao)
    end
    # lista ids dos autores do livro
    if nome_tabela == "livros"
      autores = []
      entrada.autor.each do |autor|
        autores.push(autor.id)
      end
      info.push("autor_id: #{autores.join(", ")}")
    end
    # lista ids dos livros do autor
    if nome_tabela == "autores"
      livros = []
      entrada.livro.each do |livro|
        livros.push(livro.id)
      end
      info.push("livro_id: #{livros.join(", ")}")
    end
    # imprime utilizando join pra usar o char de separação mais facilmente
    puts "#{info.join(" | ")}"
  end
end

# Adiciona entrada na (classe da) tabela passada com a nova entrada desejada (formato em hash)
def insereTabela(tabela, entrada)
  insere = tabela.new(entrada)
  if insere.valid?
    insere.save
    puts "ID da nova inserção: #{insere.id}"
  else
    puts "Inserção inválida. Erro(s) gerado(s):"
    puts insere.errors.full_messages
  end
end

# Faz o mesmo de insereTabela, mas como um livro precisa ter necessariamente
# uma sinopse, foi feita uma função própria para tal
def insereLivros(entrada)
  sinopse = Sinopse.new(texto: entrada["sinopse"])
  entrada.delete("sinopse")

  livro = Livro.new(entrada)
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

# Faz o mesmo de insereTabela, mas como não podemos acessar diretamente a tabela
# de associação entre autores e livros, foi feita uma função própria para tal
def insereAutoresLivros(hash)
  ids_autores = hash["autores"].split(",")
  ids_livros = hash["livros"].split(",")

  ids_livros.each do |id_livro|
    livro = Livro.find_by(id: id_livro.to_i)
    ids_autores.each do |id_autor|
      autor = Autor.find_by(id: id_autor.to_i)
      autor.livro << livro if livro != nil and autor != nil
    end
  end
end

# Exclui entradas da tabela que atendam à condição da hash passada em
# valores_chaves
def excluiTabela(tabela, valores_chaves)
  return if tabela == nil

  if valores_chaves == nil
    puts "Não é permitida a exclusão sem condições"
    return
  end
  itens = tabela.where(valores_chaves)

  if resultadoVazio(itens)
    puts "Item(s) para eclusão não encontrado(s)"
  else
    itens.each do |item|
      item.destroy
    end
  end
end

# Impre as colunas de dada tabela
def printColunasTabela(tabela)
  colunas = tabela.options.includes(:model_options)
  colunas.each do |col|
    puts col
  end
end

# Imprime as tabelas existentes no banco
def getTabelas()
  tabelas = ActiveRecord::Base.connection.tables

  tabelas.each do |tabela|
    puts tabela
  end
end

def trataComando(comando, restante)
  case comando
  when "lista"
    listaTabela(restante[0], restante[1])
  when "exclui"
    tabela = obtemTabela(restante[0])
    h = strToHash(restante[1])
    excluiTabela(tabela, h)
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
