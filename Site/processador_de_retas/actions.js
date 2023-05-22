const POLYSIZE = 40;
const LINHAS = [];

function criaLinha(coord1, coord2) {
    var linha = new Linha(coord1, coord2);
    LINHAS.push(linha);
    return linha;
}


function desenha(canvas, ctx) {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (const l of LINHAS) {
        ctx.strokeStyle = l.cor;
        ctx.stroke(l.path);
    }
}


function apagaLinhas(canvas, ctx) {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    LINHAS.length = 0;
}

function divideLinha(coord, linha) {
    var nova_linha = criaLinha(coord, linha.coords[1]);
    linha.atualizaCoords(coord, linha.coords[0]);
    return nova_linha;
}


function obtemLinha(mouse_event, ctx) {
    for (var l of LINHAS) {
        if (l.mouseMatch(mouse_event, ctx)) {
            return l;
        }
    }
    return null;
}

function atualizaCores(cor){

    for (var l of LINHAS) {
        l.cor = cor;
    }

}


// baseado em http://www.scienceprimer.com/drawing-regular-polygons-javascript-canvas

function criarPoligono(canvas, ctx, sides) {
    // posições centrais do canvas
    const posX = parseInt(canvas.width / 2);
    const posY = parseInt(canvas.height / 2);

    for (let i = 0; i < sides; i++) {
        let coord1 = {
            x: posX + POLYSIZE * Math.cos(i * 2 * Math.PI / sides),
            y: posY + POLYSIZE * Math.sin(i * 2 * Math.PI / sides),
        };
        let coord2 = {
            x: posX + POLYSIZE * Math.cos((i + 1) * 2 * Math.PI / sides),
            y: posY + POLYSIZE * Math.sin((i + 1) * 2 * Math.PI / sides),
        };
        criaLinha(coord1, coord2);
    }
    desenha(canvas, ctx);
}