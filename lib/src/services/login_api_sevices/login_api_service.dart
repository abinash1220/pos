import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiServices extends BaseApiService{

   Future loginApiServices ({
    required String username,
    required String password,
   }) async{
      
      dynamic responseJson;

     try{
      
      var dio = Dio();
       
         FormData formData = FormData.fromMap({
          "username": username,
          "password": password,
          "company":"XXX", 
          "instance":"DEFAULT",
          "grant_type":"password",
          "line":"Executive",
         });
 
         var response = await dio.post(loginUrl,
           options: Options(
            headers: {
              'Accept': 'Application/x-www-form-urlencoded',
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            followRedirects: false,
                validateStatus: (status) {
                 return status! <= 500;
                }),
            data: {
          "username": username,
          "password": password,
          "company":"XXX", 
          "instance":"DEFAULT",
          "grant_type":"password",
          "line":"Executive",
         });
            print("::::::::::::::::login Authorization status code::::::::::::::");
            print(response.statusCode);

      responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;
   }

}