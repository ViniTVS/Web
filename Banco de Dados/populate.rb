# -*- coding: utf-8 -*-
$:.push "./"
require "review/review.rb"
require "livro/livro.rb"
require "editora/editora.rb"
require "autor/autor.rb"

livros = [
  {
    nome: "2001: uma Odisseia no Espaço",
    autores: ["Arthur C. Clarke"],
    editora: "Hutchinson",
    ano: 1968,
    nota: 86,
    review: '"2001: Uma Odisseia no Espaço" é uma obra de ficção científica de Arthur C. Clarke que explora a evolução humana desde a pré-história até a era espacial. Dividida em três partes, a narrativa é confusa e arrastada para alguns leitores, mas fisga a curiosidade e envolve aqueles que conseguem abrir suas mentes para os saltos temporais que formam uma trama única. Clarke propõe explicações sobre as origens da humanidade, descrevendo tecnologias e possibilidades que desafiam a inteligência humana. É uma obra fundamental para fãs de ficção científica e que provoca reflexão e debate.',

  },
  {
    nome: "A Game of Thrones",
    autores: ["George R. R. Martin"],
    editora: "Bantam Spectra",
    ano: 1996,
    nota: 92,
    review: '"A Game of Thrones" de George R. R. Martin é o primeiro livro da série "As Crônicas de Gelo e Fogo". O romance segue a intriga política e as lutas pelo poder entre duas famílias, os Starks e os Lannisters, enquanto lutam pelo controle do Trono de Ferro em um mundo que lembra a Inglaterra medieval. O livro apresenta um grande elenco de personagens, e a morte é lugar-comum. Apesar dos elementos sobrenaturais no início, o romance é mais focado em maquinações políticas e nas lutas dos personagens do que em elementos de fantasia.',
  },
  {
    nome: "Algoritmos - Teoria e Prática",
    autores: ["Thomas H. Cormen", "Charles E. Leiserson", "Ronald L. Rivest", "Clifford Stein"],
    editora: "MIT Press",
    ano: 1990,
    nota: 92,
    review: "Alguns livros sobre algoritmos são rigorosos, mas incompletos; outros cobrem grandes quantidades de material, mas carecem de rigor. Algoritmos - Teoria e Prática combina de forma única rigor e abrangência. Abrange uma ampla gama de algoritmos em profundidade, mas torna seu design e análise acessíveis a todos os níveis de leitores, com capítulos independentes e algoritmos em pseudocódigo. Desde a publicação da primeira edição, Introdução aos Algoritmos tornou-se o principal texto sobre algoritmos em universidades em todo o mundo, bem como a referência padrão para profissionais. Esta quarta edição foi totalmente atualizada.",
  },
  {
    nome: "Uma Breve História do Tempo",
    autores: ["Stephen Hawking"],
    editora: "Bantam Dell Publising Group",
    ano: 1988,
    nota: 92,
    review: "Este famoso livro de Stephen Hawking narra a evolução do conhecimento sobre o universo desde Aristóteles até a física quântica e a relatividade de Einstein. Hawking responde perguntas como como o universo começou, se é finito ou infinito, se é possível viajar no tempo e explica conceitos como buracos negros e princípio de incerteza. Conclui que é necessário unificar a física quântica e a relatividade para entender completamente o universo. Aprender sobre o tempo e o espaço é fascinante, e mesmo as partes mais difíceis não me desanimaram com esse livro. Hawking sabe estimular o fascínio e o amor pela ciência, e ainda nos deixar esperançosos pelos rumos que a ciência pode tomar.",
  },
  {
    nome: "Algorithms Unlocked",
    autores: ["Thomas H. Cormen"],
    editora: "MIT Press",
    ano: 2013,
    nota: 84,
    review: "O livro é uma introdução clara e concisa sobre algoritmos de computador, cada um com exemplos concretos seguidos de sua definição. O livro não é para leitores leigos e não aborda como algoritmos afetam o dia a dia. Diferente de outros livros, este omite grande parte da análise de desempenho e matemática necessária, mas mantém a rigorosidade intelectual. Poucas aplicações são apresentadas, como GPS e transações seguras de cartões de crédito, mas de forma superficial e sem exercícios.",
  },
  {
    nome: "Assassinato no Expresso do Oriente",
    autores: ["Agatha Christie"],
    editora: "Collins Crime Club",
    ano: 1934,
    nota: 86,
    review: "Assassinato no Expresso Oriente é um clássico da literatura policial escrito por Agatha Christie. Na década de 1930, o famoso investigador Hercule Poirot é confrontado com um assassinato em um trem durante uma viagem para a Inglaterra. A obra se destaca pela capacidade de imergir o leitor e fazê-lo sentir-se ao lado do detetive em busca do autor do crime. A narrativa é inteligente e apresenta charadas e novas descobertas a cada parte, mantendo o leitor preso até o final.",
  },
  {
    nome: "Duna",
    autores: ["Frank Herbert"],
    editora: "Editora Aleph",
    ano: 1965,
    nota: 90,
    review: "Duna, de Frank Herbert, é um clássico da ficção científica que aborda o tema do escolhido em um futuro distante onde a civilização humana depende do tempero geriátrico, encontrado apenas em um planeta, Arrakis. A história gira em torno de Paul Atreides e sua luta contra a política e o ambiente hostil de Arrakis, enquanto descobre seu papel em uma antiga profecia. A riqueza de detalhes na descrição do mundo e dos personagens torna a saga envolvente e convincente.",
  },
  {
    nome: "O Assassinato de Roger Ackroyd",
    autores: ["Agatha Christie"],
    editora: "William Collins & Sons",
    ano: 1969,
    nota: 80,
    review: "O Assassinato de Roger Ackroyd merece ser considerado o melhor romance policial da história. O enredo é elaborado de forma inteligente e o final é entregue de uma maneira que fará com que muitos voltem imediatamente para lê-lo novamente. Este é um romance de ritmo acelerado com diálogos maravilhosos e, embora os personagens possam parecer superficiais no início, logo se verá como sua tendência uniforme de se misturar ao cenário foi totalmente intencional. Quando o mundo inteiro é cinza, como você identifica o homem cinza? Embora este romance possa não ser tão conhecido quanto algumas das outras obras de Christie, é de longe seu maior romance policial, apenas pelo brilho absoluto do conceito e da execução. Este romance é uma leitura obrigatória para entusiastas de romances policiais e para leitores de histórias inteligentes em geral.",
  },
  {
    nome: "Filhos de Duna",
    autores: ["Frank Herbert"],
    editora: "Editora Aleph",
    ano: 1976,
    nota: 10,
    review: "Achei esse livro muito bom, nota 10.",
  },
]

livros.each do |livro|
  # livro já cadastrado
  next if not Livro.find_by(nome: livro[:nome]).blank?

  l = Livro.new({ :nome => livro[:nome], :ano => livro[:ano] })

  editora = Editora.find_by(nome: livro[:editora])
  # editora não existe, então cria
  if editora.blank?
    editora = Editora.new({ :nome => livro[:editora] })
    editora.save
  end

  # Adiciona autores
  # se for um array, adiciona um a um
  livro[:autores].each do |nome_autor|
    autor = Autor.find_by(nome: nome_autor)

    if autor.blank?
      autor = Autor.new({ :nome => nome_autor })
      autor.save
    end

    l.autor << autor
  end
  
  r = Review.new({ :nota => livro[:nota], :texto => livro[:review] })
  r.livro = l
  l.editora = editora
  l.save
  r.save
end
