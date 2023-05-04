# -*- coding: utf-8 -*-
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

class Autor < ActiveRecord::Base
  self.table_name = "autores"
  has_and_belongs_to_many :livro

  before_destroy do |autor|
    # pega cada livro do autor
    autor.livro.each do |l|
      # e apaga a relação entre livro-autor
      l.autor.each do |a|
        a.delete if a.id == autor.id
      end
      # se não restaram autores para o livro, o apaga
      l.destroy if l.autor.count == 0
    end
  end

  # validações
  validates :nome, presence: true, length: { minimum: 2, maximum: 500 }, uniqueness: true

  # antes da validação, corrige os tipos dos dados
  before_validation :corrige_tipos


  private

  def corrige_tipos
    nome = nome.to_s
  end











  def self.insere(hash)
    campos_necessarios = ["nome", "livros"]
    erros = Array.new
    # verifica se o hash criado tem os campos necessários
    campos_necessarios.each do |campo|
      erros.push("Campo #{campo} não encontrado") if not hash.has_key?(campo)
    end

    return erros if not erros.empty?
    # cria autor
    autor = Autor.new(nome: hash['nome'])
    # associa os livros ao autor
    ids_livros = hash['livros'].split(",")
    ids_livros.each do |id|
      l = Livro.find_by(id: id.to_i)
      autor.livro << l
    end
    # salva autor se for válido ou adiciona erros ao retorno
    if autor.valid?
      autor.save
      puts "ID da nova inserção: #{autor.id}"
    else
      erros += autor.errors.full_messages
    end
    return erros
  end
end
