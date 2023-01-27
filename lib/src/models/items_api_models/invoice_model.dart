import 'package:flutter/material.dart';

class InvoiceModel {
  InvoiceModel({
    required this.items,
    required this.description,
    required this.qty,
    required this.unitPrice,
    required this.cva,
    required this.totalValue,
    required this.discount,
    required this.stock,
    required this.armazen,
    required this.localizacao,
    required this.textController,
  });

  String items;
  String description;
  int qty;
  String unitPrice;
  String cva;
  String stock;
  String totalValue;
  String discount;
  String armazen;
  String localizacao;
  TextEditingController textController;
}
