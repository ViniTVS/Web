rm -f Tabelas.sqlite3
echo -n "criando Livros... "
ruby criaLivros.rb 
echo "Ok"
echo -n "criando Editoras... "
ruby criaEditoras.rb 
echo "Ok"
echo -n "criando Reviews... "
ruby criaReviews.rb 
echo "Ok"
echo -n "criando Autores... "
ruby criaAutores.rb 
echo "Ok"
echo -n "criando AutoresLivros... "
ruby criaAutoresLivros.rb 
echo "Ok"

echo -n "Populando... "
ruby populate.rb  
echo "Ok"


# echo -n "populaEstados ..."
# ruby populaEstados.rb
# echo "Ok"
# echo -n "populaPessoas ..."
# ruby populaPessoasD.rb
# echo "Ok"
# echo -n "populaMunicipios ..."
# ruby populaMunicipos.rb
# echo "Ok"
# echo -n "populaEsportes ..."
# ruby populaEsportes.rb
# echo "Ok"
# echo -n "populaPessoasEsportes ..."
# ruby populaPessoaEsporte.rb
# echo "Ok"
