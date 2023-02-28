// To parse this JSON data, do
//
//     final empty = emptyFromJson(jsonString);

import 'dart:convert';

CustomerList emptyFromJson(String str) => CustomerList.fromJson(json.decode(str));

String emptyToJson(CustomerList data) => json.encode(data.toJson());

class CustomerList {
    CustomerList({
        required this.fields,
        required this.data,
    });

    List<Field> fields;
    List<CustomerListData> data;

    factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
        fields: List<Field>.from(json["Fields"].map((x) => Field.fromJson(x))),
        data: List<CustomerListData>.from(json["Data"].map((x) => CustomerListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CustomerListData {
    CustomerListData({
        required this.cliente,
        required this.nome,
        required this.facMor,
        required this.pais,
        required this.numContrib,
        
    });

    String cliente;
    String nome;
    String facMor;
    String pais;
    dynamic numContrib;
    

    factory CustomerListData.fromJson(Map<String, dynamic> json) => CustomerListData(
        cliente: json["Cliente"],
        nome: json["Nome"],
        facMor: json["Fac_Mor"],
        pais: json["Pais"],
        numContrib: json["NumContrib"]??"",
        
    );

    Map<String, dynamic> toJson() => {
        "Cliente": cliente,
        "Nome": nome,
        "Fac_Mor": facMor,
        "Pais": pais,
        "NumContrib": numContrib
        
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
