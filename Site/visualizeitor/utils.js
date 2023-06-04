// Arquivo auziliar para o index.html
const MATERIAS_BCC = [
  ["CI068", "CI210", "CI212", "CI215", "CI162", "CI163", "CI221", "OPT"],
  ["CI055", "CI056", "CI057", "CI062", "CI065", "CI165", "CI211", "OPT"],
  ["CM046", "CI067", "CI064", "CE003", "CI059", "CI209", "OPT", "OPT"],
  ["CM045", "CM005", "CI237", "CI058", "CI061", "CI218", "OPT", "OPT"],
  ["CM201", "CM202", "CI166", "CI164", "SA214", "CI220", "TG I", "TG II"]
];
// salva o número de optativas já adicionadas
var NUM_OPTS = 0;

// com base em https://stackoverflow.com/questions/20853219/how-to-read-xml-file-using-filereader-javascript
function leArquivo(arquivo, input, alunos) {
  var reader = new FileReader();
  reader.readAsText(arquivo);

  reader.onloadend = function () {
    parser = new DOMParser();
    var xmlDoc = parser.parseFromString(reader.result, "text/xml");
    x = xmlDoc.documentElement.childNodes;
    alunos.limpa();
    // pega as entradas do xml e as transforma em objeto
    for (var item of x) {
      if (item.nodeType == 1) {
        var obj = {};
        for (var i of item.children) {
          var campo = i.tagName.toLowerCase(); // só pq não gosto dos campos em maiúsculo
          obj[campo] = i.textContent;
        }
        alunos.insere(obj);
      }
    }
    atualizaSeletor(input, alunos);
    alunos.ordena();
  };
}

// dado o campo da situacao da matéria, retorna a classe para deixar colorido
// retorna a classe 
function classeMateria(situacao) {
  var str = situacao.toLowerCase();

  if (str.includes("aprovado")) {
    return "aprovado";
  } else if (str.includes("repr")) {
    return "reprovado";
  } else if (str.includes("matrícula") || str.includes("matricula")) {
    return "matriculado";
  } else if (str.includes("equivale")) {
    return "equivalencia";
  } else if (str.includes("tr. total")) {
    return "trancamento";
  }
  return "";
}

// retorna código HTML de cada uma das células da tabela de matérias
// parâmetros:
// codigo: código da matéria (em MATERIAS_BCC) 
// materias: Materias do aluno
// retorna o código HTML gerado
function geraCelulaObrig(codigo, materias) {
  var l_materias = null;
  // o primeiro campo de classe determina qual "tipo" de Materia teremos
  // (definido na construção da classe Materia) 
  var classe = "";

  switch (codigo) {
    case "OPT":
      const chaves = Object.keys(materias.optativas);
      if (NUM_OPTS < chaves.length) {
        var cod = chaves.at(NUM_OPTS)
        l_materias = materias.optativas[cod];
        NUM_OPTS += 1;
        classe = "optativas ";
      }
      break;
    case "TG I":
      l_materias = materias.tg1;
      classe = "tg1 ";
      break;
    case "TG II":
      l_materias = materias.tg2;
      classe = "tg2 ";
      break;
    default:
      l_materias = materias.obrigatorias[codigo];
      classe = "obrigatorias ";
  }
  // se a matéria é encontrada... 
  if (l_materias != null && l_materias.length > 0) {
    classe += classeMateria(l_materias.at(-1).sigla);
    let id = classe == "" ? "" : l_materias.at(-1).cod_ativ_curric;
    return `<td class="${classe} celula" id="${id}"> ${codigo} </td>`;
  }
  return `<td> ${codigo} </td>`;
}

// Cria o código HTML de toda a tabela de "Outras matérias"
// parâmetros:
// outras_materias: Objeto de tipo "outras" de Materias
// retorna o código HTML gerado
function geraTabelaOutras(outras_materias) {
  if (outras_materias == undefined)
    return "";
  const chaves = Object.keys(outras_materias);
  var num_chaves = chaves.length;

  var codigo = "";
  var l_materias = null;

  let num_linhas = Math.ceil(num_chaves / 8);
  // matemática maluca pra fazer a tabela de outras 
  // com 8 matérias por linha
  for (let i = 0; i < num_linhas; i++) {
    codigo += "<tr>";
    var j = 0;
    for (; i * 8 + j < num_chaves && j < 8; j++) {
      let cod_mat = chaves[i * 8 + j];
      l_materias = outras_materias[cod_mat];
      let classe = classeMateria(l_materias.at(-1).sigla);
      let id = l_materias.at(-1).cod_ativ_curric;
      codigo += `<td class="outras ${classe} celula" id="${id}"> ${id} </td>`;
    }
    // colspan se sobrarem colunas e deixar minimamente mais bonito
    if (j < 8 && i > 0) {
      let spam = 8 - j;
      codigo += `<td colspan="${spam}">  </td>`;
    }
    codigo += "</tr>";
  }
  return codigo;
}

