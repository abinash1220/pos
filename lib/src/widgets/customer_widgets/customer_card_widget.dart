import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/views/customers_view/customer_details_view.dart';
import 'package:pos/src/views/customers_view/invoice_view.dart';

class CustomerCardWidget extends StatelessWidget {
  String name;
  String number;
  String clientId;
  CustomerCardWidget({super.key, required this.name, required this.number, required this.clientId});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: InkWell(
        onTap: () {
          print("client id: $clientId");
          Get.to(() => InvoiceView(client: clientId));
        },
        child: Container(
          height: 70,
          width: size.width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 3, color: Colors.grey.withOpacity(0.5))
          ], borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.person_circle_fill,
                      size: 48,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: primaryFont.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Text(
                            number,
                            style: primaryFont.copyWith(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Get.to(() => CustomerDetailsView(
                    //       title: "Customer Details",
                    //     ));
                  },
                  child: Icon(Icons.remove_red_eye,size: 25,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
