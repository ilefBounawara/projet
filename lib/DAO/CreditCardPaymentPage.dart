import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:smart_ascenseur/DAO/PaymentPage.dart';

class CreditCardPaymentPage extends StatefulWidget {
  const CreditCardPaymentPage({super.key});

  @override
  State<CreditCardPaymentPage> createState() => _CreditCardPaymentPageState();
}

class _CreditCardPaymentPageState extends State<CreditCardPaymentPage> {
  int _currentCardIndex = 0;
  String? _selectedCardName;
  DateTime? _selectedExpiryDate;

  final List<Map<String, dynamic>> creditCards = [
    {
      "bankName": "FYI BANK",
      "cardNumber": "0000 2363 8364 8269",
      "expiryDate": "5/25",
      "cvv": "633",
      "cardHolder": "Imene Ben Salem",
      "cardColor": [Color(0xFF7B61FF), Color(0xFFB993FF)],
    },
    {
      "bankName": "VISA BANK",
      "cardNumber": "1234 5678 9012 3456",
      "expiryDate": "7/25",
      "cvv": "123",
      "cardHolder": "John Doe",
      "cardColor": [Color(0xFF0023FF), Color(0xFF6394FF)],
    },
    {
      "bankName": "RED BANK",
      "cardNumber": "9876 5432 1098 7654",
      "expiryDate": "12/26",
      "cvv": "456",
      "cardHolder": "Jane Smith",
      "cardColor": [Color(0xFFFF4D4D), Color(0xFFFF8888)],
    },
  ];

  final List<String> cardNames = ["Mastercard", "Visa", "Amex", "Discover"];
  final _cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Foulen ben foulen',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildCreditCardCarousel(),
              const SizedBox(height: 20),
              const Text(
                'Entrez les détails de la carte :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildCardDetailsForm(),
              const SizedBox(height: 20),
              _buildPayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCardCarousel() {
    return Column(
      children: [
        CarouselSlider(
          items: creditCards.map((card) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: card['cardColor'],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card['bankName'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    card['cardNumber'],
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 1.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card['expiryDate'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        card['cvv'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 180,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCardIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(creditCards.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentCardIndex == index ? Colors.blue : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCardDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Nom de la carte',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          value: _selectedCardName,
          items: cardNames.map((cardName) {
            return DropdownMenuItem(value: cardName, child: Text(cardName));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCardName = value;
            });
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Numéro de carte',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickExpiryDate,
          child: AbsorbPointer(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: _selectedExpiryDate == null
                    ? 'Date d\'expiration'
                    : DateFormat('MM/yyyy').format(_selectedExpiryDate!),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildInputField(
            label: 'Code de vérification', keyboardType: TextInputType.number),
      ],
    );
  }

  Future<void> _pickExpiryDate() async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedExpiryDate = pickedDate;
      });
    }
  }

  Widget _buildInputField(
      {required String label, required TextInputType keyboardType}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFFB993FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_selectedCardName == null ||
              _cardNumberController.text.isEmpty ||
              _selectedExpiryDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Veuillez remplir tous les champs.'),
              ),
            );
            return;
          }

          const double montantReservation = 120.50;

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirmation de paiement'),
                content: Text(
                    'Le montant de la réservation est de \$${montantReservation.toStringAsFixed(2)}. Voulez-vous confirmer ?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentPage()),
                      );
                    },
                    child: const Text('Confirmer'),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Center(
          child: Text(
            'PAYER',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
