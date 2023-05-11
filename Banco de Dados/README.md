# Trabalho de Banco de Dados usando ActiveRecord
## Enunciado do trabalho
Objetivo: Criar e usar um banco de dados via ActiveRecord.

Caracteristicas:
 - Criar um banco de dados contendo tabelas com as relações (a) um para um, (b) um para muitos e (c) muitos para muitos.
 - A inserção, alteração e exclusão de elementos devem ser realizados de acordo com o que for indicado pelo usuário na linha de comando. Comandos: insere, altera, exclui.
 - Especificação: < operação > < tabela > { atributo = valor }

## Trabalho feito
Para realizar o trabalho foi escolhido criar um banco de dados (utilizando SQLite) com relação a livros e relações com seus autores, editora e sinopse. As realções foram atendidas da seguinte forma:
 - um para um: todo livro possui uma única sinopse.
 - um para muitos: cada editora possui vários livros.
 - muitos para muitos: um livro pode ter vários autores e cada autor pode ter escrito vários livros.

# Tabelas
Cada tabela foi criada no Active Record com os seguintes campos:
## Livro
| Campo | Tipo | Restrições |
| ----------- | ----------- | ----------- |
| ano | Integer | obrigatório, valor entre -1000 e 2023 |
| nome | String | obrigatório, tamanho entre 2 e 500 caracteres |
| editora | has_one Editora | obrigatório |
| sinopse | has_one Sinopse | obrigatório |
| autor | has_and_belongs_to_many Autor |  |

Caso um livro seja excluído, todos os autores que não tenham relação com outro livro deve ser excluído, assim como a sinopse relacionada ao livro.

## Editora
| Campo | Tipo | Restrições |
| ----------- | ----------- | ----------- |
| nome | String | obrigatório, tamanho entre 2 e 500, único |
| livro | has_many Livro | |

Caso seja excluída uma editora, todos os livros relacionados a ela devem também ser excluídos.

## Autor
| Campo | Tipo | Restrições |
| ----------- | ----------- | ----------- |
| nome | String | obrigatório, tamanho entre 2 e 500 caracteres, único |
| livro | has_and_belongs_to_many Livro |  |

Caso seja excluído um autor, todos os livros que o possuam como único autor devem ser excluídos.

## Sinopse
| Campo | Tipo | Restrições |
| ----------- | ----------- | ----------- |
| texto | Text | obrigatório, tamanho entre 20 e 2000 caracteres, único |
| livro | belongs_to Livro | obrigatório, único |



# Execução
Antes de executar o programa para interface deve-se executar o script `criaTudo.sh`, que executa os programas que criam as relações do banco de dados e os popula (executando o populate.rb). Ao final de sua execução deve ser criado o arquivo `Tabelas.sqlite3`, em que armazena os dados do banco de dados em si.

Para leitura dos comandos do usuário foi criado o programa `interface.rb`, que pode ser executado com
```bash
ruby interface.rb
```
Os comandos criados são listados a seguir:
# Comandos
Cada comando deve ser executado respeitando o seguinte padrão:

\<comando\> \<tabela\> campo="valor"

Obs: cada camo que possui relação um para um ou um para vários possui como campo o nome da outra tabela seguido por _id. É possível ver os campos que podem ser utilizados utilizando o comando colunas

Ex:

    lista livros editora_id="3"


## tabelas

É o único comando que não utiliza nem tabela e em campos. Ele lista todas as tabelas presentes no arquivo gerado para o SQLite.

Ex:

    tabelas

Obs: apesar de imprimir a tabela autores_livros (que exite para a relação muitos para muitos), esta não poderá ser acessada diretamente.

## colunas
alias: `campos`

Lista todas as colunas presentes em uma tabela. Este comando não utiliza os valores de campos.

Ex:

    colunas livros

## lista
Lista as entradas da tabela passada como parâmetro. Opcionalmente podem ser passados os campos que a entrada deve ter para ser listada. Caso sejam passados vários campos, são listadas as entradas que respeitem todas as condições.

Ex (sem campos):

    lista livros

Ex (com campos):

    lista livros ano="1996" editora_id="2"
## insere
Insere em dada tabela uma nova entrada especificada pelos campos passados. Porém, por conta das associações das tabelas, existem algumas limitações:

Como livros e sinopses possuem uma relação um para um, ambos devem ser inseridos juntos, então também se deve adicionar um campo sinopse durante a inserção de um livro.
Ex:

    insere livros nome="Eu" ano="1912" editora_id="3" sinopse="Eu e outras poesias, conhecido também apenas como Eu, é o único livro de poesia de Augusto dos Anjos..."


Como não é possível acessar diretamente a tabela autores_livros, esta associação é feita ao se inserir ou alterar um autor. Ou seja, é necessário **primeiro ser inserido um livro para então se inserir seu autor**. Para isso, ao se inserir um autor, é necessário especificar seus livros, que devem ser declarados com um campo livros e passados os IDs dos livros separados por vírgula.
Ex:

    insere autores nome="Augusto dos Anjos" livros="1,10"

Faz com que seja inserido o autor de nome Augusto dos Anjos e associado aos livros de IDs 1 e 10.

Então no caso de inserir uma editora, basta colocar seu nome:
Ex:

    insere editoras nome="Editora UFPR"

Caso seja válida a nova entrada, é retornado o seu ID de inserção. Caso contrário serão apresentados erros.

## exclui
alias: `remove`

Remove as entradas da tabela que possuam o valor dos campos passados. Caso sejam passados vários campos, são excluídas as entradas que respeitem todas as condições.

Ex:

    exclui livros ano="1969"
## altera
alias: `atualiza`

Atualiza os campos passados para serem atualizados de dada tabela. Serão atualizados todos os registros da tabela que atendam às condições dos campos passados. Para separar os valores de campo de busca e os novos valores, deve-se utilizar a palavra "para" e então o(s) novo(s) valor(es) dos campos devem ser passada.

Com isso, o padrão do comando é de:

\<comando\> \<tabela\> campo_busca="valor" **para** campo="novo valor"

Obs: é importante ressaltar que os valores dos campos de busca que precisam ser atendidos não precisam ser necessariamente aqueles a se atualizar.

Ex:

    altera livros ano="1968" para nome="Livros de 1968 alterados"


## limpa
alias: `limpar`

Este é na verdade um comando auxiliar, usado para que possa limpar a tela do terminal. Ele só executa o comando ruby:
```ruby
puts `clear`
```

Ex:

    limpar
## sair
Encerra a execução do programa.
Ex:

    sair
