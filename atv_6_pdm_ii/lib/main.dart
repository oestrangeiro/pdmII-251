import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(117, 226, 15, 1)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Column(
        children: [
            Text('Um doidinho uma vez disse :'),
            // Text(appState.current.asLowerCase),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(pair.asLowerCase),
            ),
            // Botão
            ElevatedButton(
              onPressed: () {
                print('O bisonho pressionou o botão!'); // mostra no console que o usuário pressionou o botão
                appState.getNext();
              },
              child: Text('Clica aqui doidinho'),
            )
            
          ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(padding: const EdgeInsets.all(20),
      child: Text(pair.asLowerCase),
      ),
    );
    // return Text(pair.asLowerCase);
  }
}

