import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

void main() async {
  final myEmail = 'mateus.almeida.torres07@aluno.ifce.edu.br';
  final password = 'dwkb verl dfcz ibxv'; // senha de app
  final smtpServer = gmail(myEmail, password);

  final List<String> destinatarios = [
    'levi.faleh61@aluno.ifce.edu.br',
    'ana.menezes62@aluno.ifce.edu.br',
    'braga.tabosa09@aluno.ifce.edu.br',
    'francisco.charlison09@aluno.ifce.edu.br',
    'clara.ribeiro09@aluno.ifce.edu.br',
    'riquelmy.ricarte08@aluno.ifce.edu.br',
    'miguel.ribeiro07@aluno.ifce.edu.br',
    'carvalho.urano05@aluno.ifce.edu.br',
    'gustavo.fontenele04@aluno.ifce.edu.br',
    'gabriel.joao61@aluno.ifce.edu.br',
    'gabriel.tito09@aluno.ifce.edu.br',
    'glaive.fernandes63@aluno.ifce.edu.br',
    'pedro.barbosa40@aluno.ifce.edu.br',
    'gleicy.kelli.batista63@aluno.ifce.edu.br',
    'emanuel.leon10@aluno.ifce.edu.br',
    'arthur.santos08@aluno.ifce.edu.br',
    'ismael.nascimento08@aluno.ifce.edu.br',
    'ana.candido09@aluno.ifce.edu.br',
    'santos.nascimento62@aluno.ifce.edu.br',
    'pedro.pereira62@aluno.ifce.edu.br',
    'andre.luiz60@aluno.ifce.edu.br',
    'ana.luiza15@aluno.ifce.edu.br',
    'kayvila.souza63@aluno.ifce.edu.br',
    'joao.marcelo62@aluno.ifce.edu.br',
    'brenda.gonzaga07@aluno.ifce.edu.br',
    'brenno.nogueira09@aluno.ifce.edu.br',
    'ana.sena62@aluno.ifce.edu.br',
    'joao.andrade09@aluno.ifce.edu.br',
    'pedro.joao10@aluno.ifce.edu.br',
    'isaac.magalhaes07@aluno.ifce.edu.br',
    'saul.ramos07@aluno.ifce.edu.br',
    'caua.rodrigues08@aluno.ifce.edu.br',
    'raul.carvalho16@aluno.ifce.edu.br',
    'kaua.sousa63@aluno.ifce.edu.br',
    'yasmin.sousa07@aluno.ifce.edu.br',
    'gabriel.alencar63@aluno.ifce.edu.br',
    'francisco.thiago09@aluno.ifce.edu.br',
    'sara.silva09@aluno.ifce.edu.br',
  ];

  for (final email in destinatarios) {
    for (int i = 1; i <= 50; i++) {
      final message = Message()
        ..from = Address(myEmail, 'Mateuzinho teste de mel')
        ..recipients.add(email)
        ..subject = 'Teste $i para $email'
        ..text = 'Este é o e-mail número $i enviado para $email.';

      try {
        final sendReport = await send(message, smtpServer);
        print('E-mail $i enviado para $email: ${sendReport.toString()}');
        await Future.delayed(Duration(seconds: 1)); // evita bloqueios rápidos
      } on MailerException catch (e) {
        print('Erro ao enviar e-mail $i para $email: ${e.toString()}');
        break; // para de tentar caso um email dê erro para evitar spam
      }
    }
  }
}
