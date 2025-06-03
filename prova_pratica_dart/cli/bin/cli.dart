import 'dart:convert';
import 'dart:core';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Curso {
  int id;
  String descricao;
  List<Professor> professores = [];
  List<Disciplina> disciplinas = [];
  List<Aluno> alunos = [];

  Curso(this.id, this.descricao);

  void adicionarProfessor(Professor professor) {
    professores.add(professor);
  }

  void adicionarDisciplina(Disciplina disciplina) {
    disciplinas.add(disciplina);
  }

  void adicionarAluno(Aluno aluno) {
    alunos.add(aluno);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'descricao': descricao,
        'professores': professores.map((p) => p.toJson()).toList(),
        'disciplinas': disciplinas.map((d) => d.toJson()).toList(),
        'alunos': alunos.map((a) => a.toJson()).toList(),
      };
}

class Professor {
  int id;
  String codigo;
  String nome;
  List<Disciplina> disciplinas = [];

  Professor(this.id, this.codigo, this.nome);

  void adicionarDisciplina(Disciplina disciplina) {
    disciplinas.add(disciplina);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'codigo': codigo,
        'nome': nome,
        'disciplinas': disciplinas.map((d) => d.toJson()).toList(),
      };
}

class Disciplina {
  int id;
  String descricao;
  int qtdAulas;

  Disciplina(this.id, this.descricao, this.qtdAulas);

  Map<String, dynamic> toJson() => {
        'id': id,
        'descricao': descricao,
        'qtdAulas': qtdAulas,
      };
}

class Aluno {
  int id;
  String nome;
  String matricula;

  Aluno(this.id, this.nome, this.matricula);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'matricula': matricula,
      };
}

void main() async{
  // disciplinas
  var d1 = Disciplina(1, 'Arquitetura de computadores', 80);
  var d2 = Disciplina(2, 'Segurança de redes', 40);
  var d3 = Disciplina(3, 'Desenvolvimento Web', 80);

  // professores
  var p1 = Professor(1, 'AXS', 'Linus Torvalds');
  var p2 = Professor(2, 'LLL', 'Mateus Almeida');

  p1.adicionarDisciplina(d1);
  p1.adicionarDisciplina(d2);
  p2.adicionarDisciplina(d3);

  // alunos
  var al1 = Aluno(1, "Maria", "LAS");
  var al2 = Aluno(2, "Marcos", "LSK");

  var curso = Curso(1, "Morte Lenta");

  curso.adicionarProfessor(p1);
  curso.adicionarProfessor(p2);

  curso.adicionarDisciplina(d2);
  curso.adicionarDisciplina(d3);

  curso.adicionarAluno(al1);
  curso.adicionarAluno(al2);

  var response = JsonEncoder.withIndent(' ').convert(curso.toJson());

  //print(response);
  // preparando o email
  final myEmail = 'mateus.almeida.torres07@aluno.ifce.edu.br';
  final password = 'dwkb verl dfcz ibxv'; // senha de app
  final smtpServer = gmail(myEmail, password);

  final destino = 'taveira@ifce.edu.br';
  //final destino = 'mateus12092004@gmail.com';


  final message = Message()
    ..from = Address(myEmail, 'Mateuzinho Dev')
    ..recipients.add(destino)
    ..subject = 'prova_pratica_dart'
    ..text = response;

    try{
      final sendReport = await send(message, smtpServer);
        print('E-mail enviado para $destino: ${sendReport.toString()}');
        await Future.delayed(Duration(seconds: 1)); // evita bloqueios rápidos
      } on MailerException catch (e) {
        print('Erro ao enviar e-mail para $destino: ${e.toString()}');
      }


}