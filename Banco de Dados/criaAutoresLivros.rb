require "rubygems"
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

ActiveRecord::Base.connection.create_table :autores_livros, id: false do |t|
  t.references :livro, :unique => true
  t.references :autor, :unique => true
end
