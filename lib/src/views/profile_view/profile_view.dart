import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/login_api_controllers/login_api_controller.dart';
import 'package:pos/src/views/auth_view/login_view.dart';
import 'package:pos/src/views/profile_view/language_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

   logOutUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("auth_token", "null");

    Get.offAll(() => LoginView());
  }

  final loginApiController = Get.find<LoginApiController>();

  String loginname = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  getUsername () async {
    final prefs = await SharedPreferences.getInstance();
       String? username = prefs.getString("username");
       setState(() {
         loginname = username!;
       });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                        onTap: () {
                          // Get.back();
                        },
                        child: const Icon(
                          Icons.save,
                          color: Colors.white,
                        )),
                  )
                ],
                title: Text(
                  "Profile".tr,
                  style: primaryFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 150,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey.withOpacity(0.4))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Add Image".tr,
                      style: primaryFont.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.person_crop_circle_fill_badge_plus,
                        color: primaryColor,
                        size: 90,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding:  EdgeInsets.only(left: 15),
            child:  Text("User Name".tr,style:const TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey.withOpacity(0.4))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  readOnly: true,
                  style: primaryFont.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration.collapsed(
                      hintText: loginname,
                      hintStyle: primaryFont.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding:  EdgeInsets.only(left: 15),
            child:  Text("Series",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey.withOpacity(0.4))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  readOnly: true,
                  style: primaryFont.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration.collapsed(
                      hintText: loginApiController.listUserData.first.serie,
                      hintStyle: primaryFont.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding:const  EdgeInsets.only(left: 15),
            child:  Text("WereHouse".tr,style:const TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey.withOpacity(0.4))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  readOnly: true,
                  style: primaryFont.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration.collapsed(
                      hintText: loginApiController.listUserData.first.warehouse,
                      hintStyle: primaryFont.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding:const  EdgeInsets.only(left: 15),
            child:  Text("Client".tr,style:const TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 60,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey.withOpacity(0.4))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  readOnly: true,
                  style: primaryFont.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration.collapsed(
                      hintText: loginApiController.listUserData.first.customer,
                      hintStyle: primaryFont.copyWith(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding:const  EdgeInsets.only(left: 15),
            child:  Text("Language".tr,
            style: const TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600),),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {
               Get.to(const LanguageScreen());
              },
              child: Container(
                height: 60,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, color: Colors.grey.withOpacity(0.4))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Language".tr,
                        style: primaryFont.copyWith(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   child: Container(
          //     height: 60,
          //     width: size.width,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         boxShadow: [
          //           BoxShadow(
          //               blurRadius: 2, color: Colors.grey.withOpacity(0.4))
          //         ],
          //         borderRadius: BorderRadius.circular(10)),
          //     alignment: Alignment.centerLeft,
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 10, right: 10),
          //       child: TextField(
          //         style: primaryFont.copyWith(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w600),
          //         decoration: InputDecoration.collapsed(
          //             hintText: "Confirm Password",
          //             hintStyle: primaryFont.copyWith(
          //                 color: Colors.black,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w600)),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: InkWell(
              onTap: () {
               logOutUser();
              },
              child: Container(
                height: 60,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, color: Colors.grey.withOpacity(0.4))
                    ],
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Logout".tr,
                        style: primaryFont.copyWith(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
