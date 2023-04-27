# -*- coding: utf-8 -*-
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

class Livro < ActiveRecord::Base
  has_one :review, dependent: :destroy
  belongs_to :editora
  has_and_belongs_to_many :autor, dependent: :destroy_all

  before_destroy do |livro|
    # pega cada livro do autor
    livro.autor.each do |a|
      # e apaga a relação entre livro-autor
      a.livro.each do |l|
        l.delete if l == livro
      end
      # se não restaram livros para o autor, o apaga
      a.destroy if a.livro.count == 0

    end
  end
  
  # validações
  validates :editora, presence: true
  validates :nome, presence: true, length: { minimum: 2, maximum: 500 }
  validates :ano, numericality: { only_integer: true, less_than_or_equal_to: 2023 }

  validates_associated :editora


  before_validation :corrige_tipos

  private
    def corrige_tipos
      ano = ano.to_i
      nome = nome.to_s
      editora_id = editora_id.to_i
    end


end
