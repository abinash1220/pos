// To parse this JSON data, do
//
//     final priceList = priceListFromJson(jsonString);

import 'dart:convert';

PriceList priceListFromJson(String str) => PriceList.fromJson(json.decode(str));

String priceListToJson(PriceList data) => json.encode(data.toJson());

class PriceList {
    PriceList({
        required this.fields,
        required this.data,
    });

    List<Field> fields;
    List<ItemPrice> data;

    factory PriceList.fromJson(Map<String, dynamic> json) => PriceList(
        fields: List<Field>.from(json["Fields"].map((x) => Field.fromJson(x))),
        data: List<ItemPrice>.from(json["Data"].map((x) => ItemPrice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ItemPrice {
    ItemPrice({
        required this.artigo,
        required this.descricao,
        this.marca,
         this.price,
        required this.iva,
         this.discount,
        this.validade,
        required this.lote,
         this.stock,
        required this.categ,
        required this.unidadeBase,
    });

    String artigo;
    String descricao;
    String? marca;
    dynamic price;
    String iva;
    dynamic discount;
    dynamic validade;
    String lote;
    dynamic stock;
    String categ;
    String unidadeBase;

    factory ItemPrice.fromJson(Map<String, dynamic> json) => ItemPrice(
        artigo: json["Artigo"]??"",
        descricao: json["Descricao"]??"",
        marca: json["Marca"]??"",
        price: json["Price"],
        iva: json["iva"]??"",
        discount: json["Discount"],
        validade: json["Validade"]??"",
        lote: json["Lote"]??"",
        stock: json["Stock"],
        categ: json["Categ"]??"",
        unidadeBase: json["UnidadeBase"]??"",
    );

    Map<String, dynamic> toJson() => {
        "Artigo": artigo,
        "Descricao": descricao,
        "Marca": marca,
        "Price": price,
        "iva": iva,
        "Discount": discount,
        "Validade": validade,
        "Lote": lote,
        "Stock": stock,
        "Categ": categ,
        "UnidadeBase": unidadeBase,
    };
}

class Field {
    Field({
        required this.name,
        required this.alias,
        required this.isDrillDown,
    });

    String name;
    String alias;
    bool isDrillDown;

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
