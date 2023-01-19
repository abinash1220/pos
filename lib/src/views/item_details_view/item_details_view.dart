import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/customer_api_controller/items_api_controllers/items_api_controller.dart';
import 'package:pos/src/widgets/customer_widgets/customer_details_fields.dart';
import 'package:pos/src/widgets/item_details_widgets/item_row_text_field.dart';

class ItemDetailsView extends StatefulWidget {
  String title;
  ItemDetailsView({super.key, required this.title});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {

   final creteItemsApiController = Get.find<CreateItemsApiController>();

   TextEditingController itemscontroller = TextEditingController();
   TextEditingController descriptioncontroller = TextEditingController();
   TextEditingController ivacontroller = TextEditingController();
   TextEditingController marcacontroller = TextEditingController();
   TextEditingController caracteristicascontroller = TextEditingController();
   TextEditingController codBarrascontroller = TextEditingController();
   TextEditingController unidadeBasecontroller = TextEditingController();
   TextEditingController pesocontroller = TextEditingController();
   TextEditingController volumecontroller = TextEditingController();
   TextEditingController democontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_sharp)),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                        onTap: () {
                          creteItemsApiController.itemsCreate(
                            context: context, 
                            items: itemscontroller.text, 
                            description: descriptioncontroller.text, 
                            iva: ivacontroller.text, 
                            caracteristicas: caracteristicascontroller.text, 
                            codBarras: codBarrascontroller.text, 
                            unidadeBase: unidadeBasecontroller.text, 
                            peso: pesocontroller.text, 
                            volume: volumecontroller.text, 
                            marca: marcacontroller.text
                            );
                        },
                        child: const Icon(
                          Icons.save,
                          color: Colors.white,
                        )),
                  )
                ],
                title: Text(
                  widget.title,
                  style: primaryFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          CustomerDetailsField(
            controller:itemscontroller ,
            titile: "Item",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomerDetailsField(
            controller: descriptioncontroller,
            titile: "Description",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomerDetailsField(
            controller: ivacontroller,
            titile: "IVA",
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Sale Pr.in the AKZ currency",
              style: primaryFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "RSP 1:",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "RSP 2:",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "RSP 3:",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "RSP 4:",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "RSP 5:",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomerDetailsField(
            controller: pesocontroller,
            titile: "Farmula",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomerDetailsField(
            controller:volumecontroller,
            titile: "Subfarmula",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomerDetailsField(
            controller: marcacontroller,
            titile: "Marca",
          ),
          const SizedBox(
            height: 10,
          ),
          CustomerDetailsField(
            controller: codBarrascontroller,
            titile: "Modelo",
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Moving Units",
              style: primaryFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: unidadeBasecontroller,
            title: "Base :",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "Compra :",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "Venda :",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "Entrada :",
          ),
          const SizedBox(
            height: 10,
          ),
          ItemRowTextField(
            controller: democontroller,
            title: "Saida :",
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
