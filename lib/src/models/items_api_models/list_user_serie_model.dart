// To parse this JSON data, do
//
//     final listuserModel = listuserModelFromJson(jsonString);

import 'dart:convert';

ListUserModel listuserModelFromJson(String str) => ListUserModel.fromJson(json.decode(str));

String listuserModelToJson(ListUserModel data) => json.encode(data.toJson());

class ListUserModel {
    ListUserModel({
        required this.fields,
        required this.data,
    });

    List<Field> fields;
    List<ListUserData> data;

    factory ListUserModel.fromJson(Map<String, dynamic> json) => ListUserModel(
        fields: List<Field>.from(json["Fields"].map((x) => Field.fromJson(x))),
        data: List<ListUserData>.from(json["Data"].map((x) => ListUserData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ListUserData {
    ListUserData({
        required this.serie,
        required this.warehouse,
        required this.customer,
    });

    String serie;
    String warehouse;
    String customer;

    factory ListUserData.fromJson(Map<String, dynamic> json) => ListUserData(
        serie: json["Serie"],
        warehouse: json["Warehouse"],
        customer: json["Customer"],
    );

    Map<String, dynamic> toJson() => {
        "Serie": serie,
        "Warehouse": warehouse,
        "Customer": customer,
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
