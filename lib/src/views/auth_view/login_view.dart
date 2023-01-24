import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/login_api_controllers/login_api_controller.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/views/home_view/home_view.dart';
import 'package:pos/src/views/test_printer.dart';
import 'package:pos/src/widgets/snackbar_widgets/fill_the_fields.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPasswordVisble = true;
  
  final loginApiController = Get.find<LoginApiController>();

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/pos_logo.png"),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: TextField(
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                          isCollapsed: true,
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: primaryFont.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10, bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: passwordcontroller,
                            obscureText: isPasswordVisble,
                            decoration: InputDecoration(
                                isCollapsed: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: primaryFont.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordVisble = !isPasswordVisble;
                              });
                            },
                            child: isPasswordVisble ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility) )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx( () => (
                 Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    onTap: (){
                      if(usernamecontroller.text.isNotEmpty &&
                         passwordcontroller.text.isNotEmpty){
                         loginApiController.loginuser(
                          context: context,
                          username: usernamecontroller.text, 
                          password: passwordcontroller.text);
                      }else{
                      ScaffoldMessenger.of(context)
                                        .showSnackBar(pleaseFillAlltheFields);
                      }
                      //Get.offAll(()=> HomePageWithNavigation());
                    },
                    child: Container(
                      height: 55,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: primaryColor, borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child:loginApiController.loder.isTrue ? CircularProgressIndicator(color: Colors.white,) : Text(
                        "Login",
                        style: primaryFont.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              )),
              
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
