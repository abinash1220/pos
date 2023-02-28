import 'dart:convert';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pos/src/const/api_cachekey.dart';
import 'package:pos/src/models/customer_api_models/customer_api_model.dart';
import 'package:pos/src/models/customer_api_models/customer_list_api_model.dart';
import 'package:pos/src/services/customer_api_services/customer_api_service.dart';
import 'package:pos/src/views/auth_view/login_view.dart';
import 'package:pos/src/views/customers_view/customer_view.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/customer_api_services/customer_list_api_service.dart';
import '../../widgets/snackbar_widgets/something_wrong.dart';

class CustomerApiController extends GetxController{
  CustomerApiServices customerapiservice = CustomerApiServices();
  CustomerListApiServices customerlistapiservice = CustomerListApiServices();
  //CreateCustomerApiServices createcustomerapiservice = CreateCustomerApiServices();

   //List<CustomerData> customerdatalist = [];
   //new
   List<CustomerListData> customerlistdata = [];

  //  Future customer ({
  //    required BuildContext context,
  //  }) async {

  //   bool result = await InternetConnectionChecker().hasConnection;

  //   if(result){
       
  //     //q Get.snackbar("", "available internet");
        
  //      dio.Response<dynamic> response = await customerapiservice.customerList();

  //   // Get.snackbar(response.statusCode.toString(), "customer");
  //    if(response.statusCode == 200){

  //     APICacheDBModel cacheDBModel = new APICacheDBModel(
  //       key: customerlistkey, 
  //       syncData: jsonEncode(response.data));

  //       await APICacheManager().addCacheData(cacheDBModel);

  //      ListCustomer listCustomer = ListCustomer.fromJson(response.data);
  //      customerdatalist = listCustomer.dataSet.table;
      
  //      update();

  //    }else if(response.statusCode == 401){
          
  //   final prefs = await SharedPreferences.getInstance();

  //   await prefs.setString("auth_token", "null");

  //   Get.offAll(() => LoginView());
  
  //    }else{
  //      Get.snackbar(response.statusCode.toString(), "",
  //          snackPosition: SnackPosition.BOTTOM,
  //          colorText: Colors.white,
  //          backgroundColor: Colors.red[300]);
  //      // ScaffoldMessenger.of(context).showSnackBar(somethingwrong);
  //    }
  //  }else{
   
  // // Get.snackbar("", "no internet");

  //   var cacheData = await APICacheManager().getCacheData(customerlistkey);

  //    ListCustomer listCustomer = ListCustomer.fromJson(json.decode(cacheData.syncData));
  //      customerdatalist = listCustomer.dataSet.table;
      
  //      update();

  //  }

  //    }

    //new

     Future customerlist ({
     required BuildContext context,
     required String userid,
   }) async {

    bool result = await InternetConnectionChecker().hasConnection;

    if(result){
       
      //q Get.snackbar("", "available internet");
        
       dio.Response<dynamic> response = await customerlistapiservice.customerListServices(
        userid: userid 
       );

    // Get.snackbar(response.statusCode.toString(), "customer");
     if(response.statusCode == 200){

      APICacheDBModel cacheDBModel = new APICacheDBModel(
        key: customerlistkey, 
        syncData: jsonEncode(response.data));

        await APICacheManager().addCacheData(cacheDBModel);

       CustomerList customerList = CustomerList.fromJson(response.data);
       customerlistdata = customerList.data;
      
       update();

     }else if(response.statusCode == 401){
          
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("auth_token", "null");

    Get.offAll(() => const LoginView());
  
     }else{
       Get.snackbar(response.statusCode.toString(), "",
           snackPosition: SnackPosition.BOTTOM,
           colorText: Colors.white,
           backgroundColor: Colors.red[300]);
       // ScaffoldMessenger.of(context).showSnackBar(somethingwrong);
     }
   }else{
   
  // Get.snackbar("", "no internet");

    var cacheData = await APICacheManager().getCacheData(customerlistkey);

       CustomerList customerList = CustomerList.fromJson(json.decode(cacheData.syncData));
       customerlistdata = customerList.data;
      
       update();

   }

     } 

 

}