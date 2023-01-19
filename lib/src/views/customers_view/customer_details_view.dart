// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pos/src/const/app_colors.dart';
// import 'package:pos/src/const/app_fonts.dart';
// import 'package:pos/src/controllers/customer_api_controller/customer_api_controller.dart';
// import 'package:pos/src/widgets/customer_widgets/customer_details_fields.dart';

// import '../../widgets/snackbar_widgets/fill_the_fields.dart';

// class CustomerDetailsView extends StatefulWidget {
//   String title;
//   CustomerDetailsView({super.key, required this.title});

//   @override
//   State<CustomerDetailsView> createState() => _CustomerDetailsViewState();
// }

// class _CustomerDetailsViewState extends State<CustomerDetailsView> {

//    final customerApiController = Get.find<CustomerApiController>();
   
//    TextEditingController clientcontroller = TextEditingController();
//    TextEditingController namecontroller = TextEditingController();
//    TextEditingController descriptioncontroller = TextEditingController();
//    TextEditingController localidadeCodigoPostalcontroller = TextEditingController();
//    TextEditingController addresscontroller = TextEditingController();
//    TextEditingController locationcontroller = TextEditingController();
//    TextEditingController postalCodecontroller = TextEditingController();
//    TextEditingController telePhonecontroller = TextEditingController();
//    TextEditingController phoneNumbercontroller = TextEditingController();
//    TextEditingController faxcontroller = TextEditingController();
//    TextEditingController webAddresscontroller = TextEditingController();
//    TextEditingController districtcontroller = TextEditingController();
//    TextEditingController taxIdcontroller = TextEditingController();
//    TextEditingController priceListcontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//         child: Container(
//           decoration: BoxDecoration(
//               color: primaryColor, borderRadius: BorderRadius.circular(16)),
//           child: Column(
//             children: [
//               AppBar(
//                 backgroundColor: primaryColor,
//                 elevation: 0,
//                 leading: InkWell(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: const Icon(Icons.arrow_back_ios_sharp)),
//                 actions: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: InkWell(
//                         onTap: () {
//                           if(
//                             clientcontroller.text.isNotEmpty &&
//                             namecontroller.text.isNotEmpty &&
//                             descriptioncontroller.text.isNotEmpty &&
//                             localidadeCodigoPostalcontroller.text.isNotEmpty &&
//                             addresscontroller.text.isNotEmpty &&
//                             locationcontroller.text.isNotEmpty &&
//                             postalCodecontroller.text.isNotEmpty &&
//                             telePhonecontroller.text.isNotEmpty &&
//                             phoneNumbercontroller.text.isNotEmpty &&
//                             faxcontroller.text.isNotEmpty &&
//                             webAddresscontroller.text.isNotEmpty &&
//                             //districtcontroller.text.isNotEmpty &&
//                             taxIdcontroller.text.isNotEmpty &&
//                             priceListcontroller.text.isNotEmpty
//                           ){
//                             customerApiController.createCus(
//                               context: context,
//                                client: clientcontroller.text,
//                                name: namecontroller.text, 
//                                description: descriptioncontroller.text,
//                                localidadeCodigoPostal: localidadeCodigoPostalcontroller.text,
//                                address: addresscontroller.text, 
//                                location: locationcontroller.text, 
//                                postalCode: postalCodecontroller.text, 
//                                telePhone: telePhonecontroller.text, 
//                                phoneNumber: phoneNumbercontroller.text, 
//                                fax: faxcontroller.text, 
//                                webAddress: webAddresscontroller.text, 
//                                distict: districtcontroller.text, 
//                                taxId: taxIdcontroller.text, 
//                                priceList: priceListcontroller.text
//                               );
//                           }else{
//                             ScaffoldMessenger.of(context)
//                                         .showSnackBar(pleaseFillAlltheFields);
//                           }
//                         },
//                         child: const Icon(
//                           Icons.save,
//                           color: Colors.white,
//                         )),
//                   )
//                 ],
//                 title: Text(
//                   widget.title,
//                   style: primaryFont.copyWith(
//                       color: Colors.white, fontWeight: FontWeight.w500),
//                 ),
//                 centerTitle: true,
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(
//             height: 15,
//           ),
//           CustomerDetailsField(
//             controller: clientcontroller,
//             titile: "Client",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: namecontroller,
//             titile: "Name",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: descriptioncontroller,
//             titile: "Description",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: addresscontroller,
//             titile: "Address",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: localidadeCodigoPostalcontroller,
//             titile: "Address 1",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: locationcontroller,
//             titile: "Location",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: postalCodecontroller,
//             titile: "Postal Code",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: telePhonecontroller,
//             titile: "Telephone",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: phoneNumbercontroller,
//             titile: "Phone Number",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: faxcontroller,
//             titile: "Fax",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: webAddresscontroller,
//             titile: "Web Address",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: districtcontroller,
//             titile: "District",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: taxIdcontroller,
//             titile: "Tax ID",
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           CustomerDetailsField(
//             controller: priceListcontroller,
//             titile: "Price List",
//           ),
//           const SizedBox(
//             height: 50,
//           )
//         ],
//       ),
//     );
//   }
// }
