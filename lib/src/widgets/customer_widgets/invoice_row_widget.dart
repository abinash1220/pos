import 'package:flutter/material.dart';
import 'package:pos/src/const/app_fonts.dart';

class InvoiceRow extends StatefulWidget {
  Color color;
  InvoiceRow({super.key, required this.color});

  @override
  State<InvoiceRow> createState() => _InvoiceRowState();
}

class _InvoiceRowState extends State<InvoiceRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: widget.color,
      child: Row(
        children: [
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "100011",
                //   style: primaryFont.copyWith(
                //       fontSize: 13, fontWeight: FontWeight.w600),
                // ),
                // Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.grey.withOpacity(0.7),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: primaryFont.copyWith(
                  fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration.collapsed(hintText: ""),
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.grey.withOpacity(0.7),
          ),
          Container(
            width: 90,
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: primaryFont.copyWith(
                  fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration.collapsed(hintText: ""),
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.grey.withOpacity(0.7),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: primaryFont.copyWith(
                  fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration.collapsed(hintText: ""),
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.grey.withOpacity(0.7),
          ),
          Container(
            width: 90,
            alignment: Alignment.center,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: primaryFont.copyWith(
                  fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration.collapsed(hintText: ""),
            ),
          ),
        ],
      ),
    );
  }
}
