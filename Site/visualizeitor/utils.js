
const MATERIAS_BCC = [
    ["CI068", "CI210", "CI212", "CI215", "CI162", "CI163", "CI221", "OPT"],
    ["CI055", "CI056", "CI057", "CI062", "CI065", "CI165", "CI211", "OPT"],
    ["CM046", "CI067", "CI064", "CE003", "CI059", "CI209", "OPT", "OPT"],
    ["CM045", "CM005", "CI237", "CI058", "CI061", "CI218", "OPT", "OPT"],
    ["CM201", "CM202", "CI166", "CI164", "SA214", "CI220", "TG I", "TG II"]
];

// const CAMPOS_DEC = ["id_curso_aluno", "id_versao_curso", "creditos", "ch_total", "id_nota"];

var NUM_OPTS = 0;


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
                    var campo = i.tagName.toLowerCase();
                    obj[campo] = i.textContent;
                }
                alunos.insere(obj);
            }
        }
        atualizaSeletor(input, alunos);
        alunos.ordena();
    };
}


function classeMateria(situacao) {
    var str = situacao.toLowerCase();

    if (str.includes("aprovado")) {
        return "aprovado";
    } else if (str.includes("repr")) {
        return "reprovado";
    } else if (str.includes("matrícula") || str.includes("matricula")) {
        return "matriculado";
    } else if (str.includes("equivale")){
        return "equivalencia";
    } 
    return "";
}


function geraCelulaObrig(codigo, materias) {
    var l_materias = null;

    switch (codigo) {
        case "OPT":
            const chaves = Object.keys(materias.optativas);
            if(NUM_OPTS < chaves.length){
                var cod = chaves.at(NUM_OPTS)
                l_materias = materias.optativas[cod];
                NUM_OPTS += 1;
            }
            break;
        case "TG I":
            l_materias = materias.tg1;
            break;
        case "TG II":
            l_materias = materias.tg2;
            break;
        default:
            l_materias = materias.obrigatorias[codigo];
    }
    
    if (l_materias != null && l_materias.length > 0) {
        let classe = classeMateria(l_materias.at(-1).sigla);
        
        return `<td class="${classe}" > ${codigo} </td>`;
    }
    return `<td> ${codigo} </td>`;
    

}



function desenhaGrade(obrigatorias, outras, materias = null) {
    var celulas = "";
    NUM_OPTS = 0;
    // 
    if (materias == null || materias == undefined) {
        for (let l_materias of MATERIAS_BCC) {
            celulas += "<tr>";
            for (let materia of l_materias) {
                celulas += `<td> ${materia} </td>`;
            }
            celulas += "</tr>";
        }
    }
    else {
        for (let l_materias of MATERIAS_BCC) {
            celulas += "<tr>";
            for (let materia of l_materias) {
                celulas += geraCelulaObrig(materia, materias);
            }
            celulas += "</tr>";
        }
    }
    obrigatorias.html(celulas);
}

function atualizaSeletor(seletor, alunos) {
    var opcoes = "";
    const listaGRR = alunos.getGRRs();

    for (let grr of listaGRR) {
        opcoes += `<option value="${grr}"> ${grr} </option>`;
    }
    // não foi criado o novo html...
    if (opcoes == "") {
        opcoes += '<option value=""> Carregue um arquivo </option>';
    } else {
        opcoes = '<option value="">  </option>' + opcoes;
    }
    seletor.html(opcoes);
}