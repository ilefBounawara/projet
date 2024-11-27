import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DirectionPage extends StatefulWidget {
  final WebSocketChannel channel;

  const DirectionPage({super.key, required this.channel});

  @override
  _DirectionPageState createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  int _selectedDirection = 0;
  int _sendDirection = 0;
  int? _activeDirection; // Variable temporaire pour l'état actif

  void _sendDirectionToServer(int direction) {
    if (direction <= 0) {
      print('Erreur : Direction invalide. Valeur: $direction');
      return; // Ne pas envoyer si la direction est invalide
    }

    try {
      // Préparer les données à envoyer
      String dataToSend = 'Direction: $direction';

      // Envoyer les données via WebSocket
      widget.channel.sink.add(dataToSend);

      // Journalisation pour débogage
      print('Données envoyées au serveur : $dataToSend');

      // Mettre à jour l'état local
      setState(() {
        _selectedDirection = direction; // Stocker la direction sélectionnée
        _activeDirection = null; // Réinitialiser l'état actif
      });

      // Retour visuel pour confirmer l'envoi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Direction envoyée avec succès : $direction'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (error) {
      // Gestion des erreurs lors de l'envoi
      print('Erreur lors de l\'envoi des données : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'envoi des données : $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C7693), // Couleur de fond (bleu-gris)
      appBar: AppBar(
        title: const Text('Sélectionnez une Direction'),
        backgroundColor: const Color(0xFFD9D9D9),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choisier Directions :',
            style: GoogleFonts.ramaraja(
              fontSize: 30, // Taille du texte
              fontWeight: FontWeight.bold, // Style gras
              color: Colors.white, // Couleur bleu clair
              letterSpacing: 2.0, // Espacement entre lettres
              wordSpacing: 4.0, // Espacement entre mots
              shadows: [
                const Shadow(
                  offset: Offset(3, 3), // Décalage de l’ombre
                  blurRadius: 6, // Intensité du flou
                  color: Colors.black26, // Ombre plus sombre
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Liste des directions sous forme de Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i <= 2; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTapDown: (_) {
                      // Activer la couleur temporaire lors du clic
                      setState(() {
                        _activeDirection = i;
                      });
                    },
                    onTapUp: (_) {
                      // Réinitialiser la couleur temporaire après le clic
                      setState(() {
                        _sendDirection = _activeDirection!;
                      });
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: _activeDirection == i
                              ? Colors.black // Couleur temporaire lors du clic
                              : (i == _selectedDirection
                                  ? Colors
                                      .black // Couleur pour la direction actuelle
                                  : Colors.grey[400]), // Couleur inactive
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$i',
                          style: GoogleFonts.ramaraja(
                            fontSize: 30, // Taille du texte
                            fontWeight: FontWeight.bold, // Style gras
                            color: Colors.white, // Couleur bleu clair
                            letterSpacing: 2.0, // Espacement entre lettres
                            wordSpacing: 4.0, // Espacement entre mots
                            shadows: [
                              const Shadow(
                                offset: Offset(3, 3), // Décalage de l’ombre
                                blurRadius: 6, // Intensité du flou
                                color: Colors.black26, // Ombre plus sombre
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
          const SizedBox(height: 40),
          // Bouton pour naviguer vers la page suivante
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[400], // Couleur du bouton
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              _sendDirectionToServer(_sendDirection);
              Navigator.pushNamed(context, '/elevator_list');
            },
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
