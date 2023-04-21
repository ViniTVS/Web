# -*- coding: utf-8 -*-
$:.push './'
require 'review.rb'
require 'livro.rb'
require 'editora.rb'




livros = [
  {
    nome: "2001: uma Odisseia no Espaço",
    autores: "Arthur C. Clarke",
    editora: "Aleph",
    ano: 1968,
    nota: 86,
    review: '"2001: Uma Odisseia no Espaço" é uma obra de ficção científica de Arthur C. Clarke que explora a evolução humana desde a pré-história até a era espacial. Dividida em três partes, a narrativa é confusa e arrastada para alguns leitores, mas fisga a curiosidade e envolve aqueles que conseguem abrir suas mentes para os saltos temporais que formam uma trama única. Clarke propõe explicações sobre as origens da humanidade, descrevendo tecnologias e possibilidades que desafiam a inteligência humana. É uma obra fundamental para fãs de ficção científica e que provoca reflexão e debate.'
  },
  {
    nome: "A Game of Thrones",
    autores: "George R. R. Martin",
    editora: "Bantam Livros",
    ano: 1996,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "O Alquimista",
    autores: "Paulo Coelho",
    editora: "Rocco",
    ano: 1988,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "Diário de um Mago",
    autores: "Paulo Coelho",
    editora: "Rocco",
    ano: 1987,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "O Aleph",
    autores: "Paulo Coelho",
    editora: "Rocco",
    ano: 2011,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "Uma Breve História do Tempo",
    autores: "Stephen Hawking",
    editora: "Intrínseca",
    ano: 1988,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "Vidas Secas",
    autores: "Graciliano Ramos",
    editora: "Record",
    ano: 1938,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "Sapiens: Uma Breve História da Humanidade",
    autores: "Yuval Harari",
    editora: "L&PM",
    ano: 2011,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "Duna",
    autores: "Frank Herbert",
    editora: "Editora Aleph",
    ano: 1965,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "Duna Messiah",
    autores: "Frank Herbert",
    editora: "Editora Aleph",
    ano: 1969,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  },
  {
    nome: "Filhos de Duna",
    autores: "Frank Herbert",
    editora: "Editora Aleph",
    ano: 1976,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.'
  }
]

livros.each do |livro|
    # livro já cadastrado
    next if not Livro.find_by(nome: livro[:nome]).blank?
    
    l = Livro.new({:nome => livro[:nome], :ano => livro[:ano]})

    editora = Editora.find_by(nome: livro[:editora])

    if editora.blank?
        editora = Editora.new({:nome => livro[:editora]})
        editora.save
    end

    review = Review.new({})
    l.editora = editora
    l.save
end



# retira_livro.delete