// Desenha as grades de matérias obrigatórias e outras
// parâmetros:
// obrigatorias: objeto jQuery da tabela "Obrigatórias"
// outras: objeto jQuery da tabela "Outras Disciplinas"
// materias: objeto Materias 
function desenhaGrade(obrigatorias, outras, materias = null) {
  var celulas_obg = "";
  var celulas_outras = "";
  NUM_OPTS = 0;
  // construir a grade curricular colorida só se tiver matérias
  if (materias == null || materias == undefined) {
    for (let l_materias of MATERIAS_BCC) {
      celulas_obg += "<tr>";
      for (let materia of l_materias) {
        celulas_obg += `<td> ${materia} </td>`;
      }
      celulas_obg += "</tr>";
    }
  }
  else {
    for (let l_materias of MATERIAS_BCC) {
      celulas_obg += "<tr>";
      for (let materia of l_materias) {
        celulas_obg += geraCelulaObrig(materia, materias);
      }
      celulas_obg += "</tr>";
    }
    celulas_outras = geraTabelaOutras(materias.outras);
  }
  obrigatorias.html(celulas_obg);
  outras.html(celulas_outras);
}

// Atualiza as opções de seleção de GRRs com base nos alunos criados 
// parâmetros:
// seletor: objeto jQuery do dropdown de opções de GRR
function atualizaSeletor(seletor, alunos) {
  var opcoes = "";
  const listaGRR = alunos.getGRRs();
  for (let grr of listaGRR) {
    opcoes += `<option value="${grr}">`;
  }
  // não foi criado o novo html...
  if (opcoes == "") {
    opcoes += '<option value="Carregue um arquivo">';
  }
  seletor.html(opcoes);
}

// gera o código HTML do conteúdo a ser exibido dentro do modal 
// parâmetros:
// modal: objeto jQuery do modal em que será adicionado HTML
// obj_titulo: objeto jQuery do campo do título do modal 
// materias: objeto Materias 
// classe: string com "tipo" da matéria a ser exibida, definido pela primeira classe da célula da matéria
// id: string com id da célula da matéria a ser exibida
// todas: boolean determinando se devem ser exibidas todas as vezes que a matéria foi cursada ou somente a última
function geraModal(modal, obj_titulo, materias, classe, id, todas) {
  var codigo = "";
  var vet_mat = materias[classe];
  // se a classe não é vetor (como no caso de ser um dos tgs, por exemplo),
  // então com o campo id passa a ser
  if (!Array.isArray(vet_mat))
    vet_mat = vet_mat[id];

  if (!todas) { // tela com somente a última vez que a matéria foi feita
    const info_mat = vet_mat.at(-1);
    obj_titulo.html(info_mat.nome_ativ_curric);
    // transforma a presença de um float doido pra algo legível
    var freq = parseFloat(info_mat.frequencia.replace(',', '.')).toFixed(2).replace('.', ',');
    codigo = `
      <span class="fw-bold"> Código: </span> ${info_mat.cod_ativ_curric} <br>
      <span class="fw-bold"> Última vez cursada: </span> ${info_mat.ano}/${info_mat.periodo} <br>
      <span class="fw-bold"> Nota: </span> ${info_mat.media_final} <br>
      <span class="fw-bold"> Frequência: </span> ${freq}% <br>
      <span class="fw-bold"> Situação: </span> ${info_mat.situacao} <br>
    `;
  } else {
    obj_titulo.html(vet_mat[0].nome_ativ_curric);
    codigo += `
      <span class="fw-bold"> Código: </span> ${vet_mat[0].cod_ativ_curric} <br>
      <div class="accordion" id="acordeao" style="margin-top: 10px;">
    `;
    var i = 0;
    for (const info_mat of vet_mat) {
      let heading = "heading" + i.toString();
      let collapse = "collapse" + i.toString();
      // transforma a presença de um float doido pra algo legível
      var freq = parseFloat(info_mat.frequencia.replace(',', '.')).toFixed(2).replace('.', ',');
      codigo += `
        <div class="accordion-item">
          <h2 class="accordion-header" id="${heading}">
            <button 
              class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#${collapse}"
              aria-controls="${collapse}"
            >
            ${info_mat.ano}/${info_mat.periodo}
            </button>
          </h2>
          <div id="${collapse}" class="accordion-collapse collapse" aria-labelledby="${heading}"
            data-bs-parent="#acordeao">
            <div class="accordion-body">
              <span class="fw-bold"> Nota: </span> ${info_mat.media_final} <br>
              <span class="fw-bold"> Frequência: </span> ${freq}% <br>
              <span class="fw-bold"> Situação: </span> ${info_mat.situacao} <br>
            </div>
          </div>
        </div>
      `;
      i++;
    }
    codigo += "</div>";
  }
  modal.html(codigo);
}