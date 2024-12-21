import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../style/color.dart';

class PreviousReceiptsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   PreviousReceiptsPage({super.key});

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
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Previous Receipts",
          style: GoogleFonts.poppins(
              color: blackAccent, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('serviceForms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No previous receipts found.",
                style: GoogleFonts.poppins(
                  color: subText, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final data = snapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    data['userName'] ?? "Unknown User",
                    style: GoogleFonts.poppins(
                        color: blackAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Car Name: ${data['carName'] ?? 'N/A'}"),
                      Text("Car Plate: ${data['carPlate'] ?? 'N/A'}"),
                      Text(
                        "Date: ${DateTime.tryParse(data['serviceDate'] ?? '')?.toLocal() ?? 'Unknown Date'}",
                      ),
                      Text(
                        "Services: ${(data['selectedServices'] as List<dynamic>?)?.join(', ') ?? 'None'}",
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: mainColor),
                  onTap: () {
                    // Optional: Navigate to detailed receipt view
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}