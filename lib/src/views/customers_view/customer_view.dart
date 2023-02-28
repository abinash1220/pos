import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/customer_api_controller/customer_api_controller.dart';
import 'package:pos/src/controllers/invoice_controllers/invoice_controller.dart';
import 'package:pos/src/views/customers_view/customer_details_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/customer_widgets/customer_card_widget.dart';

class CustomerSView extends StatefulWidget {
  const CustomerSView({super.key});

  @override
  State<CustomerSView> createState() => _CustomerSViewState();
}

class _CustomerSViewState extends State<CustomerSView> {
  final customerapicontroller = Get.find<CustomerApiController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //customerapicontroller.customer(context: context);
    getUsername();
    
    Get.find<InvoiceController>().getOfflineSavedInvoices();
  }
   
   
  getUsername () async {
    final prefs = await SharedPreferences.getInstance();
       String? username = prefs.getString("username");
      //  Get.snackbar(username.toString(), "");
       customerapicontroller.customerlist(context: context, userid: username!);
  }

  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                title: Text(
                  "Customers".tr,
                  style: primaryFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
              ),
              
            ],
          ),
        ),
      ),
      body: GetBuilder<CustomerApiController>(builder: (_) {
        return ListView.builder(
          itemCount: customerapicontroller.customerlistdata.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: CustomerCardWidget(
                clientId: customerapicontroller.customerlistdata[index].cliente,
                name: customerapicontroller.customerlistdata[index].nome,
                number: customerapicontroller.customerlistdata[index].facMor,
              ),
            );
          },
        );
      }),
    );
  }
}
