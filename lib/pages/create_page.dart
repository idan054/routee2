// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routee/common/num_extensions.dart';
import 'package:routee/common/string_ext.dart';
import 'package:routee/common/widget_ext.dart';

import '../common/constants.dart';
import '../common/database.dart';
import '../common/google_location_complete.dart';
import '../common/models/address_result.dart';
import '../common/models/event_item.dart';
import '../main.dart';
import '../update_details_dialog.dart';
import '../widgets.dart';
import 'home_page.dart';

class CreatePage extends StatefulWidget {
  final bool showAppBar;
  final EventItem? eventItem;

  const CreatePage({this.showAppBar = true, this.eventItem, Key? key})
      : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  RangeValues _currentRangeValues =
      const RangeValues(10, 55); // This NOT set Min & Max

  // endregion ageList
  var titleController = TextEditingController();
  var dateTimeController = TextEditingController();
  var priceController = TextEditingController();
  var weightController = TextEditingController();
  var originController = TextEditingController();
  var destController = TextEditingController();
  var truckController = TextEditingController();
  String? errText;
  AddressResult? selectedOrigin;
  AddressResult? selectedDest;
  List<AddressResult> originSuggestions = [];
  List<AddressResult> destSuggestions = [];
  List<String> trucksSuggestions = [];

  @override
  void initState() {
    super.initState();

    if (widget.eventItem != null) {
      titleController.text = widget.eventItem?.title ?? "";
      priceController.text = widget.eventItem?.price ?? "";
      weightController.text = widget.eventItem?.weight ?? "";
      originController.text = widget.eventItem?.originAddress ?? "";
      destController.text = widget.eventItem?.destinationAddress ?? "";
      truckController.text = widget.eventItem?.truckType ?? "";
      selectedOrigin = AddressResult(
          name: widget.eventItem?.originAddress,
          lat: widget.eventItem?.originLat,
          lng: widget.eventItem?.originLong);
      selectedDest = AddressResult(
          name: widget.eventItem?.destinationAddress,
          lat: widget.eventItem?.destinationLat,
          lng: widget.eventItem?.destinationLong);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: widget.showAppBar
          ? Scaffold(
              backgroundColor: bgColor,
              appBar: widget.showAppBar ? buildHomeAppBar(context) : null,
              body: _body(),
            )
          : _body(),
    );
  }

