import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPriceListService extends BaseApiService{

   Future itempricelist ({
    required String client,
    required String itemId
   }) async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");

       var response = await dio.get(priceListUrl,
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
              'listId' : 'F3D4E8AC-905D-11ED-814A-502B73C832B0',
              'listParameters' : "$client,$itemId"
            }
       );

     responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;

   }

}