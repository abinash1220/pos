import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pos/src/const/api_cachekey.dart';
import 'package:pos/src/models/items_api_models/items_list_api_model.dart';
import 'package:pos/src/services/items_api_services/create_items_api_service.dart';
import 'package:pos/src/services/items_api_services/item_pricelist_api_service.dart';
import 'package:pos/src/services/items_api_services/list_items_api_service.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/widgets/snackbar_widgets/incorrect.dart';

import '../../../models/items_api_models/item_pricelist_model.dart';
import '../../../models/items_api_models/product_list_model.dart';

class CreateItemsApiController extends GetxController {
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
    if (response.statusCode == 204) {
      Get.offAll(HomePageWithNavigation(
        index: 0,
      ));
    } else {
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

  Future<List<ItemPrice?>?> listOfitems(
      {required String client, required String wareHouse}) async {
    // var isChacheExist = await APICacheManager().isAPICacheKeyExist(pricelistKey);
    bool result = await InternetConnectionChecker().hasConnection;

    if (result) {
      dio.Response<dynamic> response = await itemPriceListService.itempricelist(
          client: client, wareHouse: wareHouse);

      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: customerlistkey, syncData: jsonEncode(response.data));

        await APICacheManager().addCacheData(cacheDBModel);

        PriceList itempricelists = PriceList.fromJson(response.data);
        pricelist = itempricelists.data;

        print("::::::::::::::::printing price list::::::::::::::");
        print(response.statusCode);

        return pricelist;
      }
    } else {
      var cacheData = await APICacheManager().getCacheData(pricelistKey);

      PriceList itempricelists =
          PriceList.fromJson(json.decode(cacheData.syncData));
      pricelist = itempricelists.data;

      update();
    }
  }
}