  Widget _body() => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 13),
            if (errText != null)
              errText
                  .toString()
                  .toText(bold: true, fontSize: 16, color: Colors.red)
                  .center,
            const SizedBox(height: 13),
            Row(
              children: [
                // Transform.scale(scaleX: 1, child: Icons.inventory.icon(color: Colors.black38, size: 22),).pOnly(left: 10),
                '1'
                    .toText(color: Colors.black38, fontSize: 24, bold: true)
                    .pOnly(left: 10),
                buildTextFormField('פרטי הובלה', titleController,
                        pinLabel: false)
                    .expanded(flex: 75),
                const SizedBox(width: 10),
                buildTextFormField(
                  'מחיר ₪',
                  priceController,
                  pinLabel: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ).expanded(flex: 25),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                // Icons.place.icon(color: Colors.black38, size: 24).pOnly(left: 5),
                '2'
                    .toText(color: Colors.black38, fontSize: 24, bold: true)
                    .pOnly(left: 10),
                buildTextFormField(
                  'כתובת מוצא',
                  originController,
                  pinLabel: false,
                  onChanged: (value) async {
                    originSuggestions = await searchAddress(value) ?? [];
                    setState(() {});
                  },
                ).expanded(flex: 75),
                const SizedBox(width: 10),
                buildTextFormField(
                  'משקל',
                  weightController,
                  pinLabel: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ).expanded(flex: 25),
              ],
            ),
            Column(
              children: [
                if (originSuggestions.isNotEmpty) const SizedBox(height: 10),
                for (var sug in originSuggestions)
                  Card(
                    color: bgColorDark,
                    child: ListTile(
                        title: '${sug.name}'.toText(
                      bold: true,
                    )),
                  ).onTap(() async {
                    originSuggestions = [];
                    originController.text = sug.name.toString();
                    FocusScope.of(context).unfocus();
                    selectedOrigin = await getDetailsFromPlaceId(sug);
                    print('selectedAddress ${selectedOrigin?.lng}');
                    print('selectedAddress ${selectedOrigin?.lat}');
                    setState(() {});
                  }),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                // Icons.flag.icon(color: Colors.black38, size: 24).pOnly(left: 5),
                '3'
                    .toText(color: Colors.black38, fontSize: 24, bold: true)
                    .pOnly(left: 10),
                buildTextFormField(
                  'כתובת יעד',
                  destController,
                  pinLabel: false,
                  onChanged: (value) async {
                    destSuggestions = await searchAddress(value) ?? [];
                    setState(() {});
                  },
                ).expanded(),
              ],
            ),
            Column(
              children: [
                if (destSuggestions.isNotEmpty) const SizedBox(height: 10),
                for (var sug in destSuggestions)
                  Card(
                    color: bgColorDark,
                    child: ListTile(title: '${sug.name}'.toText(bold: true)),
                  ).onTap(() async {
                    destSuggestions = [];
                    destController.text = sug.name.toString();
                    FocusScope.of(context).unfocus();
                    selectedDest = await getDetailsFromPlaceId(sug);
                    print('selectedDest ${selectedDest?.lng}');
                    print('selectedDest ${selectedDest?.lat}');
                    setState(() {});
                  }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // Transform.scale(scaleX: 1, child: Icons.inventory.icon(color: Colors.black38, size: 22),).pOnly(left: 10),
                '4'
                    .toText(color: Colors.black38, fontSize: 24, bold: true)
                    .pOnly(left: 10),
                buildTextFormField('סוג משאית', truckController,
                    pinLabel: false, onChanged: (val) {
                  trucksSuggestions =
                      trucks.where((truck) => truck.contains(val)).toList();

                  if (truckController.text.isEmpty) trucksSuggestions = [];
                  setState(() {});
                }).expanded(),
              ],
            ),
            Column(
              children: [
                if (trucksSuggestions.isNotEmpty) const SizedBox(height: 10),
                for (var truck in trucksSuggestions)
                  Card(
                    color: bgColorDark,
                    child: ListTile(title: truck.toText(bold: true)),
                  ).onTap(() async {
                    trucksSuggestions = [];
                    truckController.text = truck.toString();
                    FocusScope.of(context).unfocus();
                    setState(() {});
                  }),
              ],
            ),
            const SizedBox(height: 15),
            TextButton(
              style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.purple[500]!, width: 1.5),
                  shape: 5.roundedShape),
              child: 'צור הובלה'
                  .toText(bold: true, color: Colors.purple[500]!)
                  .px(20)
                  .py(10),
              onPressed: () {
                onSubmit();
              },
            ),
            const SizedBox(height: 10),
          ],
        ).px(10),
      );

  void onSubmit() async {
    print('START: onSubmit()');

    if (titleController.text.isEmpty) {
      errText = '1. הזן פרטי הובלה';
      setState(() {});
      return;
    }

    if (priceController.text.isEmpty) {
      errText = '1. הזן מחיר בש"ח';
      setState(() {});
      return;
    }

    if (originController.text.isEmpty || selectedOrigin == null) {
      errText = '2. בחר כתובת מוצא';
      setState(() {});
      return;
    }

    if (weightController.text.isEmpty) {
      errText = '2. נא הזן משקל הובלה';
      setState(() {});
      return;
    }

    if (destController.text.isEmpty || selectedDest == null) {
      errText = '3. בחר כתובת מוצא';
      setState(() {});
      return;
    }

    if (truckController.text.isEmpty ||
        !(trucks.contains(truckController.text))) {
      errText = '4. בחר סוג משאית';
      setState(() {});
      return;
    }

    errText = '';
    setState(() {});
    final id = '${titleController.text}${UniqueKey()}';
    var newEvent = EventItem(
      id: id,
      title: titleController.text,
      createdAt: DateTime.now(),
      price: priceController.text,
      weight: weightController.text,
      truckType: truckController.text,
      originLat: selectedOrigin?.lat,
      originLong: selectedOrigin?.lng,
      originAddress: selectedOrigin?.name.toString().replaceAll(', ישראל', ''),
      destinationLat: selectedDest?.lat,
      destinationLong: selectedDest?.lng,
      status: adminModeV2 ? "Approved" : "Pending",
      destinationAddress:
          selectedDest?.name.toString().replaceAll(', ישראל', ''),
    );
    //
    print('newEvent.toJson() ${newEvent.toJson()}');
    Database.updateFirestore(
      collection: 'events',
      docName: id,
      toJson: newEvent.toJson(),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );

    flushBar(
      context,
      adminModeV2
          ? 'ההובלה נוספת לאפליקצייה בהצלחה!'
          : 'ההובלה ממתינה לאישור ותופיע בקרוב!',
      withShadow: true,
      isShimmer: true,
      duration: 4,
      textColor: Colors.white,
      // bgColor: bgColorDark,
      bgColor: Colors.purple[500]!,
    );
  }
}

