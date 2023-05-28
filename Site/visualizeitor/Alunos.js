





class Alunos {
    campos_aluno = [
        "ano",
        "cod_curso",
        "conceito",
        "id_curso_aluno",
        "id_estrutura_cur",
        "id_local_dispensa",
        "id_versao_curso",
        "matr_aluno",
        "nome_aluno",
        "nome_curso"
    ];

    constructor() {
        this.usuarios = {};
    }
    // ano: "2011"
    // ch_total: ""
    // cod_ativ_curric: "TP052"
    // cod_curso: "21A"
    // conceito: ""
    // creditos: ""
    // descr_estrutura: ""
    // frequencia: ""
    // id_ativ_curric: "20428"
    // id_curric_aluno: "5754485"
    // id_curso_aluno: "32306"
    // id_estrutura_cur: ""
    // id_local_dispensa: ""
    // id_nota: ""
    // id_versao_curso: "308"
    // matr_aluno: "GRR00000012"
    // media_credito: ""
    // media_final: "9999"
    // nome_aluno: "ALUNO 12"
    // nome_ativ_curric: "Pesquisa Operacional I"
    // nome_curso: "Curso de Ciência da Computação - Bacharelado"
    // num_versao: "1998"
    // periodo: "1o. Semestre"
    // sigla: ""
    // situacao: "Equivalência de Disciplina"
    // situacao_curriculo: ""
    // situacao_item: "11"
    insere(dados) {
        var matr_aluno = dados["matr_aluno"];

        var materia = {};
        var aluno = {};

        // cria a entrada da materia com os campos que não pertencem ao aluno
        for (const key of Object.keys(dados)) {
            if (!(this.campos_aluno.includes(key))) {
                materia[key] = dados[key];
            }
        }


        // cria entrada do aluno se não existe
        if (!(matr_aluno in this.usuarios)) {
            for (const campo of this.campos_aluno) {
                aluno[campo] = dados[campo];
            }
            aluno["materias"] = new Materias(); 
            // e o inclui nos alunos cadastrados
            this.usuarios[matr_aluno] = aluno;
        }

        // adiciona a matéria do aluno
        this.usuarios[matr_aluno]["materias"].insere(materia);
    }

    imprime() {
        for (const key of Object.keys(this.usuarios)) {
            console.log(this.usuarios[key]);
            this.usuarios[key]["materias"].imprime();
        }

    }
    limpa() {
        this.usuarios = {};
    }

    getGRRs(){
        return Object.keys(this.usuarios);
    }

}