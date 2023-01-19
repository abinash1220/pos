import 'package:dio/dio.dart'as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/services/login_api_sevices/login_api_service.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/widgets/snackbar_widgets/invalid.dart';
import 'package:pos/src/widgets/snackbar_widgets/something_wrong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiController extends GetxController{
  LoginApiServices loginapiservice = LoginApiServices();
  RxBool loder = false.obs;

  loginuser({
    required BuildContext context,
    required username,
    required password,
  }) async {
    loder(true);
    final prefs = await SharedPreferences.getInstance();
    dio.Response<dynamic> response = await loginapiservice.loginApiServices(
      username: username,
      password: password);
       print(":::::::::::::::::authorization login Status ::::::::::::::::::");
    print(response.statusCode);
    loder(false);
    if(response.statusCode == 200){

        await prefs.setString("auth_token", response.data["access_token"]);

      Get.offAll(HomePageWithNavigation());
    }else if(response.statusCode == 400){
         ScaffoldMessenger.of(context).showSnackBar(invalidlogin);
    }else
    {
      print("Something went wrong");
      //ScaffoldMessenger.of(context).showSnackBar(somethingwrong);
    }
  }

  

}