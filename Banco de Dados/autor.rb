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
  validates :nome, presence: true, length: { minimum: 2, maximum: 500 }

  # antes da validação, corrige os tipos dos dados
  before_validation :corrige_tipos

  private
    def corrige_tipos
      nome = nome.to_s
    end



end
