import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListUserSerieService extends BaseApiService{

   Future listuserSerieService () async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");
       String? username = prefs.getString("username");

       var response = await dio.get(listUserSerieUrl,
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
              'listId' : '25F5B245-A6F1-4874-9E8B-EA1701465B9D',
              'listParameters' : "$username"
            }
       );

     responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;

   }

}