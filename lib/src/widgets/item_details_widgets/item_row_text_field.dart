import 'package:flutter/material.dart';
import 'package:pos/src/const/app_fonts.dart';

class ItemRowTextField extends StatelessWidget {
  String title;
  TextEditingController controller;
  ItemRowTextField({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                primaryFont.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Container(
            height: 45,
            width: size.width * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            alignment: Alignment.centerLeft,
            child:  Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration.collapsed(hintText: ""),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
