import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/models/customer_api_models/customer_api_model.dart';
import 'package:pos/src/services/customer_api_services/customer_api_service.dart';
import 'package:pos/src/views/auth_view/login_view.dart';
import 'package:pos/src/views/customers_view/customer_view.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/customer_api_services/create_customer_api_service.dart';
import '../../widgets/snackbar_widgets/something_wrong.dart';

class CustomerApiController extends GetxController{
  CustomerApiServices customerapiservice = CustomerApiServices();
  CreateCustomerApiServices createcustomerapiservice = CreateCustomerApiServices();

   List<CustomerData> customerdatalist = [];

   Future customer ({
     required BuildContext context,
   }) async {

     dio.Response<dynamic> response = await customerapiservice.customerList();
     
     if(response.statusCode == 200){

       ListCustomer listCustomer = ListCustomer.fromJson(response.data);
       customerdatalist = listCustomer.dataSet.table;
      
       update();

     }else if(response.statusCode == 401){
          
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("auth_token", "null");

    Get.offAll(() => LoginView());
  
     }else{
       Get.snackbar(response.statusCode.toString(), "",
           snackPosition: SnackPosition.BOTTOM,
           colorText: Colors.white,
           backgroundColor: Colors.red[300]);
       // ScaffoldMessenger.of(context).showSnackBar(somethingwrong);
     }
   }

   createCus({
       required BuildContext context,
       required String client,
       required String name,
       required String address,
       required String location,
       required String description,
       required String localidadeCodigoPostal,
       required String postalCode,
       required String telePhone,
       required String phoneNumber,
       required String fax,
       required String webAddress,
       required String distict,
       required String taxId,
       required String priceList,
  }) async {
   
    dio.Response<dynamic> response = await createcustomerapiservice.createcustomer(
      client: client,
      name: name,
      address: address,
      fax: fax,
      phoneNumber: phoneNumber,
      description: description,
      localidadeCodigoPostal: localidadeCodigoPostal,
      postalCode: postalCode,
      priceList: priceList,
      taxId: taxId,
      telePhone: telePhone,
      distict: distict,
      location: location,
      webAddress: webAddress,
      );
       print(":::::::::::::::::authorization login Status ::::::::::::::::::");
    print(response.statusCode);
    if(response.statusCode == 204){

        // await prefs.setString("auth_token", response.data["access_token"]);

        Get.offAll(HomePageWithNavigation(
          index: 2,
        ));

    }else {
         Get.snackbar("incorrect", "",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
    }
  }

}