// To parse this JSON data, do
//
//     final priceList = priceListFromJson(jsonString);

import 'dart:convert';

PriceList? priceListFromJson(String str) => PriceList.fromJson(json.decode(str));

String priceListToJson(PriceList? data) => json.encode(data!.toJson());

class PriceList {
    PriceList({
       
        this.data,
    });

   
    List<ItemPrice?>? data;

    factory PriceList.fromJson(Map<String, dynamic> json) => PriceList(
      
        data: json["Data"] == null ? [] : List<ItemPrice?>.from(json["Data"]!.map((x) => ItemPrice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    };
}

class ItemPrice {
    ItemPrice({
        this.price,
        this.discount,
    });

    dynamic price;
    dynamic discount;

    factory ItemPrice.fromJson(Map<String, dynamic> json) => ItemPrice(
        price: json["Price"],
        discount: json["Discount"],
    );

    Map<String, dynamic> toJson() => {
        "Price": price,
        "Discount": discount,
    };
}

class Field {
    Field({
        this.name,
        this.alias,
        this.isDrillDown,
    });

    String? name;
    String? alias;
    bool? isDrillDown;

    factory Field.fromJson(Map<String, dynamic> json) => Field(
        name: json["Name"],
        alias: json["Alias"],
        isDrillDown: json["IsDrillDown"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Alias": alias,
        "IsDrillDown": isDrillDown,
    };
}
