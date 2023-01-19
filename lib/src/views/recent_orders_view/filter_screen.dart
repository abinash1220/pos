import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/views/recent_orders_view/recent_order.dart';

class FilterScreen extends StatefulWidget {
  String title;
  FilterScreen({super.key,required this.title});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                leading: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios)),
                title: Text(
                  widget.title,
                  style: primaryFont.copyWith(
                      color: Color.fromRGBO(255, 255, 255, 1), fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
              ),
              
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
         Padding(
            padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(image: AssetImage("assets/icons/usericon.png")),
                    SizedBox(width: 10,),
                    Text("Zavir",
                    style: primaryFont.copyWith(
                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                    ),
                    ),
                    
                  ],
                ),
                Row(
                      children: [
                        Text("9150",
                        style: primaryFont.copyWith(
                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green
                        ),
                        ),
                      ],
                    ),
              ],
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18,right: 18,top: 15),
            child: Divider(thickness: 1,color: Colors.black,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(image: AssetImage("assets/icons/usericon.png")),
                    SizedBox(width: 10,),
                    Text("Zavir",
                    style: primaryFont.copyWith(
                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                    ),
                    ),
                    
                  ],
                ),
                Row(
                      children: [
                        Text("9150",
                        style: primaryFont.copyWith(
                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green
                        ),
                        ),
                      ],
                    ),
              ],
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18,right: 18,top: 15),
            child: Divider(thickness: 1,color: Colors.black,),
          ),
        ],
      ),
    );
  }
}
