import 'package:flutter/material.dart';
import 'package:smart_ascenseur/DAO/ElevatorListPage.dart';
import 'package:web_socket_channel/web_socket_channel.dart'; // Remplacez par le bon chemin si différent

void main() {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:5039/ws'), // Adresse WebSocket
  );

  runApp(MyApp(channel: channel));
}

class MyApp extends StatelessWidget {
  final WebSocketChannel channel;

  const MyApp({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ElevatorListPage(channel: channel),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  // Connexion au serveur WebSocket
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:5039/ws'), // Remplacez localhost par 10.0.2.2 si vous êtes sur un émulateur Android
  );

  runApp(MyApp(channel: channel));
}

class MyApp extends StatelessWidget {
  final WebSocketChannel channel;

  const MyApp({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebSocketTestPage(channel: channel),
    );
  }
}

class WebSocketTestPage extends StatelessWidget {
  final WebSocketChannel channel;

  const WebSocketTestPage({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test WebSocket'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // StreamBuilder pour afficher les messages reçus
            Expanded(
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("Connexion en cours..."));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erreur : ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Center(
                      child: Text(
                        'Message reçu : ${snapshot.data}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return const Center(child: Text("Aucun message reçu."));
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            // TextField pour envoyer des messages
            
          ],
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:smart_ascenseur/DAO/DirectionPage.dart';
import 'package:smart_ascenseur/DAO/ElevatorInfoPage.dart';
import 'package:smart_ascenseur/DAO/ElevatorListPage.dart';
import 'package:smart_ascenseur/DAO/EtageActuelPage.dart';
import 'package:smart_ascenseur/DAO/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
   {
    final channel = IOWebSocketChannel.connect('http://localhost:5039');

    // Instance WebSocketChannel partagée entre les pages
    //final channel = WebSocketChannel.connect(Uri.parse('http://localhost:5039')); // URL à adapter
    //ws://localhost:5000
    // ID de l'ascenseur à envoyer au WebSocket
    //const int elevatorId = 1;

    // Envoyer l'ID de l'ascenseur une fois connecté
    //channel.sink.add(elevatorId.toString());

    return MaterialApp(
      title: 'Smart Ascenseur',
      debugShowCheckedModeBanner: false, // Masquer le bandeau de débogage
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Commencer à partir de Splash Screen
      routes: {
        '/': (context) => const SplashScreen(), // Page d'accueil avec logo
        //'/etage': (context) => EtageActuelPage(channel: channel), // Page des étages
        //'/direction': (context) => DirectionPage(channel: channel), // Page de la direction
        '/elevator_list': (context) =>
            ElevatorListPage(channel: channel), // Page de la liste d'ascenseurs
        //'/elevatorInfo': (context) =>const ElevatorInfoPage(), // Détails d'un ascenseur
      },
    );
  }
}
*/