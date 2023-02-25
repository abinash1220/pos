import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentOrderApiSevice extends BaseApiService{

   Future recentOrderList ({
    required String series,
    required String fromdate,
    required String todate,
   }) async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");

       var response = await dio.get(recentOrderApiUrl,
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
              "listId":"F057122E-B424-11ED-8139-30B9B0009848",
              "listParameters":"$series,$fromdate,$todate",
            }
       );

     responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;

   }

}