import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('alunos.db');

  // Create table if it doesn't exist
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL CHECK(length(nome) <= 50)
    );
  ''');

  while (true) {
    print('\n=== Menu ===');
    print('1 - Inserir novo aluno');
    print('2 - Listar alunos');
    print('0 - Sair');
    stdout.write('Escolha uma opção: ');
    final choice = stdin.readLineSync();

    if (choice == '1') {
      _inserirAluno(db);
    } else if (choice == '2') {
      _listarAlunos(db);
    } else if (choice == '0') {
      print('Saindo...');
      break;
    } else {
      print('Opção inválida. Tente novamente.');
    }
  }

  db.dispose();
}

void _inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (max 50 caracteres): ');
  String? nome = stdin.readLineSync();

  if (nome == null || nome.trim().isEmpty) {
    print('Nome inválido. Operação cancelada.');
    return;
  }

  nome = nome.trim();

  if (nome.length > 50) {
    print('Nome muito longo. Máximo 50 caracteres.');
    return;
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?);');
  stmt.execute([nome]);
  stmt.dispose();

  print('Aluno "$nome" inserido com sucesso.');
}

void _listarAlunos(Database db) {
  final ResultSet result =
      db.select('SELECT id, nome FROM TB_ALUNO ORDER BY id;');
  if (result.isEmpty) {
    print('Nenhum aluno cadastrado.');
    return;
  }

  print('\nLista de alunos:');
  for (final row in result) {
    print('ID: ${row['id']} - Nome: ${row['nome']}');
  }
}
