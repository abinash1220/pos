import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/customer_api_controller/items_api_controllers/items_api_controller.dart';
import 'package:pos/src/controllers/recent_order_controller.dart';
import 'package:pos/src/views/recent_orders_view/filter_screen.dart';

class RecentOrders extends StatefulWidget {
  const RecentOrders({super.key});

  @override
  State<RecentOrders> createState() => _RecentOrdersState();
}

class _RecentOrdersState extends State<RecentOrders> {
  
  final recentorderController = Get.find<RecentOrderController>();

  final itemController = Get.find<CreateItemsApiController>();

  DateTime date = DateTime.now();

  String selectdt = "Select From Date";

  String selectdt1 = "Select To Date";

    _showDatePicker(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
        builder: ((context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme:  ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.blue,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 42, 59, 158),
                ),
              ),
            ),
            child: child!,
          );
        }));

    if (picked != null) {
      setState(() {
        date = picked;
        selectdt = formatDate(date, [dd, "/", mm, "/", yyyy]);
      });
    }
  }

  _showDatePicker1(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
        builder: ((context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme:  ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.blue,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 42, 59, 158),
                ),
              ),
            ),
            child: child!,
          );
        }));

    if (picked != null) {
      setState(() {
        date = picked;
        selectdt1 = formatDate(date, [dd, "/", mm, "/", yyyy]);
      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                leading: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child:const Icon(Icons.arrow_back_ios)),
                title: Text(
                  "recent order".tr.toUpperCase(),
                  style: primaryFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.only(right: 25),
                //     child: InkWell(
                //       onTap: (){
                //         _showDatePicker(context);
                //       },
                //       child:const Icon(Icons.date_range)),
                //   ),
                // ],
        //         actions: [
        //           InkWell(
        //             onTap: (){
        //              showModalBottomSheet(
        // context: context,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        // ),
        // builder: (BuildContext context) {
        //   return Container(
        //     height: 320,
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        //       child: Obx(() =>
        //          Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text("Filter",
        //             style: TextStyle(
        //               fontWeight: FontWeight.w600,
        //               fontSize: 22,
        //             ),
        //             ),
        //             Divider(color: Colors.grey,thickness: 2,),
        //             SizedBox(height: 10,),
        //             Padding(
        //               padding: const EdgeInsets.only(right: 15,top: 10),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   InkWell(
        //                     onTap: (){
        //                       recentorderController.index(0);
        //                     },
        //                     child: Text("Today",
        //                                         style: TextStyle(
        //                                           fontWeight: FontWeight.w400,
        //                                           fontSize: 22,
        //                                         ),
        //                                         ),
        //                   ),
        //               InkWell(
        //                 onTap: (){
        //                   recentorderController.index(0);
        //                 },
        //                 child: Container(
        //                   height: 25,
        //                   width: 25,
        //                   child: Center(
        //                     child: Container(
        //                       height: 20,
        //                       width: 20,
        //                       decoration: BoxDecoration(
        //                         color: recentorderController.index.value == 0 ? primaryColor : Color.fromARGB(255, 233, 232, 232),
        //                         borderRadius: BorderRadius.circular(10)
        //                       ),
        //                     ),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color:Color.fromARGB(255, 233, 232, 232),
        //                     borderRadius: BorderRadius.circular(15)
        //                   ),
        //                 ),
        //               ),
        //                 ],
        //               ),
        //             ),
        //              Padding(
        //               padding: const EdgeInsets.only(right: 15,top: 20),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   InkWell(
        //                      onTap: (){
        //                       recentorderController.index(1);
        //                     },
        //                     child: Text("yesterday",
        //                                         style: TextStyle(
        //                                           fontWeight: FontWeight.w400,
        //                                           fontSize: 22,
        //                                         ),
        //                                         ),
        //                   ),
        //               InkWell(
        //                 onTap: (){
        //                   recentorderController.index(1);
        //                 },
        //                 child: Container(
        //                   height: 25,
        //                   width: 25,
        //                   child: Center(
        //                     child: Container(
        //                       height: 20,
        //                       width: 20,
        //                       decoration: BoxDecoration(
        //                         color:recentorderController.index.value == 1 ? primaryColor : Color.fromARGB(255, 233, 232, 232),
        //                         borderRadius: BorderRadius.circular(10)
        //                       ),
        //                     ),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color:Color.fromARGB(255, 233, 232, 232),
        //                     borderRadius: BorderRadius.circular(15)
        //                   ),
        //                 ),
        //               ),
        //                 ],
        //               ),
        //             ),
        //              Padding(
        //               padding: const EdgeInsets.only(right: 15,top: 20),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   InkWell(
        //                      onTap: (){
        //                       recentorderController.index(2);
        //                     },
        //                     child: Text("week",
        //                                         style: TextStyle(
        //                                           fontWeight: FontWeight.w400,
        //                                           fontSize: 22,
        //                                         ),
        //                                         ),
        //                   ),
        //               InkWell(
        //                 onTap: (){
        //                   recentorderController.index(2);
        //                 },
        //                 child: Container(
        //                   height: 25,
        //                   width: 25,
        //                   child: Center(
        //                     child: Container(
        //                       height: 20,
        //                       width: 20,
        //                       decoration: BoxDecoration(
        //                         color:recentorderController.index.value == 2 ? primaryColor : Color.fromARGB(255, 233, 232, 232),
        //                         borderRadius: BorderRadius.circular(10)
        //                       ),
        //                     ),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color:  Color.fromARGB(255, 233, 232, 232),
        //                     borderRadius: BorderRadius.circular(15)
        //                   ),
        //                 ),
        //               ),
        //                 ],
        //               ),
        //             ),
        //              Padding(
        //               padding: const EdgeInsets.only(right: 15,top: 20,bottom: 20),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   InkWell(
        //                      onTap: (){
        //                       recentorderController.index(3);
        //                     },
        //                     child: Text("Month",
        //                                         style: TextStyle(
        //                                           fontWeight: FontWeight.w400,
        //                                           fontSize: 22,
        //                                         ),
        //                                         ),
        //                   ),
        //               InkWell(
        //                 onTap: (){
        //                   recentorderController.index(3);
        //                 },
        //                 child: Container(
        //                   height: 25,
        //                   width: 25,
        //                   child: Center(
        //                     child: Container(
        //                       height: 20,
        //                       width: 20,
        //                       decoration: BoxDecoration(
        //                         color: recentorderController.index.value == 3 ? primaryColor : Color.fromARGB(255, 233, 232, 232),
        //                         borderRadius: BorderRadius.circular(10)
        //                       ),
        //                     ),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     color: Color.fromARGB(255, 233, 232, 232) ,
        //                     borderRadius: BorderRadius.circular(15)
        //                   ),
        //                 ),
        //               ),
        //                 ],
        //               ),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Container(
        //                   height: 35,
        //                   width: 80,
        //                   child: Center(
        //                     child: Text("Cancel",
        //                      style: TextStyle(color: primaryColor,fontSize: 15,fontWeight: FontWeight.w500),
        //                     ),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     border: Border.all(color: primaryColor),
        //                     borderRadius: BorderRadius.circular(10)
        //                   ),
        //                 ),
        //                 SizedBox(width: 10,),
        //                  InkWell(
        //                   onTap: (){
        //                     if(recentorderController.index.value == 0){
        //                       Get.to(FilterScreen(title: "Today"));
        //                     }else if(recentorderController.index.value == 1){
        //                       Get.to(FilterScreen(title: "Yesterday"));
        //                     }else if(recentorderController.index.value == 2){
        //                       Get.to(FilterScreen(title: "Week"));
        //                     }else{
        //                       Get.to(FilterScreen(title: "Month"));
        //                     }
        //                   },
        //                    child: Container(
        //                     height: 35,
        //                     width: 80,
        //                     child: Center(
        //                       child: Text("Apply",
        //                        style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),
        //                       ),
        //                     ),
        //                     decoration: BoxDecoration(
        //                       color: primaryColor,
        //                       borderRadius: BorderRadius.circular(10)
        //                     ),
        //                                          ),
        //                  ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
              
        //     ),
        //   );
        // });
        //             },
        //             child: Image(image: AssetImage("assets/icons/filtertick.png"))),
        //         ],
                centerTitle: true,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Container(
              //     height: 50,
              //     width: size.width,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(12)),
              //     alignment: Alignment.center,
              //     child: Row(
              //       children: [
              //         const Padding(
              //           padding: EdgeInsets.only(left: 10, right: 10),
              //           child: Icon(Icons.search),
              //         ),
              //         Expanded(
              //           child: TextField(
              //             decoration: InputDecoration.collapsed(
              //                 hintText: "Search",
              //                 hintStyle: primaryFont.copyWith(
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.w600,
              //                     color: Colors.black)),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                _showDatePicker(context);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectdt),
                      const Icon(Icons.date_range_outlined,color: Colors.grey,),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.only(left: 8,right: 8,),
            child: InkWell(
              onTap: (){
                _showDatePicker1(context);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectdt1),
                      const Icon(Icons.date_range_outlined,color: Colors.grey,),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: itemController.listdata.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 150,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                        ),
                      ]
                    ),
                    child: Column(
                      children: [
                        Text(itemController.listdata[index].tipodoc),
                      ],
                    ),
                  ),
                );
              }),
          )
        ],
      ),
      // body: ListView(
      //   children: [
      //     const SizedBox(
      //       height: 15,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15, right: 15),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             children: [
      //               Image(image: AssetImage("assets/icons/usericon.png")),
      //               SizedBox(width: 10,),
      //               Text("Zavir",
      //               style: primaryFont.copyWith(
      //                 fontSize: 22,
      //                                 fontWeight: FontWeight.w600,
      //                                 color: Colors.black
      //               ),
      //               ),
                    
      //             ],
      //           ),
      //           Row(
      //                 children: [
      //                   Text("9150",
      //                   style: primaryFont.copyWith(
      //                     fontSize: 20,
      //                                     fontWeight: FontWeight.w600,
      //                                     color: Colors.green
      //                   ),
      //                   ),
      //                 ],
      //               ),
      //         ],
      //       ),
            
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 18,right: 18,top: 15),
      //       child: Divider(thickness: 1,color: Colors.black,),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             children: [
      //               Image(image: AssetImage("assets/icons/usericon.png")),
      //               SizedBox(width: 10,),
      //               Text("Zavir",
      //               style: primaryFont.copyWith(
      //                 fontSize: 22,
      //                                 fontWeight: FontWeight.w600,
      //                                 color: Colors.black
      //               ),
      //               ),
                    
      //             ],
      //           ),
      //           Row(
      //                 children: [
      //                   Text("9150",
      //                   style: primaryFont.copyWith(
      //                     fontSize: 20,
      //                                     fontWeight: FontWeight.w600,
      //                                     color: Colors.green
      //                   ),
      //                   ),
      //                 ],
      //               ),
      //         ],
      //       ),
            
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 18,right: 18,top: 15),
      //       child: Divider(thickness: 1,color: Colors.black,),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             children: [
      //               Image(image: AssetImage("assets/icons/usericon.png")),
      //               SizedBox(width: 10,),
      //               Text("Zavir",
      //               style: primaryFont.copyWith(
      //                 fontSize: 22,
      //                                 fontWeight: FontWeight.w600,
      //                                 color: Colors.black
      //               ),
      //               ),
                    
      //             ],
      //           ),
      //           Row(
      //                 children: [
      //                   Text("9150",
      //                   style: primaryFont.copyWith(
      //                     fontSize: 20,
      //                                     fontWeight: FontWeight.w600,
      //                                     color: Colors.green
      //                   ),
      //                   ),
      //                 ],
      //               ),
      //         ],
      //       ),
            
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 18,right: 18,top: 15),
      //       child: Divider(thickness: 1,color: Colors.black,),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Row(
      //             children: [
      //               Image(image: AssetImage("assets/icons/usericon.png")),
      //               SizedBox(width: 10,),
      //               Text("Zavir",
      //               style: primaryFont.copyWith(
      //                 fontSize: 22,
      //                                 fontWeight: FontWeight.w600,
      //                                 color: Colors.black
      //               ),
      //               ),
                    
      //             ],
      //           ),
      //           Row(
      //                 children: [
      //                   Text("9150",
      //                   style: primaryFont.copyWith(
      //                     fontSize: 20,
      //                                     fontWeight: FontWeight.w600,
      //                                     color: Colors.green
      //                   ),
      //                   ),
      //                 ],
      //               ),
      //         ],
      //       ),
            
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 18,right: 18,top: 15),
      //       child: Divider(thickness: 1,color: Colors.black,),
      //     ),
      //   ],
      // ),
    );
  }
}
