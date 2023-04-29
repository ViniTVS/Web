require "rubygems"
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

ActiveRecord::Base.connection.create_table :livros do |l|
  l.integer :ano
  l.string :nome
  l.references :editora, foreign_key: true
end
