import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerApiServices extends BaseApiService{

   Future customerList () async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");

       var response = await dio.get(customerListUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $authtoken'
          },
          followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
       );

     responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;

   }

}