
const MATERIAS_BCC = [
    ["CI068", "CI210", "CI212", "CI215", "CI162", "CI163", "CI221", "OPT"],
    ["CI055", "CI056", "CI057", "CI062", "CI065", "CI165", "CI211", "OPT"],
    ["CM046", "CI067", "CI064", "CE003", "CI059", "CI209", "OPT", "OPT"],
    ["CM045", "CM005", "CI237", "CI058", "CI061", "CI218", "OPT", "OPT"],
    ["CM201", "CM202", "CI166", "CI164", "SA214", "CI220", "TG I", "TG II"]
];



function leArquivo(arquivo, alunos) {
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
    };
}


function desenhaGrade(obrigatorias, outras, materias = null) {
    var html = "";

    for (const l_materias of MATERIAS_BCC) {
        html += "<tr>";

        for (const materia of l_materias) {
            html += `<td> ${materia} </td>`;
        }

        html += "</tr>";
    }
    obrigatorias.html(html);
}

function atualizaSeletor(seletor, alunos){

}