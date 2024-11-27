import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    // Instance WebSocketChannel partagée entre les pages
    final channel = WebSocketChannel.connect(
        Uri.parse('http://localhost:5039')); // URL à adapter
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
            ElevatorListPage(), // Page de la liste d'ascenseurs
        '/elevatorInfo': (context) =>
            const ElevatorInfoPage(), // Détails d'un ascenseur
      },
    );
  }
}
