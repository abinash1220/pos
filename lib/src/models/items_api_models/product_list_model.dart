// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'dart:convert';

ProductList? productListFromJson(String str) => ProductList.fromJson(json.decode(str));

String productListToJson(ProductList? data) => json.encode(data!.toJson());

class ProductList {
    ProductList({
        this.fields,
        this.data,
    });

    List<Field?>? fields;
    List<ItemData?>? data;

    factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        fields: json["Fields"] == null ? [] : List<Field?>.from(json["Fields"]!.map((x) => Field.fromJson(x))),
        data: json["Data"] == null ? [] : List<ItemData?>.from(json["Data"]!.map((x) => ItemData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x!.toJson())),
        "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    };
}

class ItemData {
    ItemData({
        this.item,
        this.description,
        this.baseUnit,
        this.moeda,
        this.rsp1,
        this.rsp2,
        this.rsp3,
        this.vat,
    });

    String? item;
    String? description;
    String? baseUnit;
    String? moeda;
    dynamic rsp1;
    dynamic rsp2;
    dynamic rsp3;
    String? vat;

    factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        item: json["Item"],
        description: json["Description"],
        baseUnit: json["Base Unit"],
        moeda: json["Moeda"],
        rsp1: json["RSP1"],
        rsp2: json["RSP2"],
        rsp3: json["RSP3"],
        vat: json["VAT"],
    );

    Map<String, dynamic> toJson() => {
        "Item": item,
        "Description": description,
        "Base Unit": baseUnit,
        "Moeda": moeda,
        "RSP1": rsp1,
        "RSP2": rsp2,
        "RSP3": rsp3,
        "VAT": vat,
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

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
