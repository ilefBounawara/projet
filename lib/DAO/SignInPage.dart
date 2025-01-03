import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Importez ici la page de paiement
import 'package:smart_ascenseur/DAO/PaymentPage.dart'; // Remplacez par le bon chemin du fichier

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Méthode pour valider l'email
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Afficher une alerte si un champ est vide
      _showErrorDialog('Veuillez remplir tous les champs.');
      return;
    }

    if (!_isValidEmail(email)) {
      // Afficher une alerte si l'email est invalide
      _showErrorDialog('Veuillez entrer une adresse email valide.');
      return;
    }

    // Si tout est valide, naviguer vers la page de paiement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentPage()),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 212, 216, 250), // Bleu clair en fond
      body: Stack(
        children: [
          // Cercle décoratif en haut à gauche
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3A4D7A).withOpacity(0.2),
              ),
            ),
          ),
          // Cercle décoratif en bas à droite
          Positioned(
            bottom: -80,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3A4D7A).withOpacity(0.2),
              ),
            ),
          ),
          // Contenu principal
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo couronne et titre
                  Column(
                    children: [
                      Image.asset(
                        'crownuser.png', // Assurez-vous que le chemin de l'image est correct
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Se connecter\nà votre compte',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poiretOne(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3A4D7A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Champs Email et Mot de Passe
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Mot de passe',
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Bouton
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3A4D7A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Se connecter',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
