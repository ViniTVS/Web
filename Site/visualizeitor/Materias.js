





class Materias {
  constructor() {
    this.obrigatorias = {};
    this.optativas = {};
    this.outras = {};
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
    var materias = { };

    const tipo = dados["descr_estrutura"];
    // ve o tipo de matéria
    if(tipo == "Obrigatórias"){
      materias = this.obrigatorias;
    } else if (tipo == "Optativas"){
      materias = this.optativas;
    } else {
      materias = this.outras;
    }

    const atividade = dados["cod_ativ_curric"];
    // insere no tipo necessário
    if (!(atividade in materias)){
      materias[atividade] = [];
    }
    materias[atividade].push(dados);

  }



  imprime(){
    console.log("Obrigatórias:", this.obrigatorias);
    console.log("Optativas:", this.optativas);
    console.log("Outras:", this.outras);
  }
}