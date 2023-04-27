# -*- coding: utf-8 -*-
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

class Review < ActiveRecord::Base
  belongs_to :livro
  # validações
  validates :livro, presence: true
  
  validates_associated :livro


  # before_validation :corrige_tipos

  # private
  #   def corrige_tipos
  #     if login.nil?
  #       self.login = email unless email.blank?
  #     end
  #   end


end
