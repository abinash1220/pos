// // To parse this JSON data, do
// //
// //     final listUserModel = listUserModelFromJson(jsonString);

// import 'dart:convert';

// ListUserModel listUserModelFromJson(String str) => ListUserModel.fromJson(json.decode(str));

// String listUserModelToJson(ListUserModel data) => json.encode(data.toJson());

// class ListUserModel {
//     ListUserModel({
//         required this.fields,
//         required this.data,
//     });

//     List<Field> fields;
//     List<ListUserData> data;

//     factory ListUserModel.fromJson(Map<String, dynamic> json) => ListUserModel(
//         fields: List<Field>.from(json["Fields"].map((x) => Field.fromJson(x))),
//         data: List<ListUserData>.from(json["Data"].map((x) => ListUserData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "Fields": List<dynamic>.from(fields.map((x) => x.toJson())),
//         "Data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class ListUserData {
//     ListUserData({
//         required this.serie,
//         required this.warehouse,
//     });

//     String serie;
//     String warehouse;

//     factory ListUserData.fromJson(Map<String, dynamic> json) => ListUserData(
//         serie: json["Serie"],
//         warehouse: json["Warehouse"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Serie": serie,
//         "Warehouse": warehouse,
//     };
// }

// class Field {
//     Field({
//         required this.name,
//         required this.alias,
//         required this.isDrillDown,
//     });

//     String name;
//     String alias;
//     bool isDrillDown;

//     factory Field.fromJson(Map<String, dynamic> json) => Field(
//         name: json["Name"],
//         alias: json["Alias"],
//         isDrillDown: json["IsDrillDown"],
//     );

//     Map<String, dynamic> toJson() => {
//         "Name": name,
//         "Alias": alias,
//         "IsDrillDown": isDrillDown,
//     };
// }
