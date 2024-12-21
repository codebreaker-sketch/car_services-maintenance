import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_car_service/models/service_models.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/service.dart';
import '../style/color.dart';
import 'home_pages.dart';
import 'receipt_page.dart';
import 'previous_receipts_page.dart'; // Added import

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key});

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  List<ServiceModels> serviceDataForm = [];
  List<ServiceModels> selectedService = [];

  TextEditingController carNameController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  DateTime? selectedDate;

  // Firestore reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    serviceDataForm = serviceData;
  }

  @override
  void dispose() {
    carNameController.dispose();
    carPlateController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  Future<void> _saveDataToFirestore() async {
    try {
      await _firestore.collection('serviceForms').add({
        'carName': carNameController.text,
        'carPlate': carPlateController.text,
        'userName': userNameController.text,
        'serviceDate': selectedDate?.toIso8601String(),
        'selectedServices':
            selectedService.map((service) => service.logo).toList(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data: $e')),
      );
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime initialDate = selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool _areFieldsValid() {
    if (carNameController.text.isEmpty ||
        carPlateController.text.isEmpty ||
        userNameController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and select a service date.'),
        ),
      );
      return false;
    }
    return true;
  }

  void _submitForm() async {
    if (!_areFieldsValid()) return;

    await _saveDataToFirestore();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPage(
          userName: userNameController.text,
          carName: carNameController.text,
          carPlate: carPlateController.text,
          serviceDate: selectedDate!,
          selectedServices: selectedService
              .map((service) => service.logo ?? "Unknown Service")
              .toList(),
        ),
      ),
    );
  }

  void _viewPreviousReceipts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviousReceiptsPage(), // Navigates to previous receipts page
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: blackAccent),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text(
          "Service Form",
          style: GoogleFonts.poppins(
              color: blackAccent, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Details Section
              _buildCarDetailsSection(),
              const SizedBox(height: 25),
              // Service List Section
              _buildServiceListSection(),
              const SizedBox(height: 25),
              // Date Picker Section
              _buildDatePickerSection(),
              const SizedBox(height: 25),
              // Buttons Section
              _buildButtonsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarDetailsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: subText.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Car Detail",
            style: GoogleFonts.poppins(
                color: blackAccent, fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          _buildInputField("Car Name", carNameController),
          _buildInputField("Car Number", carPlateController),
          _buildInputField("Your Name", userNameController),
        ],
      ),
    );
  }

  Widget _buildServiceListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service List",
          style: GoogleFonts.poppins(
              color: subText, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: serviceDataForm.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedService.add(serviceDataForm[index]);
                    serviceDataForm.removeAt(index);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: mainColor,
                  ),
                  child: Image.asset(
                    serviceDataForm[index].logo.toString(),
                    height: 40,
                    width: 40,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Date",
          style: GoogleFonts.poppins(
              color: blackAccent, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              selectedDate == null
                  ? 'Select a date'
                  : "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, color: mainColor),
              onPressed: () => _pickDate(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonsSection() {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              "Submit Form",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _viewPreviousReceipts,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              "View Previous Receipts",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
              color: subText, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              hintText: "   Enter $label",
              hintStyle: GoogleFonts.poppins(
                  color: blackAccent, fontSize: 12, fontWeight: FontWeight.w600),
              border: const UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}