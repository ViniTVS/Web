rm -f Tabelas.sqlite3
echo -n "criando Livros... "
ruby livro/criaLivros.rb 
echo "Ok"
echo -n "criando Editoras... "
ruby editora/criaEditoras.rb 
echo "Ok"
echo -n "criando Sinopses... "
ruby sinopse/criaSinopses.rb 
echo "Ok"
echo -n "criando Autores... "
ruby autor/criaAutores.rb 
echo "Ok"
echo -n "criando AutoresLivros... "
ruby autor/criaAutoresLivros.rb 
echo "Ok"

echo -n "Populando... "
ruby populate.rb  
echo "Ok"

