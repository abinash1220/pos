// To parse this JSON data, do
//
//     final listCustomer = listCustomerFromJson(jsonString);

import 'dart:convert';

ListCustomer listCustomerFromJson(String str) => ListCustomer.fromJson(json.decode(str));

String listCustomerToJson(ListCustomer data) => json.encode(data.toJson());

class ListCustomer {
    ListCustomer({
        required this.dataSet,
        required this.query,
    });

    DataSet dataSet;
    String query;

    factory ListCustomer.fromJson(Map<String, dynamic> json) => ListCustomer(
        dataSet: DataSet.fromJson(json["DataSet"]),
        query: json["Query"],
    );

    Map<String, dynamic> toJson() => {
        "DataSet": dataSet.toJson(),
        "Query": query,
    };
}

class DataSet {
    DataSet({
        required this.table,
    });

    List<CustomerData> table;

    factory DataSet.fromJson(Map<String, dynamic> json) => DataSet(
        table: List<CustomerData>.from(json["Table"].map((x) => CustomerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table.map((x) => x.toJson())),
    };
}

class CustomerData {
    CustomerData({
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
    String numContrib;

    factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        cliente: json["Cliente"],
        nome: json["Nome"],
        facMor: json["Fac_Mor"]?? "",
        pais: json["Pais"]?? "",
        numContrib: json["NumContrib"]?? "",
    );

    Map<String, dynamic> toJson() => {
        "Cliente": cliente,
        "Nome": nome,
        "Fac_Mor": facMor,
        "Pais": pais,
        "NumContrib": numContrib,
    };
}


