class InvoiceModel {
   
   InvoiceModel({
       required this.items,
       required this.description,
       required this.qty,
       required this.unitPrice,
       required this.cva,
       required this.totalValue,
       required this.discount
   });

   String items;
   String description;
   int qty;
   String unitPrice;
   String cva;
   String totalValue;
   String discount;

}