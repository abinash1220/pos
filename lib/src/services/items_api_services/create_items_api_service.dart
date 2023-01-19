import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateItemsApiServices extends BaseApiService{

   Future createItems ({
       required String items,
       required String description,
       required String iva,
       required String caracteristicas,
       required String codBarras,
       required String unidadeBase,
       required String peso,
       required String volume,
       required String marca,
      
   }) async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");

       var response = await dio.post(createItemsUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $authtoken'
          },
          followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
            data: {
              "Artigo": items,
              "Descricao": description,
              "Caracteristicas": "",
              "CodBarras": "",
              "UnidadeBase": unidadeBase,
              "IVA": iva,
              "Peso": peso,
              "Volume": volume,
              "Marca": "",
            }
       );

        print("::::::::::::::::create items status code::::::::::::::");
            print(response.statusCode);

     responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;

   }

}