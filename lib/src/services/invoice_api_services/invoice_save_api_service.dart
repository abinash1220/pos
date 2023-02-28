import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceSaveApiService extends BaseApiService{

   Future invoiceSave ({
       required String tipodoc,
       required String condPag,
       required String modoPag,
       required String tipoEntidade,
       required String dataDoc,
       required String dataVenc,
       required String entidade,
       required String serie,
       required String nome,
       required String nomeFac,
       required String numContribuinte,
       required String numContribuinteFac,
       required String moradafac,
       required String cduMCXID,
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
           
                "Tipodoc": tipodoc,
                "CondPag": condPag,
                "ModoPag": modoPag,
                "TipoEntidade": tipoEntidade,
                "DataDoc":dataDoc,
                "DataVenc":dataVenc,
                "Entidade" : entidade,
                "Serie": serie,
                "Nome": nome,
                "NomeFac": nomeFac,
                "NumContribuinte": numContribuinte,
                "NumContribuinteFac": numContribuinteFac,
                "MoradaFac":moradafac,
                "CDU_MCXID":cduMCXID,
                "Linhas": products,


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