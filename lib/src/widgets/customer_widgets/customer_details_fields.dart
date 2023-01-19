import 'package:flutter/material.dart';
import 'package:pos/src/const/app_fonts.dart';

class CustomerDetailsField extends StatelessWidget {
  String titile;
  TextEditingController controller;
  CustomerDetailsField({super.key, required this.titile,required this.controller});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            titile,
            style:
                primaryFont.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            height: 45,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
                alignment: Alignment.centerLeft,
                child:  Padding(
                  padding:  EdgeInsets.only(left: 10,right: 10),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration.collapsed(hintText: ""),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
