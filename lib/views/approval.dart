import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Approval extends StatefulWidget {
  final String uid;
  const Approval({Key? key, required this.uid}) : super(key: key);

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Awaiting Approval\nfrom Admin",
                textAlign: TextAlign.center, style: GoogleFonts.lato(color: context.theme.primaryColor, fontWeight: FontWeight.w700, fontSize: 25)),
            const SizedBox(height: 50),
            TextButton.icon(
                onPressed: () => Get.offAllNamed("/splash"),
                icon: const Icon(Icons.refresh, color: Colors.grey),
                label: Text("Refresh", style: GoogleFonts.lato(color: Colors.grey, fontSize: 18)))
          ],
        ),
      ),
    );
  }
}
