import 'package:flutter/material.dart';

class ElevatorCard extends StatelessWidget {
  final String title;
  final String status;
  final int currentFloor;
  final IconData directionIcon;
  final bool isActive;
  final VoidCallback onTap;

  const ElevatorCard({
    super.key,
    required this.title,
    required this.status,
    required this.currentFloor,
    required this.directionIcon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey[400],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.elevator,
              size: 50,
              color: isActive ? Colors.blue : Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              status,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Étage actuel : $currentFloor',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Icon(
              directionIcon,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
