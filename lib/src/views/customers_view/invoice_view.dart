import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pos/src/const/app_colors.dart';
import 'package:pos/src/const/app_fonts.dart';
import 'package:pos/src/controllers/customer_api_controller/customer_api_controller.dart';
import 'package:pos/src/controllers/customer_api_controller/items_api_controllers/items_api_controller.dart';
import 'package:pos/src/controllers/invoice_controllers/invoice_controller.dart';
import 'package:pos/src/controllers/login_api_controllers/login_api_controller.dart';
import 'package:pos/src/models/items_api_models/invoice_model.dart';
import 'package:pos/src/models/items_api_models/items_list_api_model.dart';
import 'package:pos/src/prining/printing_screen.dart';
import 'package:pos/src/views/test_printer.dart';
import 'package:pos/src/widgets/customer_widgets/invoice_dropdown_widget.dart';
import 'package:pos/src/widgets/customer_widgets/invoice_row_widget.dart';
import 'package:pos/src/widgets/customer_widgets/invoice_total_row.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pos/src/widgets/snackbar_widgets/out_of_stock.dart';
import 'package:pos/src/widgets/snackbar_widgets/select_product.dart';
import 'package:pos/src/widgets/snackbar_widgets/tipo.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/items_api_models/item_pricelist_model.dart';
import '../../widgets/snackbar_widgets/incorrect.dart';

enum TtsState { playing, stopped, paused, continued }

class InvoiceView extends StatefulWidget {
  String client;
  InvoiceView({super.key, required this.client});

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController tempTextEditingController = TextEditingController();

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;
  List<String> list = <String>['English', 'Tamil', 'Malayalam', 'Hindi'];
  late String dropdownValue;
  int _counter = 0;

  String speakLang = "You have recieved";
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    _getDefaultEngine();
    _getDefaultVoice();

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  void changedLanguageDropDownItem(String? selectedType) async {
    language = selectedType;
    await flutterTts.setLanguage(selectedType!);
    await flutterTts.isLanguageInstalled(selectedType);

    // flutterTts
    //     .isLanguageInstalled(language!)
    //     .then((value) => isCurrentLanguageInstalled = (value as bool));

    setState(() {});
  }

  Future _speak(text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    await flutterTts.speak(text);
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  final itemsApiController = Get.find<CreateItemsApiController>();

  final invoicecontroller = Get.find<InvoiceController>();

  final loginApiController = Get.find<LoginApiController>();

  final customerApiController = Get.find<CustomerApiController>();

  //final createitemApiController = Get.find<CreateItemsApiController>();

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  String value = "select";

  bool isload = false;

  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatspp://send?phone=$number&text=$message";

    await canLaunchUrl(Uri.parse(url))
        ? launchUrl(Uri.parse(url))
        : print('cannot open whatsapp');
  }

  final List<String> items = [
    'FA',
    'FR',
  ];
  String? selectedValue;

