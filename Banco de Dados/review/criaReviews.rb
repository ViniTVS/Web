require "rubygems"
require "active_record"

ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "Tabelas.sqlite3"

ActiveRecord::Base.connection.create_table :reviews do |r|
  r.integer :nota
  r.text :texto
  r.references :livro, index: { unique: true }, foreign_key: true
end
