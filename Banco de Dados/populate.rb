# -*- coding: utf-8 -*-
$:.push "./"
require "sinopse/sinopse.rb"
require "livro/livro.rb"
require "editora/editora.rb"
require "autor/autor.rb"

livros = [
  {
    nome: "2001: uma Odisseia no Espaço",
    autores: ["Arthur C. Clarke"],
    editora: "Hutchinson",
    ano: 1968,
    sinopse: 'Nos primórdios da humanidade, quando a fome e os predadores ameaçavam a raça humana, chega à Terra um objeto inusitado, inacessível à limitada compreensão da mente pré-histórica, mas que influencia os homens a descobrir coisas que permitem a sua própria evolução.
    Milhões de anos depois, a descoberta de um monólito soterrado na Lua deixa os cientistas perplexos. Para investigar esse mistério, a Terra envia ao espaço uma equipe altamente treinada e HAL 9000, uma inteligência artificial responsável pelo funcionamento da nave e pela segurança dos tripulantes. Porém, o surgimento de pequenas falhas levanta a suspeita de que há algo errado com a missão.
    Escrito por Arthur C. Clarke com o intuito de expandir a história criada com Stanley Kubrick para o cinema, 2001: uma odisseia no espaço desconcerta o leitor e o conduz a um futuro alternativo da história humana.',

  },
  {
    nome: "A Game of Thrones",
    autores: ["George R. R. Martin"],
    editora: "Bantam Spectra",
    ano: 1996,
    sinopse: 'A guerra dos tronos é o primeiro livro da série best-seller internacional As Crônicas de Gelo e Fogo, que deu origem à adaptação de sucesso da HBO, Game of Thrones. O verão pode durar décadas. O inverno, toda uma vida. E a guerra dos tronos começou. Como Guardião do Norte, lorde Eddard Stark não fica feliz quando o rei Robert o proclama a nova Mão do Rei. Sua honra o obriga a aceitar o cargo e deixar seu posto em Winterfell para rumar para a corte, onde os homens fazem o que lhes convém, não o que devem... e onde um inimigo morto é algo a ser admirado. 
    Longe de casa e com a família dividida, Eddard se vê cada vez mais enredado nas intrigas mortais de Porto Real, sem saber que perigos ainda maiores espreitam a distância.Nas florestas ao norte de Winterfell, forças sobrenaturais se espalham por trás da Muralha que protege a região. E, nas Cidades Livres, o jovem Rei Dragão exilado na Rebelião de Robert planeja sua vingança e deseja recuperar sua herança de família: o Trono de Ferro de Westeros.',
  },
  {
    nome: "Algoritmos - Teoria e Prática",
    autores: ["Thomas H. Cormen", "Charles E. Leiserson", "Ronald L. Rivest", "Clifford Stein"],
    editora: "MIT Press",
    ano: 1990,
    sinopse: " Há livros sobre algoritmos que são rigorosos, mas não completos, e livros que abrangem uma grande quantidade de assuntos, mas não são rigorosos. Introdução aos algoritmos combina os atributos de rigor e abrangência. Este livro cobre em profundidade uma ampla faixa de algoritmos, de maneira acessível aos leitores de todos os níveis. Os algoritmos são apresentados em linguagem comum e em um pseudocódigo criado para ser lido com facilidade por qualquer pessoa familiarizada com a atividade de programação. As explicações foram mantidas elementares, sem sacrificar a profundidade da cobertura nem o rigor matemático.",
  },
  {
    nome: "Uma Breve História do Tempo",
    autores: ["Stephen Hawking"],
    editora: "Bantam Dell Publising Group",
    ano: 1988,
    sinopse: "Uma das mentes mais geniais do mundo moderno, Stephen Hawking guia o leitor na busca por respostas a algumas das maiores dúvidas da humanidade: Qual a origem do universo? Ele é infinito? E o tempo? Sempre existiu, ou houve um começo e haverá um fim? Existem outras dimensões além das três espaciais? E o que vai acontecer quando tudo terminar?
    Com ilustrações criativas e texto lúcido e bem-humorado, Hawking desvenda desde os mistérios da física de partículas até a dinâmica que movimenta centenas de milhões de galáxias por todo o universo. Para o iniciado, Uma breve história do tempo é uma bela representação de conceitos complexos; para o leigo, é um vislumbre dos segredos mais profundos da criação.",
  },
  {
    nome: "Algorithms Unlocked",
    autores: ["Thomas H. Cormen"],
    editora: "MIT Press",
    ano: 2013,
    sinopse: "Have you ever wondered how your GPS can find the fastest way to your destination, selecting one route from seemingly countless possibilities in mere seconds? How your credit card account number is protected when you make a purchase over the Internet? The answer is algorithms. And how do these mathematical formulations translate themselves into your GPS, your laptop, or your smart phone? This book offers an engagingly written guide to the basics of computer algorithms. In Algorithms Unlocked, Thomas Cormen -- coauthor of the leading college textbook on the subject -- provides a general explanation, with limited mathematics, of how algorithms enable computers to solve problems. Readers will learn what computer algorithms are, how to describe them, and how to evaluate them. They will discover simple ways to search for information in a computer; methods for rearranging information in a computer into a prescribed order (\"sorting\"); how to solve basic problems that can be modeled in a computer with a mathematical structure called a \"graph\" (useful for modeling road networks, dependencies among tasks, and financial relationships); how to solve problems that ask questions about strings of characters such as DNA structures; the basic principles behind cryptography; fundamentals of data compression; and even that there are some problems that no one has figured out how to solve on a computer in a reasonable amount of time.",
  },
  {
    nome: "Assassinato no Expresso do Oriente",
    autores: ["Agatha Christie"],
    editora: "Collins Crime Club",
    ano: 1934,
    sinopse: "Nada menos que um telegrama aguarda Hercule Poirot na recepção do hotel em que se hospedaria, na Turquia, requisitando seu retorno imediato a Londres. O detetive belga, então, embarca às pressas no Expresso do Oriente, inesperadamente lotado para aquela época do ano.
    O trem expresso, porém, é detido a meio caminho da Iugoslávia por uma forte nevasca, e um passageiro com muitos inimigos é brutalmente assassinado durante a madrugada. Caberá a Poirot descobrir quem entre os passageiros teria sido capaz de tamanha atrocidade, antes que o criminoso volte a atacar ou escape de suas mãos.",
  },
  {
    nome: "Duna",
    autores: ["Frank Herbert"],
    editora: "Editora Aleph",
    ano: 1965,
    sinopse: "A vida do jovem Paul Atreides está prestes a mudar radicalmente. Após a visita de uma mulher misteriosa, ele é obrigado a deixar seu planeta natal para sobreviver ao ambiente árido e severo de Arrakis, o Planeta Deserto.
    Envolvido numa intrincada teia política e religiosa, Paul divide-se entre as obrigações de herdeiro e seu treinamento nas doutrinas secretas de uma antiga irmandade, que vê nele a esperança de realização de um plano urdido há séculos.
    Ecos de profecias ancestrais também o cercam entre os nativos de Arrakis. Seria ele o eleito que tornaria viáveis seus sonhos e planos ocultos?
    Ao lado das trilogias Fundação, de Isaac Asimov, e O Senhor dos Anéis, de J. R. R. Tolkien, Duna é considerada uma das maiores obras de fantasia e ficção científica de todos os tempos. Um premiado best-seller já levado às telas de cinema pelas mãos do consagrado diretor David Lynch.",
  },
  {
    nome: "O Assassinato de Roger Ackroyd",
    autores: ["Agatha Christie"],
    editora: "William Collins & Sons",
    ano: 1969,
    sinopse: "Em uma noite de setembro, o milionário Roger Ackroyd é encontrado morto, esfaqueado com uma adaga tunisiana – objeto raro de sua coleção particular – no quarto da mansão Fernly Park na pacata vila de King’s Abbott. A morte do fidalgo industrial é a terceira de uma misteriosa sequência de crimes, iniciada com a de Ashley Ferrars, que pode ter sido causada ou por uma ingestão acidental de soníferos ou envenenamento articulado por sua esposa – esta, aliás, completa a sequência de mortes, num provável suicídio.
    Os três crimes em série chamam a atenção da velha Caroline Sheppard, irmã do dr. Sheppard, médico da cidade e narrador da história. Suspeitando de que haja uma relação entre as mortes, dada a proximidade de miss Ferrars com o também viúvo Roger Ackroyd, Caroline pede a ajuda do então aposentado detetive belga Hercule Poirot, que passava suas merecidas férias na vila.    
    Ameaças, chantagens, vícios, heranças, obsessões amorosas e uma carta reveladora deixada por miss Ferrars compõem o cenário desta surpreendente trama, cujo transcorrer elenca novos suspeitos a todo instante, exigindo a habitual perspicácia do detetive Poirot em seu retorno ao mundo das investigações. O assassinato de Roger Ackroyd é um dos mais famosos romances policiais da rainha do crime.",
  },
  {
    nome: "Filhos de Duna",
    autores: ["Frank Herbert"],
    editora: "Editora Aleph",
    ano: 1976,
    sinopse: "Nove anos após os acontecimentos de Messias de Duna, o Imperium finalmente superou sua crise política e se estabilizou. Mas Arrakis não está seguro. Antigos inimigos e velhas ameaças retornam, deixando o planeta à mercê de traições e revoltas enquanto o governo regencial aguarda seus poderosos herdeiros por direito. Em meio a um embate geracional de nível planetário e à maior crise política já vista, surge a misteriosa figura do Pregador, com a promessa de resgatar as tradições de Duna. Filhos de Duna fecha com brilhantismo o arco de história iniciado no épico Duna e em sua sequência, Messias de Duna, retomando temas políticos e existenciais, com a já conhecida maestria de Frank Herbert.",
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
  
  s = Sinopse.new({ :texto => livro[:sinopse] })
  s.livro = l
  l.editora = editora
  l.save
  s.save
end
