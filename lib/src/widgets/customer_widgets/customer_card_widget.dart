import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/views/customers_view/customer_details_view.dart';
import 'package:pos/src/views/customers_view/invoice_view.dart';

class CustomerCardWidget extends StatelessWidget {
  String name;
  String number;
  String clientId;
  CustomerCardWidget({super.key, required this.name, required this.number, required this.clientId});

  TextEditingController nomeEditingController = TextEditingController();
  TextEditingController numContribuinteEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: InkWell(
        onTap: () {
          print("client id: $clientId");
          if("${clientId[0]}${clientId[1]}" == "FR"){
            _dialogBuilder(context);
          }else
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
 
 Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           title: const Text('Please fill the fields'),
          content: SizedBox(
            height: 155,
            child: Column(
              children: [
                 Container(
                  height: 45,
                  child: TextField(
                    controller: nomeEditingController,
                    decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        hintText: 'Enter nome',
                        labelStyle: primaryFont.copyWith(color: primaryColor)),
                  ),
                ),
                const SizedBox(height: 10,),
                 Container(
                  height: 45,
                  child: TextField(
                    controller: numContribuinteEditingController,
                    decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        hintText: 'Enter numContribuinte',
                        labelStyle: primaryFont.copyWith(color: primaryColor)),
                  ),
                ),
                const SizedBox(height: 10,),
                 Container(
                  height: 45,
                  child: TextField(
                    controller: numContribuinteEditingController,
                    decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: primaryColor,
                        )),
                        hintText: 'Enter moradafac',
                        labelStyle: primaryFont.copyWith(color: primaryColor)),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
           InkWell(
            onTap: (){
              Get.to(InvoiceView(client: clientId));
            },
             child: Container(
              height: 30,
              width: 65,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child:const  Center(
                child: Text("Submit",
                style: TextStyle(color: Colors.white),),
              ),
             ),
           ),
                   const SizedBox(width: 20,),
                   const SizedBox(height: 10,),
          ],
          
        );
      },
    );
  }
}
