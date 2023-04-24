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
end
