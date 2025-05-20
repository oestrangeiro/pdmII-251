import 'dart:io';

int main() {
  dynamic userName = '';

  stdout.write("*** Entrez avec votre nom:\n>> ");
  userName = stdin.readLineSync();

  stdout.write("*** Donc, est-ce que votre nom c\'est: \'$userName\'?\n");
  stdout.write("\t[1] Oui!\n\t[2] Non, c'est pas correcte!\n");

  return 0;
}
