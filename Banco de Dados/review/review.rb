# -*- coding: utf-8 -*-
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

class Review < ActiveRecord::Base
  belongs_to :livro
  # validações
  validates :livro, presence: true, uniqueness: true
  validates :nota, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 100, greater_than_or_equal_to: 0 }
  validates :texto, presence: true, length: { minimum: 20, maximum: 1000 }

  validates_associated :livro

  before_validation :corrige_tipos

  private

  def corrige_tipos
    nota = nota.to_i
    texto = texto.to_s
    livro_id = livro_id.to_i
  end
end
