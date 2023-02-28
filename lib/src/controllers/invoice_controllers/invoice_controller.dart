import 'dart:convert';
import 'dart:io';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/src/const/api_cachekey.dart';
import 'package:pos/src/models/items_api_models/invoice_data_model.dart';
import 'package:pos/src/models/items_api_models/invoice_model.dart';
import 'package:pos/src/services/invoice_api_services/invoice_offline_sync_api_services.dart';
import 'package:pos/src/services/invoice_api_services/invoice_save_api_service.dart';
import 'package:pos/src/widgets/snackbar_widgets/incorrect.dart';
import 'package:pos/src/widgets/snackbar_widgets/invoice_local_save.dart';
import 'package:pos/src/widgets/snackbar_widgets/invoice_save.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceController extends GetxController {
  InvoiceSaveApiService invoiceSaveApiService = InvoiceSaveApiService();
  InvoiceOfflineSaveApiService invoiceOfflineSaveApiService =
      InvoiceOfflineSaveApiService();

  List<InvoiceModel> invoiceProtectList = [];

  RxBool select = false.obs;

  RxString totolamount = "0".obs;
  RxString subtotal = "0".obs;
  RxString iva = "0".obs;
  RxString discount = "0".obs;

  RxString invoicevalue = "".obs;
  RxString invoiceSerie = "".obs;
  RxString invoiceClientId = "".obs;
  RxString invoiceNum = "".obs;

  RxBool isUnauthClient = false.obs;

  RxString invoicenome = "".obs;
  RxString invoicetaxid = "".obs;
  RxString invoicetelephone = "".obs;
  


  totalAmountCal() {
    double tempTolAmt = 0.0;

    for (var value in invoiceProtectList) {
      tempTolAmt = tempTolAmt + double.parse(value.totalValue);
    }

    totolamount(tempTolAmt.toStringAsFixed(2));
    subTotalCal();
    ivaCal();

    update();
  }

  subTotalCal() {
    double subtot = 0.0;
    double subtot2 = 0.0;

    for (var value in invoiceProtectList) {
      subtot =
          double.parse(value.unitPrice) * double.parse(value.qty.toString());
      subtot2 = subtot2 + double.parse(subtot.toString());
    }

    subtotal(subtot2.toStringAsFixed(2));

    update();
  }

  ivaCal() {
    double gst = 0.0;
    double subtot1 = 0.0;
    double gst1 = 0.0;

    for (var value in invoiceProtectList) {
      subtot1 =
          double.parse(value.unitPrice) * double.parse(value.qty.toString());
      gst1 = double.parse(value.cva) /
          double.parse(100.toString()) *
          double.parse(subtot1.toString());
      gst = gst + double.parse(gst1.toString());
    }

    iva(gst.toStringAsFixed(2));

    update();
  }

  Future<void> downloadposInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Container(
                        height: 45,
                        width: 200,
                        child: pw.Row(
                          children: [
                            pw.Expanded(
                                child: pw.Container(
                              height: 45,
                              decoration: pw.BoxDecoration(
                                  color: PdfColors.grey,
                                  borderRadius: pw.BorderRadius.only(
                                    bottomLeft: pw.Radius.circular(10),
                                    topLeft: pw.Radius.circular(10),
                                  )),
                              alignment: pw.Alignment.center,
                              child: pw.Text("TIPO:",
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            )),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  height: 45,
                                  decoration: pw.BoxDecoration(
                                      color: PdfColors.grey200,
                                      borderRadius: const pw.BorderRadius.only(
                                        topRight: pw.Radius.circular(10),
                                        bottomRight: pw.Radius.circular(10),
                                      )),
                                  alignment: pw.Alignment.center,
                                  child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    children: [
                                      pw.Text("FA ",
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold)),
                                      // pw.Icon(Icons.keyboard_arrow_down_rounded)
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      pw.Container(
                        height: 45,
                        width: 200,
                        child: pw.Row(
                          children: [
                            pw.Expanded(
                                child: pw.Container(
                              height: 45,
                              decoration: pw.BoxDecoration(
                                  color: PdfColors.grey,
                                  borderRadius: const pw.BorderRadius.only(
                                    bottomLeft: pw.Radius.circular(10),
                                    topLeft: pw.Radius.circular(10),
                                  )),
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                "Number:".toUpperCase(),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 11),
                              ),
                            )),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  height: 45,
                                  decoration: pw.BoxDecoration(
                                      color: PdfColors.grey200,
                                      borderRadius: const pw.BorderRadius.only(
                                        topRight: pw.Radius.circular(10),
                                        bottomRight: pw.Radius.circular(10),
                                      )),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    "0096".toUpperCase(),
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Container(
                        height: 45,
                        width: 200,
                        child: pw.Row(
                          children: [
                            pw.Expanded(
                                child: pw.Container(
                              height: 45,
                              decoration: pw.BoxDecoration(
                                  color: PdfColors.grey,
                                  borderRadius: const pw.BorderRadius.only(
                                    bottomLeft: pw.Radius.circular(10),
                                    topLeft: pw.Radius.circular(10),
                                  )),
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                "Serie:".toUpperCase(),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            )),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  height: 45,
                                  decoration: pw.BoxDecoration(
                                      color: PdfColors.grey200,
                                      borderRadius: const pw.BorderRadius.only(
                                        topRight: pw.Radius.circular(10),
                                        bottomRight: pw.Radius.circular(10),
                                      )),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    "2023",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      pw.Container(
                        height: 45,
                        width: 200,
                        child: pw.Row(
                          children: [
                            pw.Expanded(
                                child: pw.Container(
                              height: 45,
                              decoration: pw.BoxDecoration(
                                  color: PdfColors.grey,
                                  borderRadius: const pw.BorderRadius.only(
                                    bottomLeft: pw.Radius.circular(10),
                                    topLeft: pw.Radius.circular(10),
                                  )),
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                "DATE:".toUpperCase(),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            )),
                            pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  height: 45,
                                  decoration: pw.BoxDecoration(
                                      color: PdfColors.grey200,
                                      borderRadius: const pw.BorderRadius.only(
                                        topRight: pw.Radius.circular(10),
                                        bottomRight: pw.Radius.circular(10),
                                      )),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    "11-01-2023".toUpperCase(),
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Container(
                    height: 50,
                    color: PdfColors.grey200,
                    child: pw.Row(
                      children: [
                        pw.Container(
                          width: 80,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "Item",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.Container(
                          height: 200,
                          width: 1,
                          color: PdfColors.grey200,
                        ),
                        pw.Container(
                          width: 60,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "Qty",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        pw.Container(
                          height: 200,
                          width: 1,
                          color: PdfColors.grey200,
                        ),
                        pw.Container(
                          width: 90,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "Unit Price",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        pw.Container(
                          height: 200,
                          width: 1,
                          color: PdfColors.grey200,
                        ),
                        pw.Container(
                          width: 60,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "CVA",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        pw.Container(
                          height: 200,
                          width: 1,
                          color: PdfColors.grey200,
                        ),
                        pw.Container(
                          width: 90,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "Total Value",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  for (var value in invoiceProtectList)
                    pw.Container(
                      height: 50,
                      color: invoiceProtectList.indexOf(value).isEven
                          ? PdfColors.white
                          : PdfColors.grey200,
                      child: pw.Row(
                        children: [
                          //pw.InkWell(
                          // onTap: (){
                          //   pw._dialogBuilder(context);
                          // },
                          pw.Container(
                            width: 80,
                            alignment: pw.Alignment.center,
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  value.items,
                                  //value,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 13),
                                ),
                                // InkWell(
                                //   onTap: (){
                                //     _dialogBuilder(context);
                                //   },
                                //   child: Icon(Icons.keyboard_arrow_down_rounded))
                              ],
                            ),
                          ),
                          //),
                          pw.Container(
                            height: 200,
                            width: 1,
                            color: PdfColors.grey,
                          ),
                          pw.Container(
                            width: 60,
                            alignment: pw.Alignment.center,
                            child: pw.Text(value.qty.toString()),
                            // child: pw.TextField(
                            //   textAlign: TextAlign.center,
                            //   keyboardType: TextInputType.number,
                            //   style: primaryFont.copyWith(
                            //       fontSize: 13, fontWeight: FontWeight.w600),
                            //   decoration: InputDecoration.collapsed(hintText: "5"),
                            // ),
                          ),
                          pw.Container(
                            height: 200,
                            width: 1,
                            color: PdfColors.grey,
                          ),
                          pw.Container(
                              width: 90,
                              alignment: pw.Alignment.center,
                              child: pw.Text(value.unitPrice)
                              // child: pw.TextField(
                              //   textAlign: TextAlign.center,
                              //   keyboardType: TextInputType.number,
                              //   style: primaryFont.copyWith(
                              //       fontSize: 13, fontWeight: FontWeight.w600),
                              //   decoration: InputDecoration.collapsed(hintText: "300"),
                              // ),
                              ),
                          pw.Container(
                            height: 200,
                            width: 1,
                            color: PdfColors.grey,
                          ),
                          pw.Container(
                              width: 60,
                              alignment: pw.Alignment.center,
                              child: pw.Text(value.cva)
                              // child: pw.TextField(
                              //   textAlign: TextAlign.center,
                              //   keyboardType: TextInputType.number,
                              //   style: primaryFont.copyWith(
                              //       fontSize: 13, fontWeight: FontWeight.w600),
                              //   decoration: InputDecoration.collapsed(hintText: "7"),
                              // ),
                              ),
                          pw.Container(
                            height: 200,
                            width: 1,
                            color: PdfColors.grey,
                          ),
                          pw.Container(
                            width: 90,
                            alignment: pw.Alignment.center,
                            child: pw.Text(value.totalValue),
                            // child: pw.TextField(
                            //   textAlign: TextAlign.center,
                            //   keyboardType: TextInputType.number,
                            //   style: primaryFont.copyWith(
                            //       fontSize: 13, fontWeight: FontWeight.w600),
                            //   decoration: InputDecoration.collapsed(hintText: "1710"),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  //second

                  //  pw.InvoiceDropdown(
                  //   color: Colors.white,
                  // ),
                  // InvoiceRow(
                  //   color: Colors.grey.withOpacity(0.2),
                  // ),
                  // InvoiceRow(
                  //   color: Colors.white,
                  // ),
                  // InvoiceRow(
                  //   color: Colors.grey.withOpacity(0.2),
                  // ),
                  // InvoiceRow(
                  //   color: Colors.white,
                  // ),
                  // InvoiceTotalRow(
                  //   color: Colors.grey.withOpacity(0.2),
                  // ),
                ],
              ),
              //2
              pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    width: 500,
                    color: PdfColors.grey200,
                    child: pw.Center(
                        child: pw.Padding(
                            padding: pw.EdgeInsets.only(right: 20, left: 20),
                            child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text("Total"),
                                  pw.Text(totolamount.toString())
                                ]))),
                  ),
                ],
              ),
            ],
          ),
          //
        ),
      ),
    );

    var bytes = await pdf.save();
    downloadFile(bytes, "0111");
  }

  Future<void> printposInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("     BEFCO INDUSTRIA,LDA"),
                pw.Text("     5000444995"),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text("Rua IQUA BAIRRO CALEMBA 2"),
                pw.Text("2525      - KILAMBA KIAXI"),
                pw.Text("Tel: 928474747"),
                pw.Text("Fax:"),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text("CIF:FR10"),
                pw.Text("       MAMA TELE"),
                pw.Text("       938196375"),
                pw.Text("       C"),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text("Factura FT 011 FR.23CL2/52"),
                pw.Text("Factura/Recibo"),
                pw.Text("Date: 2023-01-18"),
                pw.Text("Moeda: AKZ                     Cambio: 643,41"),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text("Rec. para client                4 080,06"),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 220),
                  child: pw.Divider(),
                ),
                pw.Text("Cod. do Artigo - Descricao"),
                pw.Row(
                  children: [
                    pw.Text("Qty."),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("Unit Price"),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("Dis."),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("CVA."),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("Toatl."),
                  ],
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 220),
                  child: pw.Divider(),
                ),
                pw.Text("200013    PLANET CQLA 350 ML"),
                pw.Row(
                  children: [
                    pw.Text("12"),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("3,00"),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("1 193.00"),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("14.0"),
                    pw.SizedBox(
                      width: 20,
                    ),
                    pw.Text("4 080,06"),
                  ],
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 220),
                  child: pw.Divider(),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 230),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Cred.  Devolucoes  :"),
                        pw.Text("0.00", textDirection: pw.TextDirection.rtl),
                      ]),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 230),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Total Iliquido  :"),
                        pw.Text("3 579,00",
                            textDirection: pw.TextDirection.rtl),
                      ]),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 230),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Total Descontos  :"),
                        pw.Text("0.00", textDirection: pw.TextDirection.rtl),
                      ]),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 230),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Total IEC/Contrib.  :"),
                        pw.Text("0.00", textDirection: pw.TextDirection.rtl),
                      ]),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 230),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Total de IVA  :"),
                        pw.Text("501,06", textDirection: pw.TextDirection.rtl),
                      ]),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 230),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Total          :"),
                        pw.Text("4 080,06",
                            textDirection: pw.TextDirection.rtl),
                      ]),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 230),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Total Alternativo  :"),
                        pw.Text("6.34  USD",
                            textDirection: pw.TextDirection.rtl),
                      ]),
                ),
              ]),
        ),
      ),
    );

    var bytes = await pdf.save();
    printPdf(bytes, "0111");
  }

  Future<void> InvoicePrint() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    var bytes = await pdf.save();
    printPdf(bytes, "abcd");
  }

  downloadFile(var bytes, String txId) async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

      Directory generalDownloadDir = Directory(
          '/storage/emulated/0/Download'); //! THIS WORKS for android only !!!!!!

      //qr image file saved to general downloads folder
      File file =
          await File('${generalDownloadDir.path}/$txId-invoice.pdf').create();

      await file.writeAsBytes(bytes);
      Get.closeAllSnackbars();
      Get.snackbar("Invoice Downloaded to ", "${file.path}",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  printPdf(var bytes, String txId) async {
    // Either the permission was already granted before or the user just granted it.

    Directory generalDownloadDir = Directory(
        '/storage/emulated/0/Download'); //! THIS WORKS for android only !!!!!!

    //qr image file saved to general downloads folder
    File file =
        await File('${generalDownloadDir.path}/$txId-invoice.pdf').create();

    await file.writeAsBytes(bytes, flush: true);

    await Printing.layoutPdf(onLayout: (_) => file.readAsBytes());
  }

  saveController(
      {required BuildContext context,
      required String tipodoc,
      required String serie,
      required String entidade,
      required String tipoEntidade,
      required String dataDoc,
      required String dataVenc,
      required String condPag,
      required String nome,
      required String nomeFac,
      required String numContribuinte,
      required String numContribuinteFac,
      required String moradafac,
      required String cduMCXID,
      required String modoPag}) async {
    List<dynamic> templist = [];

    for (var value in invoiceProtectList) {
      templist.add(
        {
          "Artigo": value.items,
          "Quantidade": value.qty.toString(),
          "PrecUnit": value.unitPrice,
          "Desconto1": value.discount,
          "TaxaIva": value.cva,
          "Armazem": value.armazen,
          "Localizacao": value.localizacao
        },
      );
    }

    // var isChacheExist = await APICacheManager().isAPICacheKeyExist(saveinvoiceKey);

    bool result = await InternetConnectionChecker().hasConnection;
    final prefs = await SharedPreferences.getInstance();

   // Get.snackbar(tipodoc, "tipo val");

    if (result) {
      dio.Response<dynamic> response = await invoiceSaveApiService.invoiceSave(
          tipodoc: tipodoc,
          serie: serie,
          entidade: entidade,
          tipoEntidade: tipoEntidade,
          dataDoc: dataDoc,
          dataVenc: dataVenc,
          condPag: condPag,
          modoPag: modoPag,
          products: templist,
          nome: nome,
          nomeFac: nomeFac,
          numContribuinte: numContribuinte,
          numContribuinteFac: numContribuinteFac,
          moradafac: moradafac,
          cduMCXID: cduMCXID
          );

          InvoiceData invoicedata = InvoiceData.fromJson(response.data);
          invoicevalue (invoicedata.results.first.split(":").last); 
          invoiceSerie (invoicedata.results[1]);
          //invoiceClientId (invoicedata.results[2]);


         
      // Get.snackbar(response.statusCode.toString(), "save");
      if (response.statusCode == 200) {
         
        String invoicecountval = invoicedata.results[1].split("/").last;

        int inval = int.parse(invoicecountval) + 1;

        await prefs.setString("inval", inval.toString());

        ScaffoldMessenger.of(context).showSnackBar(invoicesave);


      } else {
         Get.snackbar("wrong sts", response.statusCode.toString());
        // ScaffoldMessenger.of(context).showSnackBar(incorrect);
      }
    } else {
      final prefs = await SharedPreferences.getInstance();

      List<String> tempDataList = [];

      tempDataList = prefs.getStringList(saveinvoiceKey) ?? [];

      String data = json.encode({
        "Tipodoc": tipodoc,
        "CondPag": condPag,
        "ModoPag": modoPag,
        "TipoEntidade": tipoEntidade,
        "DataDoc": dataDoc,
        "DataVenc": dataVenc,
        "Entidade": entidade,
        "Serie": serie,
        "Nome": nome,
        "NomeFac": nomeFac,
        "NumContribuinte": numContribuinte,
        "NumContribuinteFac": numContribuinteFac,
        "MoradaFac": moradafac,
        "Linhas": templist,
      });

      tempDataList.add(data);

      await prefs.setStringList(saveinvoiceKey, tempDataList);
      
      //Get.snackbar("localy", "invoice saved");
      ScaffoldMessenger.of(context).showSnackBar(invoicelocalsave);


      // print("String localy:::::");
      // String data = json.encode({
      //   "Tipodoc": tipodoc,
      //   "CondPag": condPag,
      //   "ModoPag": modoPag,
      //   "TipoEntidade": tipoEntidade,
      //   "DataDoc": dataDoc,
      //   "DataVenc": dataVenc,
      //   "Entidade": entidade,
      //   "Serie": serie,
      //   "Nome": nome,
      //   "NomeFac": nomeFac,
      //   "NumContribuinte": numContribuinte,
      //   "NumContribuinteFac": numContribuinteFac,
      //   "MoradaFac": moradafac,
      //   "Linhas": templist,
      // });

      // print(data);

      // var cacheData = await APICacheManager()
      //     .addCacheData(APICacheDBModel(key: saveinvoiceKey, syncData: data));
    }
  }

  getOfflineSavedInvoices() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      final prefs = await SharedPreferences.getInstance();

      List<String> tempDataList = [];

      tempDataList = prefs.getStringList(saveinvoiceKey)!;
       
      //Get.snackbar(tempDataList.length.toString(), "list length");

      for (int i = 0; i < tempDataList.length; i++) {
        var data = json.decode(tempDataList[i]);
        dio.Response<dynamic> response =
            await invoiceOfflineSaveApiService.invoiceOfflineSave(data);
        print("Data backuped :::::::::::::: ${response.statusCode}");
      }

      tempDataList = [];

      await prefs.setStringList(saveinvoiceKey, tempDataList);
      // var cacheData = await APICacheManager().getCacheData(saveinvoiceKey);
      // print("Invoiced Saved Datas");
      // print(json.decode(cacheData.syncData));

      // var data = json.decode(cacheData.syncData);
      // dio.Response<dynamic> response =
      //     await invoiceOfflineSaveApiService.invoiceOfflineSave(data);
      // print("Data backuped :::::::::::::: ${response.statusCode}");
      // if (response.statusCode == 200) {
      //   await APICacheManager().deleteCache(saveinvoiceKey);
      //   print("::::::::::data erased after backup::::::::::::");
      // }
    }
  }
}
