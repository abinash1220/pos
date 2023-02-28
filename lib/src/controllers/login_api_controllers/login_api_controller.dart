import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pos/src/const/api_cachekey.dart';
import 'package:pos/src/controllers/location_and_firebase_controllers/location_and_firabse_controller.dart';
import 'package:pos/src/models/items_api_models/list_user_serie_model.dart';
import 'package:pos/src/models/list_user_model.dart';
import 'package:pos/src/services/login_api_sevices/list_user_serie_api_service.dart';
import 'package:pos/src/services/login_api_sevices/login_api_service.dart';
import 'package:pos/src/views/auth_view/login_view.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/widgets/snackbar_widgets/invalid.dart';
import 'package:pos/src/widgets/snackbar_widgets/something_wrong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiController extends GetxController {
  LoginApiServices loginapiservice = LoginApiServices();
  RxBool loder = false.obs;

  loginuser({
    required BuildContext context,
    required username,
    required password,
  }) async {
    loder(true);
    final prefs = await SharedPreferences.getInstance();

    // Get.snackbar(username, password);

    dio.Response<dynamic> response = await loginapiservice.loginApiServices(
        username: username, password: password);
    print(":::::::::::::::::authorization login Status ::::::::::::::::::");
    print(response.statusCode);
    //Get.snackbar(response.statusCode.toString(),"");
    loder(false);
    if (response.statusCode == 200) {
      await prefs.setString("username", username.trim());
      await prefs.setString("auth_token", response.data["access_token"]);
      Get.find<LocationAndFirebaseController>().checkIfTheUserIsAvailable();

      Get.offAll(HomePageWithNavigation());
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(invalidlogin);
    } else if(response.statusCode == 500){
      Get.snackbar(response.statusCode.toString(), "Server error");
    } else {
      print("Something went wrong");
      //ScaffoldMessenger.of(context).showSnackBar(somethingwrong);
    }
  }

  

  //list user serie controller
  ListUserSerieService listuserService = ListUserSerieService();

  List<ListUserData> listUserData = [];

  listUserSerie() async {
    bool result = await InternetConnectionChecker().hasConnection;

    if (result) {
      final prefs = await SharedPreferences.getInstance();

      dio.Response<dynamic> response =
          await listuserService.listuserSerieService();

      print(response.statusCode);

      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel = APICacheDBModel(
            key: listuserSerieKey, syncData: jsonEncode(response.data));

        await APICacheManager().addCacheData(cacheDBModel);

        ListUserModel listUserModel = ListUserModel.fromJson(response.data);
        listUserData = listUserModel.data;

        update();
      } else if (response.statusCode == 500) {
        print("An error has occurred.");
      } else if (response.statusCode == 401) {
        print("Toke Expiered");
        logOutUser();
      }
    } else {
      var cacheData = await APICacheManager().getCacheData(listuserSerieKey);

      ListUserModel listUserModel =
          ListUserModel.fromJson(json.decode(cacheData.syncData));
      listUserData = listUserModel.data;

      update();
    }
  }

  logOutUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("auth_token", "null");

    Get.offAll(() => LoginView());
  }

}