InputDecoration fieldInputDeco(
    String? labelText, String? hintText, bool pinLabel) {
  return InputDecoration(
    floatingLabelBehavior: pinLabel ? FloatingLabelBehavior.always : null,
    contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
    labelText: labelText,
    hintText: hintText,
    labelStyle: GoogleFonts.openSans(
        textStyle: TextStyle(
            color: Colors.black.withOpacity(0.70),
            fontWeight: FontWeight.bold,
            fontSize: 13)),
    hintStyle:
        GoogleFonts.openSans(textStyle: const TextStyle(color: Colors.black54)),
    fillColor: Colors.black12,
    // filled: !enabled,
    disabledBorder: fieldDisableDeco,
    enabledBorder: fieldBorderDeco,
  );
}

Widget buildTextFormField(
  String labelText,
  TextEditingController? controller, {
  String? hintText,
  bool enabled = true,
  bool pinLabel = true,
  ValueChanged<String>? onChanged,
  TextInputType? keyboardType,
  FocusNode? focusNode,
}) {
  return TextFormField(
    // selectionControls:  FlutterSelectionControls(toolBarItems: [
    //   ToolBarItem(item: Text('Select All'), itemControl: ToolBarItemControl.selectAll),
    //   ToolBarItem(item: const Icon(Icons.copy), itemControl: ToolBarItemControl.copy),
    //   ToolBarItem(item: const Icon(Icons.cut), itemControl: ToolBarItemControl.cut),
    //   ToolBarItem(item: const Icon(Icons.paste), itemControl: ToolBarItemControl.paste),
    //
    // ]),
    focusNode: focusNode,
    keyboardType: keyboardType,
    enabled: enabled,
    controller: controller,
    onChanged: onChanged,
    textDirection: TextDirection.rtl,
    style: GoogleFonts.openSans(
        textStyle:
            TextStyle(color: Colors.black.withOpacity(0.70), fontSize: 14)),
    decoration: fieldInputDeco(labelText, hintText, pinLabel),
  );
}

// region ageList
var trucks = [
  'סמי טריילר - פלטה',
  'סמי טריילר - סקילט',
  'סמי טריילר - וילון',
  'סמי טריילר - קירור',
  'סמי טריילר - הייבר',
  'סמי טריילר - לובי קל',
  'סמי טריילר - לובי כבד',
  'סמי טריילר - מערבל בטון',
  'סמי טריילר - מנוף',
  'סמי טריילר - מובילית',
  'פול טריילר - פלטה',
  'פול טריילר - סקילט',
  'פול טריילר - וילון',
  'פול טריילר - הייבר',
  'פול טריילר - רמסע',
  'פול טריילר - מנוף',
  'פול טריילר - מובילית',
  'מעל 15 טון - פלטה',
  'מעל 15 טון - סקילט',
  'מעל 15 טון - וילון',
  'מעל 15 טון - הייבר',
  'מעל 15 טון - רמסע',
  'מעל 15 טון - מערבל בטון',
  'מעל 15 טון - מנוף',
  'מעל 15 טון - קירור',
  'מעל 15 טון - ארגז',
  'מעל 15 טון - גרר',
  'מעל 15 טון - מובילית',
  'עד 12 טון - פלטה',
  'עד 12 טון - וילון ',
  'עד 12 טון - מנוף',
  'עד 12 טון - ארגז',
  'עד 12 טון - גרר',
  'עד 12 טון - רמסע',
];

var ageRange = [
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  // 56,
  // 57,
  // 58,
  // 59,
  // 60,
];
