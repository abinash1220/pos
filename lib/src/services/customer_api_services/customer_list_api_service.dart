import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerListApiServices extends BaseApiService{

   Future customerListServices ({required String userid}) async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");

       var response = await dio.get(customerListApiUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $authtoken'
          },
          followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
            queryParameters: {
              "listId":"2E2A9907-B665-11ED-813A-30B9B0009848",
              "listParameters":userid,
            }
       );

     responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;

   }

}