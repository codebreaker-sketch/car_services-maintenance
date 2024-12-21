import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReceiptPage extends StatelessWidget {
  final String userName;
  final String carName;
  final String carPlate;
  final DateTime? serviceDate; // Nullable to validate properly
  final List<String> selectedServices;

  const ReceiptPage({
    Key? key,
    required this.userName,
    required this.carName,
    required this.carPlate,
    required this.serviceDate,
    required this.selectedServices,
  }) : super(key: key);

  // Map the asset path to human-readable names
  String getServiceName(String assetPath) {
    final serviceMap = {
      'assets/logo/oil_categories.png': 'Oil Change',
      'assets/logo/tire_categories.png': 'Tyre Service',
      'assets/logo/sound_categories.png': 'Horn Service',
      'assets/logo/car_categories.png': 'General Car Service',
    };

    return serviceMap[assetPath] ?? 'Unknown Service';
  }

  @override
  Widget build(BuildContext context) {
    // Check for empty or null fields
    final bool hasEmptyFields = userName.trim().isEmpty ||
        carName.trim().isEmpty ||
        carPlate.trim().isEmpty ||
        serviceDate == null ||
        selectedServices.isEmpty;

    if (hasEmptyFields) {
      // Prevent multiple callbacks or rebuilds
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(context);
      });

      // Placeholder "Error" Screen
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Error",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Text(
            "Incomplete data! Please fill in all required fields.",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // If data is valid, show the receipt
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Service Receipt",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Receipt",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Customer Details",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Name: $userName", style: GoogleFonts.poppins(fontSize: 16)),
            Text("Car Name: $carName", style: GoogleFonts.poppins(fontSize: 16)),
            Text("Car Plate: $carPlate", style: GoogleFonts.poppins(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              "Service Details",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Service Date: ${serviceDate!.day}/${serviceDate!.month}/${serviceDate!.year}",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text("Selected Services:", style: GoogleFonts.poppins(fontSize: 16)),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedServices
                  .map((servicePath) => Text(
                        "- ${getServiceName(servicePath)}",
                        style: GoogleFonts.poppins(fontSize: 16),
                      ))
                  .toList(),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back to Form",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show an error dialog for incomplete data
  void _showErrorDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "All fields must be filled in, including at least one service.",
              style: GoogleFonts.poppins(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to form page
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}