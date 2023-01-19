import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final pleaseFillAlltheFields = SnackBar(
  duration: const Duration(seconds: 2),
  backgroundColor: Colors.transparent,
  elevation: 0,
  content: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 2.0,
            blurRadius: 8.0,
            offset: Offset(2, 4),
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Image.asset("assets/icons/esclamation.png"),
           Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('please fill All the fields',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
          const Spacer(),
        ],
      )),
);
