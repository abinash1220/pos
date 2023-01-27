// To parse this JSON data, do
//
//     final invoiceData = invoiceDataFromJson(jsonString);

import 'dart:convert';

InvoiceData invoiceDataFromJson(String str) => InvoiceData.fromJson(json.decode(str));

String invoiceDataToJson(InvoiceData data) => json.encode(data.toJson());

class InvoiceData {
    InvoiceData({
        required this.version,
        required this.statusCode,
        this.errorMessage,
        required this.results,
    });

    String version;
    int statusCode;
    dynamic errorMessage;
    List<String> results;

    factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        version: json["Version"],
        statusCode: json["StatusCode"],
        errorMessage: json["ErrorMessage"],
        results: List<String>.from(json["Results"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Version": version,
        "StatusCode": statusCode,
        "ErrorMessage": errorMessage,
        "Results": List<dynamic>.from(results.map((x) => x)),
    };
}
