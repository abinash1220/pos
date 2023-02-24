import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/home_controllers.dart';
import 'package:pos/src/controllers/location_and_firebase_controllers/location_and_firabse_controller.dart';
import 'package:pos/src/controllers/login_api_controllers/login_api_controller.dart';
import 'package:pos/src/models/staff_model.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/views/item_details_view/item_details_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.find<HomeController>();

  final loginApiController = Get.find<LoginApiController>();
  final locationandFirebaseControll = Get.find<LocationAndFirebaseController>();

  int isUserIn = 0;
  bool isLoading = false;

  List<_SalesData> data = [
    _SalesData('Mon'.tr, 5000),
    _SalesData('Tue'.tr, 3000),
    _SalesData('Wed'.tr, 4000),
    _SalesData('Thu'.tr, 7000),
    _SalesData('Fri'.tr, 3000)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginApiController.listUserSerie();
    setInOutState();
  }

  setInOutState() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");

    List<EmployeeModel> todaysList = await locationandFirebaseControll
        .generateUserHistory(username!.trim(), DateTime.now());
    setState(() {
      isLoading = false;
    });
    if (todaysList.isEmpty) {
      setState(() {
        isUserIn = 0;
      });
    } else {
      if (todaysList.last.isIn == true && todaysList.last.isOut == false) {
        setState(() {
          isUserIn = 1;
        });
      } else if (todaysList.last.isIn == true &&
          todaysList.last.isOut == true) {
        setState(() {
          isUserIn = 3;
        });
      }
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
                title: Text(
                  "Dashboard".tr.toUpperCase(),
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
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Sale".tr,
                          style: primaryFont.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "\$12,000",
                          style: primaryFont.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
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
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                        ),
                        series: <ChartSeries<_SalesData, String>>[
                          StackedLineSeries<_SalesData, String>(
                              color: Colors.white,
                              dataSource: data,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) =>
                                  sales.sales,
                              // name: 'Sales',
                              markerSettings:
                                  const MarkerSettings(isVisible: true))
                          // Enable data label
                          //dataLabelSettings: DataLabelSettings(isVisible: true,color: Colors.amber))
                        ],
                        primaryXAxis: CategoryAxis(
                            labelStyle: const TextStyle(color: Colors.white)),
                        primaryYAxis: CategoryAxis(
                          labelStyle: const TextStyle(color: Colors.white),
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  )
                : Column(
                    children: [
                      if (isUserIn == 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 7),
                          child: InkWell(
                            onTap: () {
                              inConfirmationDialog(context);
                            },
                            child: Container(
                              height: 60,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.grey.withOpacity(0.2))
                                  ],
                                  borderRadius: BorderRadius.circular(12)),
                              alignment: Alignment.center,
                              child: Text(
                                "In",
                                style: primaryFont.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      if (isUserIn == 1)
                        Padding(
                          padding: const EdgeInsets.only(left: 7, right: 5),
                          child: InkWell(
                            onTap: () {
                              outConfirmationDialog(context);
                            },
                            child: Container(
                              height: 60,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.grey.withOpacity(0.2))
                                  ],
                                  borderRadius: BorderRadius.circular(12)),
                              alignment: Alignment.center,
                              child: Text(
                                "Out",
                                style: primaryFont.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      if (isUserIn == 3)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "In & Out Completed",
                                    style: primaryFont.copyWith(
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  editConfirmationDialog(context);
                                },
                                child: Container(
                                  height: 25,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blue),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Edit",
                                    style: primaryFont.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
          ),
          const SizedBox(
            height: 10,
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
                          "Orders".tr,
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

  editConfirmationDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        // locationandFirebaseControll.markAsIn();
        setState(() {
          isUserIn = 0;
        });
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure ?"),
      content: const Text(
          "This will Enable you to Re-enter todays \"In\" and \"out\""),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  inConfirmationDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        locationandFirebaseControll.markAsIn();
        setState(() {
          isUserIn = 1;
        });
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure ?"),
      content: const Text("This will mark you as IN"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  outConfirmationDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        locationandFirebaseControll.markAsOut();
        setState(() {
          isUserIn = 3;
        });
        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure ?"),
      content: const Text("This will mark you as OUT"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