  String item = "";
  String qty = "";
  String unitPrice = "";
  String cva = "";
  String totalValue = "";
  String invalnum = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemsApiController.listOfitems(
        client: widget.client,
        wareHouse: loginApiController.listUserData.first.warehouse == "CAR1"
            ? "SAADMIN"
            : loginApiController.listUserData.first.warehouse);
    dropdownValue = list.first;
    setState(() {
      speakLang = "you have received";
    });
    initTts();
    changedLanguageDropDownItem('en-us');
    invoicecontroller.invoiceProtectList.clear();
    invoiceval();
    customerApiController.customer(context: context);
    Get.find<InvoiceController>().getOfflineSavedInvoices();
  }

  invoiceval()async{
    final prefs = await SharedPreferences.getInstance();
       String? inval = prefs.getString("inval");
       setState(() {
         invalnum = inval!;
       });
  }

  DateTime dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios_sharp)),
                actions: [
                  // InkWell(
                  //     onTap: () {
                  //       invoicecontroller.saveController(
                  //           tipodoc: selectedValue.toString(),
                  //           context: context,
                  //           serie: loginApiController.listUserData.first.serie,
                  //           entidade: customerApiController
                  //               .customerdatalist.first.cliente,
                  //           tipoEntidade: "C",
                  //           dataDoc: "${dt.year}-${dt.month}-${dt.day}",
                  //           dataVenc: "${dt.year}-${dt.month}-${dt.day}",
                  //           condPag: "1",
                  //           nome: customerApiController
                  //               .customerdatalist.first.nome,
                  //           nomeFac: customerApiController
                  //               .customerdatalist.first.nome,
                  //           numContribuinte: customerApiController
                  //               .customerdatalist.first.numContrib,
                  //           numContribuinteFac: customerApiController
                  //               .customerdatalist.first.numContrib,
                  //           modoPag: "MB",
                  //           moradafac: "9789087552");
                  //       //customerApiController.customerdatalist.first.cliente
                  //     },
                  //     child: const Icon(Icons.save)),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                      onTap: () async {
                        if (invoicecontroller.invoiceProtectList.isNotEmpty) {
  if (selectedValue!= null) {
    bool result =
        await InternetConnectionChecker().hasConnection;
    if (result) {
     setState(() {
        isload = true;
      });
  await  invoicecontroller.saveController(
          tipodoc: selectedValue.toString(),
          context: context,
          serie:
              loginApiController.listUserData.first.serie,
          entidade: customerApiController
              .customerdatalist.first.cliente,
          tipoEntidade: "C",
          dataDoc: "${dt.year}-${dt.month}-${dt.day}",
          dataVenc: "${dt.year}-${dt.month}-${dt.day}",
          condPag: "1",
          nome: customerApiController
              .customerdatalist.first.nome,
          nomeFac: customerApiController
              .customerdatalist.first.nome,
          numContribuinte: customerApiController
              .customerdatalist.first.numContrib,
          numContribuinteFac: customerApiController
              .customerdatalist.first.numContrib,
          modoPag: "MB",
          moradafac: "9789087552");
      setState(() {
        isload = false;
      });
      Get.to(const TestPrinting());
    } else {
      Get.to(const TestPrinting());
    }
  }else{
    ScaffoldMessenger.of(context).showSnackBar(selectTipo);
  }
}else{
  ScaffoldMessenger.of(context).showSnackBar(selectProduct);
}
                        //invoicecontroller.printposInvoice();
                        // invoicecontroller.saveController(
                        //   tipodoc: "", context: context, serie: "", entidade: "", tipoEntidade: "", dataDoc: "", dataVenc: "", horaDefinida: "", calculoManual: "");
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 7),
                        child: Icon(Icons.print),
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                        onTap: () {
                          invoicecontroller.downloadposInvoice();
                        },
                        child: const Icon(
                          Icons.download,
                          color: Colors.white,
                        )),
                  )
                ],
                title: Text(
                  "Invoice".tr,
                  style: primaryFont.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
              ),
            ],
          ),
        ),
      ),
      body: isload
          ? const Center(child: CircularProgressIndicator())
          : GetBuilder<InvoiceController>(builder: (_) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 45,
                        width: size.width * 0.4,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )),
                              alignment: Alignment.center,
                              child: Text(
                                "TIPO:",
                                style: primaryFont.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  alignment: Alignment.center,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      hint: Text(
                                        'FA',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: items
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      buttonWidth: 60,
                                      itemHeight: 40,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 45,
                        width: size.width * 0.4,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )),
                              alignment: Alignment.center,
                              child: Text(
                                "Number:".tr.toUpperCase(),
                                style: primaryFont.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  alignment: Alignment.center,
                                  child: Text(
                                    invalnum.toUpperCase(),
                                    style: primaryFont.copyWith(
                                      color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 45,
                        width: size.width * 0.4,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )),
                              alignment: Alignment.center,
                              child: Text(
                                "Serie:".toUpperCase(),
                                style: primaryFont.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  alignment: Alignment.center,
                                  child: Text(
                                    loginApiController.listUserData.first.serie,
                                    style: primaryFont.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 45,
                        width: size.width * 0.4,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.7),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )),
                              alignment: Alignment.center,
                              child: Text(
                                "DATE:".tr.toUpperCase(),
                                style: primaryFont.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 11),
                              ),
                            )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${dt.day}-${dt.month}-${dt.year}"
                                        .toUpperCase(),
                                    style: primaryFont.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    color: Colors.grey.withOpacity(0.2),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          child: Text(
                            "Item",
                            style: primaryFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Qty",
                            style: primaryFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "Unit Price".tr,
                            style: primaryFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Dis".tr,
                            style: primaryFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "CVA",
                            style: primaryFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Total Value".tr,
                              style: primaryFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.white,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _dialogBuilder(context, 0);
                          },
                          child: Container(
                            width: 70,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  invoicecontroller.invoiceProtectList.isEmpty
                                      ? value
                                      : invoicecontroller
                                          .invoiceProtectList[0].items,
                                  style: primaryFont.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                    onTap: () {
                                      _dialogBuilder(context, 0);
                                    },
                                    child: const Icon(
                                        Icons.keyboard_arrow_down_rounded))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          //
                          child: TextField(
                            controller: textEditingController,
                            onChanged: (value) {
                              int tempqty = int.parse(value);

                              var tempCalValue = double.parse(invoicecontroller
                                      .invoiceProtectList[0].stock) -
                                  tempqty;
                              print(tempCalValue);
                              if (tempCalValue < 0) {
                                textEditingController.clear();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(outOfStockSnackBar);
                                invoicecontroller.invoiceProtectList[0]
                                    .totalValue = double.parse(invoicecontroller
                                        .invoiceProtectList[0].unitPrice)
                                    .toString();
                                invoicecontroller.invoiceProtectList[0].qty = 1;
                                invoicecontroller.totalAmountCal();
                                invoicecontroller.update();
                              } else {
                                double a = double.parse(invoicecontroller
                                        .invoiceProtectList[0].unitPrice) *
                                    int.parse(value);
                                double b = double.parse(invoicecontroller
                                        .invoiceProtectList[0].discount) /
                                    double.parse(100.toString()) *
                                    double.parse(a.toString());
                                double c = double.parse(invoicecontroller
                                        .invoiceProtectList[0].cva) /
                                    double.parse(100.toString()) *
                                    double.parse(a.toString());
                                double d = a - b + c;
                                invoicecontroller.invoiceProtectList[0]
                                    .totalValue = d.toString();
                                invoicecontroller.invoiceProtectList[0].qty =
                                    int.parse(value);
                                invoicecontroller.totalAmountCal();
                                invoicecontroller.update();
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: primaryFont.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w600),
                            decoration:
                                const InputDecoration.collapsed(hintText: "1"),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            invoicecontroller.invoiceProtectList.isEmpty
                                ? ""
                                : invoicecontroller
                                    .invoiceProtectList[0].unitPrice,
                            style: primaryFont.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            invoicecontroller.invoiceProtectList.isEmpty
                                ? ""
                                : invoicecontroller
                                    .invoiceProtectList[0].discount,
                            style: primaryFont.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            invoicecontroller.invoiceProtectList.isEmpty
                                ? ""
                                : invoicecontroller.invoiceProtectList[0].cva,
                            style: primaryFont.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            invoicecontroller.invoiceProtectList.isEmpty
                                ? ""
                                : invoicecontroller
                                    .invoiceProtectList[0].totalValue,
                            style: primaryFont.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //

                  for (int i = 1;
                      i < invoicecontroller.invoiceProtectList.length + 1;
                      i++)
                    Container(
                      height: 50,
                      color: i.isOdd ? Colors.grey[200] : Colors.white,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _dialogBuilder(context, i);
                            },
                            child: Container(
                              width: 70,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    invoicecontroller
                                                .invoiceProtectList.length ==
                                            i
                                        ? 'Select'.tr
                                        : invoicecontroller
                                            .invoiceProtectList[i].items,
                                    style: primaryFont.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _dialogBuilder(context, i);
                                      },
                                      child: const Icon(
                                          Icons.keyboard_arrow_down_rounded))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: invoicecontroller.invoiceProtectList
                                      .asMap()
                                      .containsKey(i)
                                  ? invoicecontroller
                                      .invoiceProtectList[i].textController
                                  : tempTextEditingController,
                              onChanged: (value) {
                                int tempqty = int.parse(value);

                                var tempCalValue = double.parse(
                                        invoicecontroller
                                            .invoiceProtectList[i].stock) -
                                    tempqty;

                                if (tempCalValue < 0) {
                                  invoicecontroller
                                      .invoiceProtectList[i].textController
                                      .clear();
                                  invoicecontroller.update();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(outOfStockSnackBar);

                                  invoicecontroller
                                          .invoiceProtectList[i].totalValue =
                                      double.parse(invoicecontroller
                                              .invoiceProtectList[i].unitPrice)
                                          .toString();
                                  invoicecontroller.invoiceProtectList[i].qty =
                                      1;
                                  invoicecontroller.totalAmountCal();
                                  invoicecontroller.update();
                                } else {
                                  double a = double.parse(invoicecontroller
                                          .invoiceProtectList[i].unitPrice) *
                                      int.parse(value);
                                  double b = double.parse(invoicecontroller
                                          .invoiceProtectList[i].discount) /
                                      double.parse(100.toString()) *
                                      double.parse(a.toString());
                                  double c = double.parse(invoicecontroller
                                          .invoiceProtectList[i].cva) /
                                      double.parse(100.toString()) *
                                      double.parse(a.toString());
                                  double d = a - b + c;
                                  invoicecontroller.invoiceProtectList[i]
                                      .totalValue = d.toString();
                                  invoicecontroller.invoiceProtectList[i].qty =
                                      int.parse(value);
                                  invoicecontroller.totalAmountCal();
                                  invoicecontroller.update();
                                }
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: primaryFont.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                              decoration: const InputDecoration.collapsed(
                                  hintText: "1"),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          Container(
                            width: 80,
                            alignment: Alignment.center,
                            child: Text(
                              invoicecontroller.invoiceProtectList.length == i
                                  ? ""
                                  : invoicecontroller
                                      .invoiceProtectList[i].unitPrice,
                              style: primaryFont.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              invoicecontroller.invoiceProtectList.length == i
                                  ? ""
                                  : invoicecontroller
                                      .invoiceProtectList[i].discount,
                              style: primaryFont.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              invoicecontroller.invoiceProtectList.length == i
                                  ? ""
                                  : invoicecontroller.invoiceProtectList[i].cva,
                              style: primaryFont.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 1,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          Container(
                            width: 80,
                            alignment: Alignment.center,
                            child: Text(
                              invoicecontroller.invoiceProtectList.length == i
                                  ? ""
                                  : invoicecontroller
                                      .invoiceProtectList[i].totalValue,
                              style: primaryFont.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  InvoiceTotalRow(
                    color: Colors.grey.withOpacity(0.2),
                    total: invoicecontroller.totolamount.toString(),
                  ),
                ],
              );
            }),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: primaryColor.withAlpha(25),
          ringDiameter: 300.0,
          ringWidth: 100.0,
          fabSize: 54.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          // Also can use specific color based on wether
          // the menu is open or not:
          // fabOpenColor: Colors.white
          // fabCloseColor: Colors.white
          // These properties take precedence over fabColor
          fabColor: Colors.white,
          fabOpenIcon: Icon(Icons.menu, color: primaryColor),
          fabCloseIcon: Icon(Icons.close, color: primaryColor),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {
            // _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
          },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                Share.share('hello');
                // _showSnackBar(context, "You pressed 1");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Icon(Icons.share, color: primaryColor),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  String ruppee = textEditingController.text;
                  _speak("$ruppee rupee $speakLang");
                } else {
                  _speak("Enter an Amount to Continue");
                }
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Icon(Icons.speaker_phone, color: primaryColor),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed: () {
                launchWhatsapp(number: "+6382077886", message: "pos testing");
                // _showSnackBar(context, "You pressed 3");
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Icon(Icons.chat, color: primaryColor),
                ),
              ),
            ),
            // RawMaterialButton(
            //   onPressed: () {
            //    // _showSnackBar(context, "You pressed 4. This one closes the menu on tap");
            //     fabKey.currentState!.close();
            //   },
            //   shape: CircleBorder(),
            //   padding: const EdgeInsets.all(24.0),
            //   child: Icon(Icons.looks_4, color: primaryColor),
            // )
          ],
        ),
      ),
    );
  }

  _dialogBuilder(BuildContext context, int itemIndex) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Items:".tr),
            content: Container(
                height: 300,
                width: 100,
                child: GetBuilder<CreateItemsApiController>(builder: (_) {
                  return itemsApiController.pricelist!.isEmpty
                      ? Center(child: Text("No Data".tr))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: itemsApiController.pricelist!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () async {
                                  //List<ItemPrice?>? pricelist = await itemsApiController.listOfitems(client: widget.client , wareHouse: loginApiController.listUserData[index].warehouse);

                                  if (itemsApiController
                                          .pricelist![index]!.stock <=
                                      0) {
                                    Get.back();
                                    dialogBuilder(context);
                                  } else {
                                    double a = double.parse(itemsApiController
                                            .pricelist![index]!.price
                                            .toString()) *
                                        1;
                                    double b = double.parse(itemsApiController
                                            .pricelist![index]!.discount
                                            .toString()) /
                                        double.parse(100.toString()) *
                                        double.parse(a.toString());
                                    double c = double.parse(itemsApiController
                                            .pricelist![index]!.iva
                                            .toString()) /
                                        double.parse(100.toString()) *
                                        double.parse(a.toString());
                                    double d = a - b + c;
                                    InvoiceModel invoiceModel = InvoiceModel(
                                      textController: TextEditingController(),
                                      items: itemsApiController
                                          .pricelist![index]!.artigo,
                                      description: itemsApiController
                                          .pricelist![index]!.descricao
                                          .toString(),
                                      cva: itemsApiController
                                          .pricelist![index]!.iva
                                          .toString(),
                                      qty: 1,
                                      stock: itemsApiController
                                          .pricelist![index]!.stock
                                          .toString(),
                                      totalValue: d.toString(),
                                      unitPrice: itemsApiController
                                          .pricelist![index]!.price
                                          .toString(),
                                      discount: itemsApiController
                                          .pricelist![index]!.discount
                                          .toString(),
                                      armazen: loginApiController
                                          .listUserData.first.warehouse,
                                      localizacao: loginApiController
                                          .listUserData.first.warehouse,
                                    );

                                    if (invoicecontroller.invoiceProtectList
                                        .asMap()
                                        .containsKey(itemIndex)) {
                                      invoicecontroller
                                              .invoiceProtectList[itemIndex] =
                                          invoiceModel;
                                    } else {
                                      invoicecontroller.invoiceProtectList
                                          .insert(itemIndex, invoiceModel);
                                    }

                                    invoicecontroller.totalAmountCal();

                                    invoicecontroller.update();
                                    Get.back();
                                  }
                                },
                                child: Container(
                                  height: 30,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            itemsApiController
                                                .pricelist![index]!.artigo
                                                .toString(),
                                            textDirection: TextDirection.ltr,
                                            style: primaryFont.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 130,
                                            child: Text(
                                              itemsApiController
                                                  .pricelist![index]!.descricao
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              textDirection: TextDirection.ltr,
                                              style: primaryFont.copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            itemsApiController
                                                        .pricelist![index]!
                                                        .stock <=
                                                    0
                                                ? "0"
                                                : itemsApiController
                                                    .pricelist![index]!.stock
                                                    .toStringAsFixed(0),
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.ltr,
                                            style: primaryFont.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                })),
          );
        });
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ));
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Insuffcient stock".tr),
        );
      },
    );
  }
}
