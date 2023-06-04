// Classe para armazenar os dados de todos os alunos
class Alunos {
  campos_aluno = [
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
    this.alunos = {};
  }

  insere(dados) {
    var matr_aluno = dados["matr_aluno"];

    var materia = {};
    var aluno = {};
    // cria a entrada da materia com os campos de matéria
    // (ou seja, que não pertencem ao aluno)
    for (let key of Object.keys(dados)) {
      if (!(this.campos_aluno.includes(key))) {
        materia[key] = dados[key];
      }
    }
    // cria entrada do aluno se não existe
    if (!(matr_aluno in this.alunos)) {
      for (let campo of this.campos_aluno) {
        aluno[campo] = dados[campo];
      }
      aluno["materias"] = new Materias();
      // e o inclui nos alunos cadastrados
      this.alunos[matr_aluno] = aluno;
    }
    // adiciona a matéria do aluno
    this.alunos[matr_aluno]["materias"].insere(materia);
  }
  // Imprime no console.log os dados dos alunos
  imprime() {
    for (let key of Object.keys(this.alunos)) {
      console.log(this.alunos[key]);
      this.alunos[key]["materias"].imprime();
    }
  }
  // "Apaga" os alunos salvos
  limpa() {
    this.alunos = {};
  }
  // Retorna os GRRs de todos os alunos solvos
  getGRRs() {
    return Object.keys(this.alunos);
  }
  // Ordena as matérias de todos os alunos salvos de acordo com semestre/ano cursado
  ordena() {
    const listaGRR = this.getGRRs();
    for (let grr of listaGRR) {
      this.alunos[grr]["materias"].ordena();
    }
  }
  // Retorna os dados de um aluno com base em seu GRR
  getAluno(GRR) {
    return this.alunos[GRR];
  }
}