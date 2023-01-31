import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

   bool isSelect = false;

   setLan(){
    if(Get.deviceLocale == Locale('en', 'US')){
      setState(() {
        isSelect = false;
      });
    }else{
      isSelect = true;
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
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
                  child:const Icon(Icons.arrow_back_ios)),
                title: Text(
                  "Language".tr,
                  style: primaryFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  isSelect = false;
                  Get.updateLocale(const Locale('en', 'US'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                            "English",
                            style: primaryFont.copyWith(
                                color: Colors.black,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 16),
                          ),
                          if(isSelect == false)
                          Container(
                            height: 17.5,
                            width: 17.5,
                            decoration: BoxDecoration(
                              color:primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:const Center(
                              child: Image(image: AssetImage("assets/images/tick.png"),
                              color: Colors.white,),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  isSelect = true;
                  Get.updateLocale(const Locale('pt', 'PT'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                            "Portuguese",
                            style: primaryFont.copyWith(
                                color: Colors.black, fontWeight: FontWeight.w600,fontSize: 16),
                          ),
                          if(isSelect == true)
                          Container(
                            height: 17.5,
                            width: 17.5,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:const Center(
                              child: Image(image: AssetImage("assets/images/tick.png"),),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}