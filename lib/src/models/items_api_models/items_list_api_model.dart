// // To parse this JSON data, do
// //
// //     final itemList = itemListFromJson(jsonString);

// import 'dart:convert';

// ItemList itemListFromJson(String str) => ItemList.fromJson(json.decode(str));

// String itemListToJson(ItemList data) => json.encode(data.toJson());

// class ItemList {
//     ItemList({
//         required this.dataSet,
//         required this.query,
//     });

//     DataSet dataSet;
//     String query;

//     factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
//         dataSet: DataSet.fromJson(json["DataSet"]),
//         query: json["Query"],
//     );

//     Map<String, dynamic> toJson() => {
//         "DataSet": dataSet.toJson(),
//         "Query": query,
//     };
// }

// class DataSet {
//     DataSet({
//         required this.table,
//     });

//     List<ItemsData> table;

//     factory DataSet.fromJson(Map<String, dynamic> json) => DataSet(
//         table: List<ItemsData>.from(json["Table"].map((x) => ItemsData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "Table": List<dynamic>.from(table.map((x) => x.toJson())),
//     };
// }

// class ItemsData {
//     ItemsData({
//         required this.artigo,
//         required this.descricao,
//     });

//     String artigo;
//     String descricao;

//     factory ItemsData.fromJson(Map<String, dynamic> json) => ItemsData(
//         artigo: json["Artigo"],
//         descricao: json["Descricao"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Artigo": artigo,
//         "Descricao": descricao,
//     };
// }
