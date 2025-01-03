import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_ascenseur/DAO/PaymentPage.dart'; // Vérifiez le chemin d'import

class CashPaymentFormPage extends StatelessWidget {
  const CashPaymentFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFCBEF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Foulen ben foulen",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            color: const Color(0xFFB5C4F0),
            height: 4,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFD5D9F9),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Formulaire de Paiement\nen Espèces",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(label: "Nom"),
              const SizedBox(height: 20),
              _buildTextField(label: "E-mail", hintText: "exemple@gmail.com"),
              const SizedBox(height: 20),
              _buildNumericField(label: "Téléphone"),
              const SizedBox(height: 30),
              const Text(
                "Date et heure d'arrivée",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildDropdownField(label: "Jour")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildDropdownField(label: "Mois")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildDropdownField(label: "Année")),
                ],
              ),
              const SizedBox(height: 30),
              _buildNumericField(label: "Montant payé en espèces"),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirmation"),
                          content: const Text(
                              "Votre paiement est enregistré avec succès."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PaymentPage()),
                                );
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B71F0),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 42.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Envoyer",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, String? hintText}) {
    return TextField(
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNumericField({required String label}) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField({required String label}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      items: List.generate(31, (index) {
        return DropdownMenuItem(
          value: (index + 1).toString(),
          child: Text((index + 1).toString()),
        );
      }),
      onChanged: (value) {},
    );
  }
}

