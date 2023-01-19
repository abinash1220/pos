import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceSaveApiService extends BaseApiService{

   Future invoiceSave ({
       required String tipodoc,
       required String serie,
       required String entidade,
       required String tipoEntidade,
       required String dataDoc,
       required String dataVenc,
       required String horaDefinida,
       required String calculoManual,
       required List<dynamic> products
   }) async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");

       var response = await dio.post(invoiceUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $authtoken'
          },
          followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
            data: 
             {
           "Linhas": products,
                "Tipodoc": tipodoc,
                "Serie": serie,
                "Entidade": entidade,
                "TipoEntidade": tipoEntidade,
                "DataDoc":dataDoc,
                "DataVenc":dataVenc,
                "HoraDefinida" : horaDefinida,
                "CalculoManual": calculoManual


            }
       );

        print("::::::::::::::::create customer status code::::::::::::::");
            print(response.statusCode);

     responseJson = response;
    } catch (e) {
      print(e);
    }

    return responseJson;

   }

}