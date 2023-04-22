# -*- coding: utf-8 -*-
require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
    :database => "Tabelas.sqlite3" 


class Livro < ActiveRecord::Base;
    has_one     :review, dependent: :destroy
    belongs_to  :editora
    has_and_belongs_to_many :autor
end

