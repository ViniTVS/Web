# -*- coding: utf-8 -*-
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

class Autor < ActiveRecord::Base
  self.table_name = "autores"
  has_and_belongs_to_many :livro
end
