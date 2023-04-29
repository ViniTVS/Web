# -*- coding: utf-8 -*-
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

class Editora < ActiveRecord::Base
  has_many :livro, dependent: :delete_all
  # validações
  validates :nome, presence: true, length: { minimum: 2, maximum: 500 }

  before_validation :corrige_tipos

  private

  def corrige_tipos
    nome = nome.to_s
  end
end
