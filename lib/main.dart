import 'package:flutter/material.dart';
import 'package:smart_ascenseur/DAO/DirectionPage.dart';
import 'package:smart_ascenseur/DAO/ElevatorListPage.dart';
import 'package:smart_ascenseur/DAO/EtageActuelPage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:smart_ascenseur/DAO/ElevatorInfoPage.dart';
import 'package:smart_ascenseur/DAO/SplashScreen.dart';
import 'package:smart_ascenseur/DAO/SignInPage.dart';
import 'package:smart_ascenseur/DAO/PaymentPage.dart';
import 'package:smart_ascenseur/DAO/CreditCardPaymentPage.dart'; // Modèle détaillé des paiements par carte de crédit
import 'package:smart_ascenseur/DAO/CashPaymentFormPage.dart'; // Modèle détaillé des paiements par carte de crédit

void main() {
  // Initialisation du WebSocketChannel
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:5039/ws'), // Adresse WebSocket
  );

  runApp(MyApp(channel: channel));
}

class MyApp extends StatelessWidget {
  final WebSocketChannel channel;

  const MyApp({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ascenseur',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // Écran de démarrage
        '/': (context) => const SplashScreen(),

        // Page des étages actuels (avec WebSocketChannel)
        '/etage': (context) => EtageActuelPage(channel: channel),

        // Page de direction (avec WebSocketChannel)
        '/direction': (context) => DirectionPage(channel: channel),

        // Liste des ascenseurs
        '/elevator_list': (context) => ElevatorListPage(channel: channel),

        // Informations sur un ascenseur spécifique
        '/elevatorInfo': (context) => ElevatorInfoPage(
              elevatorData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/sign_in': (context) =>
            const SignInPage(), // Ajoutez la route pour la page de connexion
        '/payment': (context) =>
            const PaymentPage(), // Ajoutez la route pour la page de paiement
        '/credit_card_payment': (context) =>
            const CreditCardPaymentPage(), // Page de paiement par carte
        '/cash_payment': (context) =>
            const CashPaymentFormPage(), // Page de paiement par carte
      },
    );
  }
}
