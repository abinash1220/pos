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
import 'package:pos/src/models/recent_order_model.dart';
import 'package:pos/src/services/items_api_services/create_items_api_service.dart';
import 'package:pos/src/services/items_api_services/item_pricelist_api_service.dart';
import 'package:pos/src/services/recent_order_api_services/recent_order_api_serive.dart';
import 'package:pos/src/views/home_view/home_navigation_bar.dart';
import 'package:pos/src/widgets/snackbar_widgets/incorrect.dart';

class CreateItemsApiController extends GetxController {
  CreateItemsApiServices createItemsApiServices = CreateItemsApiServices();
  //ListItemsApiService listItemsApiService = ListItemsApiService();
  ItemPriceListService itemPriceListService = ItemPriceListService();
  RecentOrderApiSevice recentOrderApiService = RecentOrderApiSevice();

  //List<ItemData?>? itemdata = [];

  List<ItemPrice?>? pricelist = [];

  List<ListData> listdata = [];

  RxString item = "null".obs;

  //recent order list
  recentOrder({
    required String series,
    required String fromdate,
    required String todate,
  }) async {
    Get.snackbar(fromdate, todate);
    dio.Response<dynamic> response =
        await recentOrderApiService.recentOrderList(
            series: series,
            fromdate: "$fromdate 00:00:00",
            todate: "$todate 00:00:00");

    if (response.statusCode == 200) {
      RecentOrderList recentOrderList = RecentOrderList.fromJson(response.data);
      listdata = recentOrderList.data;
      update();
    } else {
      Get.snackbar(response.statusCode.toString(), "something went wrong");
    }
    update();
  }

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
    Get.snackbar(response.statusCode.toString(), "create items");
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
      // Get.snackbar(client, wareHouse);
      dio.Response<dynamic> response = await itemPriceListService.itempricelist(
          client: client, wareHouse: wareHouse);
      // Get.snackbar(response.statusCode.toString(), client);
      if (response.statusCode == 200) {
        APICacheDBModel cacheDBModel = new APICacheDBModel(
            key: pricelistKey, syncData: jsonEncode(response.data));

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
