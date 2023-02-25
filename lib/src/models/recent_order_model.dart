// To parse this JSON data, do
//
//     final recentOrderList = recentOrderListFromJson(jsonString);

import 'dart:convert';

RecentOrderList recentOrderListFromJson(String str) => RecentOrderList.fromJson(json.decode(str));

String recentOrderListToJson(RecentOrderList data) => json.encode(data.toJson());

class RecentOrderList {
    RecentOrderList({
        required this.fields,
        required this.data,
    });

    List<Field> fields;
    List<ListData> data;

    factory RecentOrderList.fromJson(Map<String, dynamic> json) => RecentOrderList(
        fields: List<Field>.from(json["Fields"].map((x) => Field.fromJson(x))),
        data: List<ListData>.from(json["Data"].map((x) => ListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ListData {
    ListData({
        required this.data,
        required this.tipodoc,
        required this.serie,
        required this.numDoc,
        required this.valor,
    });

    DateTime data;
    String tipodoc;
    String serie;
    int numDoc;
    double valor;

    factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        data: DateTime.parse(json["data"]),
        tipodoc: json["tipodoc"],
        serie: json["Serie"],
        numDoc: json["NumDoc"],
        valor: json["Valor"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toIso8601String(),
        "tipodoc": tipodoc,
        "Serie": serie,
        "NumDoc": numDoc,
        "Valor": valor,
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
