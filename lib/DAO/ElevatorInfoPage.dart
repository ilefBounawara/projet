import 'package:flutter/material.dart';

class ElevatorInfoPage extends StatelessWidget {
  final Map<String, dynamic> elevatorData;

  const ElevatorInfoPage({super.key, required this.elevatorData});

  @override
  Widget build(BuildContext context) {
    // Récupérer les arguments passés via Navigator
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};

    // Données provenant des arguments
    final int currentFloor = args['currentFloor'] ?? 0;
    final String directionSelected = args['direction'] ?? 'N/A';
    final Map<String, dynamic> elevatorInfo = args['elevator'] ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFFB1C4E8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB1C4E8),
        elevation: 0,
        title: Text(
          'Informations sur ${elevatorInfo['Id'] ?? 'Ascenseur'}',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/elevator.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          elevatorInfo['Id'] ?? 'Ascenseur',
                          style: const TextStyle(
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
                    _buildInfoRow('assets/etage_actuel.jpg',
                        'Étage actuel : ${currentFloor.toString()}'),
                    _buildInfoRow('assets/poids.png',
                        'Poids actuel : ${elevatorInfo['CurrentWeight'] ?? 'N/A'} kg'),
                    _buildInfoRow('assets/poids_max.png',
                        'Capacité maximale : ${elevatorInfo['MaxWeight'] ?? 'N/A'} kg'),
                    _buildInfoRow('assets/etat.png',
                        'État : ${_getElevatorState(elevatorInfo['State'])}'),
                    _buildInfoRow('assets/direction_icon.png',
                        'Direction : ${_getElevatorDirection(elevatorInfo['Direction'])}'),
                    _buildInfoRow('assets/temps_attent.png',
                        'Temps d\'attente estimé : ${elevatorInfo['WaitTime'] ?? 'N/A'}'),
                    _buildInfoRow('assets/ventilation.jpg',
                        'Ventilation : ${elevatorInfo['Ventilation'] == '1' ? 'Activée' : 'Désactivée'}'),
                    _buildInfoRow('assets/temperature.png',
                        'Température intérieure : ${elevatorInfo['Temperature'] ?? 'N/A'}°C'),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/sign_in');
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.yellow[500]!),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Réserver',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(width: 6),
                    Image.asset(
                      'crown.png',
                      height: 16,
                      width: 16,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, color: Colors.red, size: 16),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'VIP',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(224, 255, 216, 59)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get readable elevator state
  String _getElevatorState(String? state) {
    switch (state) {
      case 'active':
        return 'En marche';
      case 'inactive':
        return 'Arrêté';
      case 'maintenance':
        return 'En maintenance';
      default:
        return 'État inconnu';
    }
  }

  // Helper method to get readable elevator direction
  String _getElevatorDirection(String? direction) {
    switch (direction) {
      case '0':
        return 'Descente';
      case '1':
        return 'Montée';
      default:
        return 'Direction inconnue';
    }
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(iconPath, height: 20, width: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
