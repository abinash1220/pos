// import 'package:dio/dio.dart';
// import 'package:pos/src/services/base_url.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ListItemsApiService extends BaseApiService{

//    Future listItemsdata () async {

//      dynamic responseJson;

//      try{
     
//        var dio = Dio();
//        final prefs = await SharedPreferences.getInstance();
//        String? authtoken = prefs.getString("auth_token");

//        var response = await dio.get(itemsListUrl,
//         options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $authtoken'
//           },
//           followRedirects: false,
//             validateStatus: (status) {
//               return status! <= 500;
//             }),
//             queryParameters: {
//               'listId' : '89F60147-8123-11ED-8149-502B73C832B0'
//             }
//        );
//        print(":::::::::::::::;;; item liststatus code>>>>>>>>>>>>>>>>>>>>>");
//        print(response.statusCode);
//      responseJson = response;

//     } catch (e) {
//       print(e);
//     }

//     return responseJson;

//    }

// }