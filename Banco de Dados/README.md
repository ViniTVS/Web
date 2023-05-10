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


## Editora
| Campo | Tipo | Restrições |
| ----------- | ----------- | ----------- |
| nome | String | obrigatório, tamanho entre 2 e 500, único |
| livro | has_many Livro | |

## Autor
| Campo | Tipo | Restrições |
| ----------- | ----------- | ----------- |
| nome | String | obrigatório, tamanho entre 2 e 500 caracteres, único |
| livro | has_and_belongs_to_many Livro |  |

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
## lista

## exclui
alias: `remove`
## tabelas

## colunas
## campos

## limpa
alias: `limpar`

## insere

## associa
## altera
alias: `atualiza`


## sair
