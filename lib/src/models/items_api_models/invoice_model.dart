class InvoiceModel {
   
   InvoiceModel({
       required this.items,
       required this.qty,
       required this.unitPrice,
       required this.cva,
       required this.totalValue,
       required this.discount
   });

   String items;
   int qty;
   String unitPrice;
   String cva;
   String totalValue;
   String discount;

}