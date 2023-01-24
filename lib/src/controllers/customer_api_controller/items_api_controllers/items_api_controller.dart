import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pos/src/models/items_api_models/items_list_api_model.dart';
import 'package:pos/src/services/items_api_services/create_items_api_service.dart';
import 'package:pos/src/services/items_api_services/item_pricelist_api_service.dart';
import 'package:pos/src/services/items_api_services/list_items_api_service.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/widgets/snackbar_widgets/incorrect.dart';

import '../../../models/items_api_models/item_pricelist_model.dart';
import '../../../models/items_api_models/product_list_model.dart';

class CreateItemsApiController extends GetxController{
  CreateItemsApiServices createItemsApiServices = CreateItemsApiServices();
  //ListItemsApiService listItemsApiService = ListItemsApiService();
  ItemPriceListService itemPriceListService = ItemPriceListService();

 //List<ItemData?>? itemdata = [];

 List<ItemPrice?>? pricelist = [];

  RxString item = "null".obs;

  
  itemsCreate({
       required BuildContext context,
       required String items,
       required String description,
       required String iva,
       required String caracteristicas,
       required String codBarras,
       required String unidadeBase,
       required String peso,
       required String volume,
       required String marca,
  }) async {
   
    dio.Response<dynamic> response = await createItemsApiServices.createItems(
      items: items,
      description: description,
      iva: iva,
      caracteristicas: caracteristicas,
      codBarras: codBarras,
      unidadeBase: unidadeBase,
      peso: peso,
      volume: volume,
      marca: marca,
      );
       print(":::::::::::::::::Create items Status ::::::::::::::::::");
    print(response.statusCode);
    if(response.statusCode == 204){

        Get.offAll(HomePageWithNavigation(
          index: 0,
        ));

    }else {
         ScaffoldMessenger.of(context).showSnackBar(incorrect);
    }
  }

  // listitems({
  //   required BuildContext context,
  // }) async {
  //      dio.Response<dynamic> response = await listItemsApiService.listItemsdata();

  //      if(response.statusCode == 200){

  //        ProductList itemlist = ProductList.fromJson(response.data);
  //        itemdata = itemlist.data;

  //        update();

  //      }else{
  //       //ScaffoldMessenger.of(context).showSnackBar(incorrect);
  //      }
  // }

 Future<List<ItemPrice?>?> listOfitems({
    required String client,
    required String wareHouse
  }) async {

        
        dio.Response<dynamic> response = await itemPriceListService.itempricelist(client: client,wareHouse: wareHouse);
         
          print(response.statusCode.toString());
        
          print(response.data["data"]);
          PriceList itempricelists = PriceList.fromJson(response.data);
          pricelist = itempricelists.data;

          print("::::::::::::::::printing price list::::::::::::::");
          print(pricelist);
          
          
      
        return pricelist;
  }

}