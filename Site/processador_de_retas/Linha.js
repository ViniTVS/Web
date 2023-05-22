
// calcula a distância entre dois pontos
function calculaDistancia(coord1, coord2) {
    let h = coord1.x - coord2.x;
    let v = coord1.y - coord2.y;
    let result = Math.sqrt(h * h + v * v);
    return result;
}


const EDGE_MARGIN = 20;

class Linha {
    constructor(coord1, coord2) {
        var path = new Path2D();
        path.moveTo(coord1.x, coord1.y);
        path.lineTo(coord2.x, coord2.y);
        // line edges
        this.coords = [coord1, coord2];
        this.path = path;
        this.cor = COR_PADRAO;
    }

    atualizaCoords(coord1, coord2) {
        var path = new Path2D();
        path.moveTo(coord1.x, coord1.y);
        path.lineTo(coord2.x, coord2.y);
        // line edges
        this.coords = [coord1, coord2];
        this.path = path;
    }

    mouseMatch(mouse_event, ctx) {
        if (this.path) {
            return ctx.isPointInStroke(this.path, mouse_event.offsetX, mouse_event.offsetY);
        }
        return null;
    }


    canto(coord) {
        const dist1 = calculaDistancia(coord, this.coords[0]);
        const dist2 = calculaDistancia(coord, this.coords[1]);
        // ponta da coord1
        if (dist1 <= EDGE_MARGIN && dist1 <= dist2) {
            return 0;
        } // ponta da coord2
        else if (dist2 <= EDGE_MARGIN) {
            return 1;
        }
        return 2;
    }
}