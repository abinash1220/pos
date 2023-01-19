import 'package:dio/dio.dart';
import 'package:pos/src/services/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCustomerApiServices extends BaseApiService{

   Future createcustomer ({
       required String client,
       required String name,
       required String address,
       required String location,
       required String description,
       required String localidadeCodigoPostal,
       required String postalCode,
       required String telePhone,
       required String phoneNumber,
       required String fax,
       required String webAddress,
       required String distict,
       required String taxId,
       required String priceList,
   }) async {

     dynamic responseJson;

     try{
     
       var dio = Dio();
       final prefs = await SharedPreferences.getInstance();
       String? authtoken = prefs.getString("auth_token");

       var response = await dio.post(createCustomerUrl,
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
              "Cliente": client,
              "Nome": name,
              "Descricao": description,
              "Morada": address,
              "Localidade": location,
              "CodigoPostal": postalCode,
              "LocalidadeCodigoPostal": localidadeCodigoPostal,
              "Telefone": telePhone,
              "Fax": fax,
              "EnderecoWeb": webAddress,
              "Distrito": "",
              "NumContribuinte": phoneNumber,
              "Pais": taxId,
              "Moeda": priceList
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