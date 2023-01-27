import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/home_controllers.dart';
import 'package:pos/src/controllers/login_api_controllers/login_api_controller.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/views/item_details_view/item_details_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.find<HomeController>();

  final loginApiController = Get.find<LoginApiController>();

  List<_SalesData> data = [
    _SalesData('Mon', 5000),
    _SalesData('Tue', 3000),
    _SalesData('Wed', 4000),
    _SalesData('Thu', 7000),
    _SalesData('Fri', 3000)
  ];
  
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginApiController.listUserSerie();
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
                title: Text(
                  "Dashboard".toUpperCase(),
                  style: primaryFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
                actions: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                            onTap: () {
                              Get.to(
                                  () => ItemDetailsView(title: "Item Details"));
                            },
                            child: Image.asset(
                              "assets/icons/boxadd.png",
                              height: 25,
                              fit: BoxFit.fitHeight,
                            )),
                      ),
                    ],
                  )
                ],
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
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
              height: 185,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromARGB(255, 103, 66, 206),
                        Color(0xFF4000F6),
                      ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Sale",
                        style: primaryFont.copyWith(color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 15
                        ),
                        ),
                        Text("\$12,000",
                        style: primaryFont.copyWith(color: Colors.white,fontWeight: FontWeight.bold,
                        fontSize: 15
                        ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 150,
                      child: SfCartesianChart(
                        
                            // Chart title
                            // Enable legend
                           // legend: Legend(isVisible: true,),
                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true,),
                            series: <ChartSeries<_SalesData, String>>[
                              StackedLineSeries<_SalesData, String>(
                                color: Colors.white,
                                  dataSource: data,
                                  xValueMapper: (_SalesData sales, _) => sales.year,
                                  yValueMapper: (_SalesData sales, _) => sales.sales,
                                 // name: 'Sales',
                                  markerSettings: MarkerSettings(isVisible: true)
                                  )
                                  // Enable data label
                                  //dataLabelSettings: DataLabelSettings(isVisible: true,color: Colors.amber))
                            ],
                            primaryXAxis: CategoryAxis(
                              labelStyle: TextStyle(color: Colors.white)
                            ),
                            primaryYAxis:CategoryAxis(
                              labelStyle: TextStyle(color: Colors.white),
                              minimum: 0,
                              maximum: 10000,
                              desiredIntervals: 5,
                            ), 
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () {
                Get.offAll(() => HomePageWithNavigation(
                      index: 2,
                    ));
              },
              child: Container(
                height: 60,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, color: Colors.grey.withOpacity(0.2))
                    ],
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 8, top: 5, bottom: 5),
                          child: Container(
                            height: 60,
                            width: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor),
                            child: Image.asset("assets/icons/bag_igon.png"),
                          ),
                        ),
                        Text(
                          "Orders",
                          style: primaryFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // Obx(
          //   () => Padding(
          //     padding: const EdgeInsets.only(left: 15, right: 15),
          //     child: InkWell(
          //       onTap: () {
          //         homeController
          //             .isRecentShown(!homeController.isRecentShown.value);
          //       },
          //       child: Container(
          //         width: size.width,
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                   blurRadius: 2, color: Colors.grey.withOpacity(0.2))
          //             ],
          //             borderRadius: BorderRadius.circular(12)),
          //         child: Padding(
          //           padding: const EdgeInsets.only(top: 15, bottom: 15),
          //           child: Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.only(left: 10),
          //                     child: Text(
          //                       "Recent Orders",
          //                       style: primaryFont.copyWith(
          //                           fontSize: 18, fontWeight: FontWeight.w600),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(right: 10),
          //                     child: homeController.isRecentShown.isTrue
          //                         ? Icon(
          //                             Icons.keyboard_arrow_up_rounded,
          //                             size: 35,
          //                           )
          //                         : Icon(
          //                             Icons.keyboard_arrow_down_rounded,
          //                             size: 35,
          //                           ),
          //                   )
          //                 ],
          //               ),
          //               if (homeController.isRecentShown.isTrue)
          //                 Column(
          //                   children: [
          //                     const SizedBox(
          //                       height: 10,
          //                     ),
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.only(left: 10, right: 10),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               const Icon(
          //                                 CupertinoIcons.person_circle_fill,
          //                                 size: 33,
          //                               ),
          //                               const SizedBox(
          //                                 width: 10,
          //                               ),
          //                               Text(
          //                                 "Zavir",
          //                                 style: primaryFont.copyWith(
          //                                     fontSize: 15,
          //                                     fontWeight: FontWeight.w600),
          //                               )
          //                             ],
          //                           ),
          //                           Text(
          //                             "\$9150",
          //                             style: primaryFont.copyWith(
          //                                 color: Colors.green,
          //                                 fontWeight: FontWeight.w600),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: 10,
          //                     ),
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.only(left: 10, right: 10),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               const Icon(
          //                                 CupertinoIcons.person_circle_fill,
          //                                 size: 33,
          //                               ),
          //                               const SizedBox(
          //                                 width: 10,
          //                               ),
          //                               Text(
          //                                 "Zavir",
          //                                 style: primaryFont.copyWith(
          //                                     fontSize: 15,
          //                                     fontWeight: FontWeight.w600),
          //                               )
          //                             ],
          //                           ),
          //                           Text(
          //                             "\$9150",
          //                             style: primaryFont.copyWith(
          //                                 color: Colors.green,
          //                                 fontWeight: FontWeight.w600),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: 10,
          //                     ),
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.only(left: 10, right: 10),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               const Icon(
          //                                 CupertinoIcons.person_circle_fill,
          //                                 size: 33,
          //                               ),
          //                               const SizedBox(
          //                                 width: 10,
          //                               ),
          //                               Text(
          //                                 "Zavir",
          //                                 style: primaryFont.copyWith(
          //                                     fontSize: 15,
          //                                     fontWeight: FontWeight.w600),
          //                               )
          //                             ],
          //                           ),
          //                           Text(
          //                             "\$9150",
          //                             style: primaryFont.copyWith(
          //                                 color: Colors.green,
          //                                 fontWeight: FontWeight.w600),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       height: 10,
          //                     ),
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.only(left: 10, right: 10),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Row(
          //                             children: [
          //                               const Icon(
          //                                 CupertinoIcons.person_circle_fill,
          //                                 size: 33,
          //                               ),
          //                               const SizedBox(
          //                                 width: 10,
          //                               ),
          //                               Text(
          //                                 "Zavir",
          //                                 style: primaryFont.copyWith(
          //                                     fontSize: 15,
          //                                     fontWeight: FontWeight.w600),
          //                               )
          //                             ],
          //                           ),
          //                           Text(
          //                             "\$9150",
          //                             style: primaryFont.copyWith(
          //                                 color: Colors.green,
          //                                 fontWeight: FontWeight.w600),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
