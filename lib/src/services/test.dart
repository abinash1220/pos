// import 'dart:io';

// import 'package:dio/dio.dart';

// class AdminRegisterServicesApi extends BaseApiService {
//   Future adminRegisterApi(
//       AdminRegisterModel adminRegisterModel, String token) async {
//     dynamic responseJson;
//     try {
//       var dio = Dio();
//       // final prefs = await SharedPreferences.getInstance();
//       // String? authtoken = prefs.getString("auth_token");

//       FormData formData = FormData.fromMap({
//         "temple_name": adminRegisterModel.templeName,
//         "deity_name": adminRegisterModel.deityName,
//         "speciality_planet": adminRegisterModel.specialityPlanet,
//         "hrnc": adminRegisterModel.hrnc,
//         "organisation": adminRegisterModel.organisation,
//         "incharge_person": adminRegisterModel.inChargePerson,
//         "incharge_person_phone": adminRegisterModel.inchanrgePersonContanct,
//         "poojari_name": adminRegisterModel.pooojariName,
//         "poojari_phone": adminRegisterModel.poojariContactNumber,
//         "poojari_acc_hol_name": adminRegisterModel.poojariBankName,
//         "poojari_account_no": adminRegisterModel.poojariAccountNum,
//         "poojari_ifsc": adminRegisterModel.poojariIfsc,
//         "poojari_upi": adminRegisterModel.poojariUPI,
//         "temple_acc_hol_name": adminRegisterModel.templeAccountName,
//         "temple_acc_number": adminRegisterModel.templeAccountNumber,
//         "temple_ifsc": adminRegisterModel.templeteIfsc,
//         "temple_upi": adminRegisterModel.templeUPI,
//         "temple_address": adminRegisterModel.templeAddress,
//         "temple_phone": adminRegisterModel.templePhone,
//         "archana_ticket1": adminRegisterModel.archanaticket1,
//         "archana_ticket2": adminRegisterModel.archanaticket2,
//         "archana_ticket3": adminRegisterModel.archanaticket3,
//         "archana_ticket4": adminRegisterModel.archanaticket3,
//         "archana_ticket5": adminRegisterModel.archanaticket5,
//         "archana_ticket_vehicle": adminRegisterModel.archanaTicketVehicle,
//         "poojari_auth_image": await MultipartFile.fromFile(
//             adminRegisterModel.poojariAuthImage.path,
//             filename: adminRegisterModel.templeName),
//       });

//       var response = await dio.post(adminRegister,
//           options: Options(
//               headers: {
//                 'Accept': 'application/json',
//                 'Authorization': 'Bearer $token',
//               },
//               followRedirects: false,
//               validateStatus: (status) {
//                 return status! <= 500;
//               }),
//           data: formData);
//       print("::::::::<Register>::::::::status code::::::::::");
//       print(response.statusCode);
//       print(response.data);
//       responseJson = response;
//     } on SocketException {
//       print("no internet");
//     }
//     return responseJson;
//   }

//   dynamic returnResponse(Response<dynamic> response) {
//     switch (response.statusCode) {
//       case 200:
//         dynamic responseJson = response.data;
//         print("here.>>>>>>>>>>>>");
//         return responseJson;
//       case 400:
//       // throw BadRequestException(response.body.toString());
//       case 401:
//       case 403:
//       // throw UnauthorisedException(response.body.toString());
//       case 404:
//       // throw UnauthorisedException(response.body.toString());
//       case 500:
//       default:
//       // throw FetchDataException(
//       //     'Error occured while communication with server' +
//       //         ' with status code : ${response.statusCode}');
//     }
//   }
// }
