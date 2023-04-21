# -*- coding: utf-8 -*-
require 'active_record'

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
    :database => "Tabelas.sqlite3" 


class Editora < ActiveRecord::Base;
    has_many :livro, dependent: :delete_all 
end

