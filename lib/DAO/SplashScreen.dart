import 'package:flutter/material.dart';
import 'dart:async'; // Import pour utiliser Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Naviguer après 3 secondes
    Timer(const Duration(seconds: 3), () {
      //Navigator.pushReplacementNamed(context, '/etage');
      Navigator.pushReplacementNamed(context, '/elevator_list');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F3C4B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg', // Chemin vers votre logo
              height: 140,
              width: 140,
            ),
            const SizedBox(height: 20),
            const Text(
              'SMART ASCENSEUR',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 30),
            // Ajout de l'indicateur de chargement
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
