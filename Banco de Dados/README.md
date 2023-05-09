# Trabalho de Banco de Dados usando ActiveRecord
## Enunciado do trabalho
Objetivo: Criar e usar um banco de dados via ActiveRecord.

Caracteristicas:
 - Criar um banco de dados contendo tabelas com as relações (a) um para um, (b) um para muitos e (c) muitos para muitos.
 - A inserção, alteração e exclusão de elementos devem ser realizados de acordo com o que for indicado pelo usuário na linha de comando. Comandos: insere, altera, exclui.
 - Especificação: < operação > < tabela > { atributo = valor }

## Trabalho feito
Para realizar o trabalho, foi criada a ideia de atender às relações entre tabelas da seguinte forma:
Uma tabela de livros, que possui uma relação 1:1 com a

# Tabelas
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
