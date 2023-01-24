// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pos/src/const/app_fonts.dart';
// import 'package:pos/src/controllers/customer_api_controller/customer_api_controller.dart';
// import 'package:pos/src/controllers/customer_api_controller/items_api_controllers/items_api_controller.dart';
// import 'package:pos/src/controllers/login_api_controllers/login_api_controller.dart';

// class InvoiceDropdown extends StatefulWidget {
//   Color color;
//   InvoiceDropdown({super.key, required this.color});

//   @override
//   State<InvoiceDropdown> createState() => _InvoiceDropdownState();
// }

// class _InvoiceDropdownState extends State<InvoiceDropdown> {

//   final itemsApiController = Get.find<CreateItemsApiController>();

//   //final createApiController = Get.find<CreateItemsApiController>();

//   final loginApiController = Get.find<LoginApiController>();

//   final customerApiController = Get.find<CustomerApiController>();

//   String value = "select";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //itemsApiController.listitems(context: context);
//     itemsApiController.listOfitems(
//       client: ,
//       wareHouse: loginApiController.listUserData.first.warehouse == "CAR1" ? "SAADMIN" : loginApiController.listUserData.first.warehouse);
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       color: widget.color,
//       child: Row(
//         children: [
//           Container(
//                     width: 80,
//                     alignment: Alignment.center,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                             value,
//                           style: primaryFont.copyWith(
//                               fontSize: 13, fontWeight: FontWeight.w600),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _dialogBuilder(context);
//                           },
//                           child: Icon(Icons.keyboard_arrow_down_rounded))
//                       ],
//                     ),
//                   ),
//           Container(
//             height: 50,
//             width: 1,
//             color: Colors.grey.withOpacity(0.7),
//           ),
//           Container(
//             width: 60,
//             alignment: Alignment.center,
//             child: TextField(
//               textAlign: TextAlign.center,
//               keyboardType: TextInputType.number,
//               style: primaryFont.copyWith(
//                   fontSize: 13, fontWeight: FontWeight.w600),
//               decoration: InputDecoration.collapsed(hintText: ""),
//             ),
//           ),
//           Container(
//             height: 50,
//             width: 1,
//             color: Colors.grey.withOpacity(0.7),
//           ),
//           Container(
//             width: 90,
//             alignment: Alignment.center,
//             child: TextField(
//               textAlign: TextAlign.center,
//               keyboardType: TextInputType.number,
//               style: primaryFont.copyWith(
//                   fontSize: 13, fontWeight: FontWeight.w600),
//               decoration: InputDecoration.collapsed(hintText: ""),
//             ),
//           ),
//           Container(
//             height: 50,
//             width: 1,
//             color: Colors.grey.withOpacity(0.7),
//           ),
//           Container(
//             width: 60,
//             alignment: Alignment.center,
//             child: TextField(
//               textAlign: TextAlign.center,
//               keyboardType: TextInputType.number,
//               style: primaryFont.copyWith(
//                   fontSize: 13, fontWeight: FontWeight.w600),
//               decoration: InputDecoration.collapsed(hintText: ""),
//             ),
//           ),
//           Container(
//             height: 50,
//             width: 1,
//             color: Colors.grey.withOpacity(0.7),
//           ),
//           Container(
//             width: 90,
//             alignment: Alignment.center,
//             child: TextField(
//               textAlign: TextAlign.center,
//               keyboardType: TextInputType.number,
//               style: primaryFont.copyWith(
//                   fontSize: 13, fontWeight: FontWeight.w600),
//               decoration: InputDecoration.collapsed(hintText: ""),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Future<void> _dialogBuilder(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select Items:"),
//            content: Container(
//             height: 300,
//             width: 100,
//             child: GetBuilder<CreateItemsApiController>(
//               builder: (_) {
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount:itemsApiController.pricelist!.length,
//                   itemBuilder:  (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: InkWell(
//                       onTap: (){
//                         setState(() {
//                           value = itemsApiController.pricelist![index]!.artigo;
//                           Get.back();
//                         });
//                       },
//                       child: Container(
//                         height: 30,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                         ),
//                         child:  Center(
//                            child: Padding(
//                             padding: const EdgeInsets.only(left: 5,),
//                             child: Row(
//                               children: [
//                                        Text(
//                                           itemsApiController.pricelist![index]!.artigo,
//                                           textDirection: TextDirection.ltr,
//                                           style: primaryFont.copyWith(
//                                               fontSize: 13, fontWeight: FontWeight.w600),
//                                         ),
//                                         SizedBox(width: 10,),
//                                         Container(
//                                           width: 150,
//                                           child: Text(
//                                             itemsApiController.pricelist![index]!.descricao,
//                                             overflow: TextOverflow.ellipsis,
//                                             textDirection: TextDirection.ltr,
//                                             style: primaryFont.copyWith(
//                                                 fontSize: 13, fontWeight: FontWeight.w600),
//                                           ),
//                                         ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//                 );
//               }
//             )),
//            );
// });
// }
// }
