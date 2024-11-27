// Elevator Information Page
import 'package:flutter/material.dart';

class ElevatorInfoPage extends StatelessWidget {
  const ElevatorInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB1C4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1C4E8),
        elevation: 0,
        title: const Text(
            'Plus information  sur Ascenseur '), // Set dynamically if needed
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/elevator.png', // Use your elevator icon here
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Ascenseur 2',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              _buildInfoRow('assets/etage_actuel.jpg', 'Étage actuel : 5'),
              _buildInfoRow('assets/poids.png', 'Poids actuel : 650 kg'),
              _buildInfoRow(
                  'assets/poids_max.png', 'Capacité maximale : 1000 kg'),
              _buildInfoRow('assets/etat.png', 'État : En marche'),
              _buildInfoRow('assets/direction_icon.png', 'Direction : Montée'),
              _buildInfoRow('assets/temps_attent.png',
                  'Temps d\'attente estimé : 1 min 30 s'),
              _buildInfoRow('assets/ventilation.jpg', 'Ventilation : Activée'),
              _buildInfoRow(
                  'assets/temperature.png', 'Température intérieure : 22°C'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(iconPath, height: 20, width: 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
