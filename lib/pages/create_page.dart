import 'dart:math';
import 'package:around/common/models/event_category.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../common/constants.dart';
import '../common/database.dart';
import '../common/google_location_complete.dart';
import '../common/models/address_result.dart';
import '../common/models/event_item.dart';
import '../common/assets.gen.dart';
import '../update_details_dialog.dart';
import '../widgets.dart';
import 'category_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  RangeValues _currentRangeValues = const RangeValues(10, 60);

  // region ageList
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
    40,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
  ];

  // endregion ageList
  var titleController = TextEditingController();
  var dateTimeController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  String? errText;
  int? sValue;
  int? catIndex;
  EventCategory? selectedCategory;
  AddressResult? selectedAddress;
  List<AddressResult> suggestions = [];

  @override
  void initState() {
    var box = Hive.box('uniBox');
    var phoneOrWhatsappGroup = box.get('userPhone').toString();
    if (phoneOrWhatsappGroup.length == 10) {
      phoneController.text = phoneOrWhatsappGroup;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 'ב Around ניתן להזמין ולקבל הזמנות בקלות'
              // 'ב Around תיצרו ותצטרפו ' 'לקבוצות מסביבך'.toText(bold: true, maxLines: 5, fontSize: 16).centerRight,
              const SizedBox(height: 15),
              if (errText != null)
                // 'אנא מלא את כל הפרטים'
                errText
                    .toString()
                    .toText(bold: true, fontSize: 16, color: Colors.red)
                    .center,
              const SizedBox(height: 15),

              Row(
                children: [
                  '1'
                      .toText(color: Colors.black38, fontSize: 24, bold: true)
                      .pOnly(left: 10),
                  buildTextFormField('מה בתכנון?', titleController, pinLabel: false)
                      .expanded(),
                ],
              ),
              const SizedBox(height: 5),
              // "מומלץ להוסיף אימוג'י 🤘 "
              //     .toText(color: Colors.black54, fontSize: 13, maxLines: 10)
              //     .pOnly(right: 25)
              //     .centerRight,
              const SizedBox(height: 10),
              Row(
                children: [
                  // buildTextFormField('מתי נפגש?', dateTimeController, enabled: false)
                  //     .onTap(() async {
                  //   selectedDateTime = await showOmniDateTimePicker(
                  //     context: context,
                  //     is24HourMode: true,
                  //     startFirstDate: DateTime.now(),
                  //   );
                  //   if (selectedDateTime == null) return;
                  //   dateTimeController.text = timeFormat(selectedDateTime!).toString();
                  //   setState(() {});
                  // }).expanded(),

                  '2'
                      .toText(color: Colors.black38, fontSize: 24, bold: true)
                      .pOnly(left: 10),
                  buildTextFormField(
                    'איפה נפגש?',
                    locationController,
                    pinLabel: false,
                    onChanged: (value) async {
                      suggestions = await searchAddress(value) ?? [];
                      setState(() {});
                    },
                  ).expanded(),
                ],
              ),

              Column(
                children: [
                  if (suggestions.isNotEmpty) const SizedBox(height: 10),
                  for (var sug in suggestions)
                    Card(
                      color: bgColorDark,
                      child: ListTile(
                          title: '${sug.name}'.toText(
                        bold: true,
                      )),
                    ).onTap(() async {
                      suggestions = [];
                      locationController.text = sug.name.toString();
                      FocusScope.of(context).unfocus();
                      selectedAddress = await getDetailsFromPlaceId(sug);
                      print('selectedAddress ${selectedAddress?.lng}');
                      print('selectedAddress ${selectedAddress?.lat}');
                      setState(() {});
                    }),
                ],
              ),

              const SizedBox(height: 15),
              Row(
                children: [
                  '3'
                      .toText(color: Colors.black38, fontSize: 24, bold: true)
                      .pOnly(left: 10),
                  buildTextFormField(
                    'קישור קבוצה / ווטסאפ לבקשות הצטרפות',
                    // "קישור קבוצה / מס' ווטסאפ",
                    phoneController,
                    pinLabel: false,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      var box = Hive.box('uniBox');
                      box.put('userPhone', phoneController.text);
                    },
                  ).expanded(),
                ],
              ),
              const SizedBox(height: 5),
              // if (errText != null && errText!.contains('טלפון'))
              //           "טלפון לדוגמא:  "
              //           "0545551234"
              // "\n"
              // "קבוצה לדוגמא:  "
              //         "\n"
              // "chat.whatsapp.com/BAnak"
              // "\n"

              "לדוגמא:  "
                      "0545551234"
                  .toText(color: Colors.black54, fontSize: 13, maxLines: 10)
                  .pOnly(right: 25)
                  .centerRight,
              const SizedBox(height: 25),
              Row(children: [
                // if (_currentRangeValues.start.round() == 10 &&
                //     _currentRangeValues.end.round() == 60) ...[
                //   (" מיועד לכל הגילאים ")
                //       .toText(color: Colors.black54, fontSize: 13, bold: true),
                // ] else ...[
                  (" מיועד לגיל ${_currentRangeValues.start.round()}")
                      .toText(color: Colors.black54, fontSize: 13, bold: true),
                  const Spacer(),
                  (" עד ${_currentRangeValues.end.round()}")
                      .toText(color: Colors.black54, fontSize: 13, bold: true),
                // ],
              ]).px(22),
              RangeSlider(
                values: _currentRangeValues,
                min: 10,
                max: 60,
                // divisions: 25,
                // labels: RangeLabels(
                //   _currentRangeValues.start.round().toString(),
                //   _currentRangeValues.end.round().toString(),
                // ),
                onChanged: (RangeValues values) {
                  print('START: onChanged()');
                  ageRange = [];
                  for (int i = values.start.round(); i <= values.end; i++) {
                    ageRange.add(i);
                    // print(i);
                  }
                  _currentRangeValues = values;
                  setState(() {});
                },
              ),
              const SizedBox(height: 15),
              'מטרת הקבוצה'.toText(bold: true, fontSize: 16).centerRight,
              const SizedBox(height: 15),
              buildTags(),
              // const SizedBox(height: 10),
              const SizedBox(height: 10),
            ],
          ).px(10),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: bgColorDark,
      // centerTitle: true,
      leading: Icons.arrow_back
          .icon(size: 25, color: Colors.black)
          .onTap(() => Navigator.pop(context)),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 'קבוצות מסביבך'.toText(bold: true, fontSize: 18),
          // 'Around'.toText(bold: true, fontSize: 18),
          const Spacer(),
          // const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
          const SizedBox(width: 5),
          // Assets.wtspLocationGroupIconSolid.image(height: 22).px(1),
          'קבוצה חדשה'.toText(bold: true, fontSize: 18),
          const Spacer(),
          // const SizedBox(width: 50),
          const SizedBox(width: 80),

          TextButton(
            onPressed: () {
              if (titleController.text.isEmpty) {
                errText = '1. הזן מה בתכנון?';
                setState(() {});
                return;
              }

              if (locationController.text.isEmpty || selectedAddress == null) {
                errText = '2. בחר איפה נפגש?';
                setState(() {});
                return;
              }

              if (phoneController.text.length != 10 &&
                  !(phoneController.text.contains('chat.whatsapp'))) {
                errText = '3. הזן קישור קבוצת ווטסאפ או טלפון תקין';
                setState(() {});
                return;
              }

              if (selectedCategory == null) {
                errText = 'יש לבחור את מטרת הקבוצה';
                setState(() {});
                return;
              }

              var newEvent = EventItem(
                title: titleController.text,
                createdAt: DateTime.now(),
                phone: phoneController.text,
                eventCategory: selectedCategory,
                address: selectedAddress?.name.toString(),
                latitude: selectedAddress?.lat,
                longitude: selectedAddress?.lng,
                ageRange: ageRange,
                // minAge: _currentRangeValues.start.round(),
                // maxAge: _currentRangeValues.end.round(),
              );

              print('newEvent.toJson() ${newEvent.toJson()}');
              Database.updateFirestore(
                collection: 'events',
                toJson: newEvent.toJson(),
              );
              Navigator.pop(context);
            },
            child: 'יצירה'.toText(bold: true, color: Colors.purple[500]!),
          ),
          //
        ],
      ),
    );
  }

  Wrap buildTags() {
    return Wrap(
      textDirection: TextDirection.rtl,
      runSpacing: 10, // up / down
      spacing: 5, // Left / right
      children: List<Widget>.generate(
        categories.length,
        (int i) {
          var cat = categories[i];
          return ChoiceChip(
            elevation: 2,
            pressElevation: 2,
            padding: EdgeInsets.zero,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8),
            // labelPadding: const EdgeInsets.only(left: 7.5),
            // avatar:
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(backgroundColor: cat.categoryColor, radius: 3),
                const SizedBox(width: 6),
                '${cat.categoryName}'
                    .toText(fontSize: 13, medium: false, color: Colors.black),
              ],
            ),
            // side: BorderSide(color: cat.categoryColor!, width: 2),
            selected: sValue == i,
            // backgroundColor: bgColor,
            backgroundColor: Colors.white,
            // selectedColor: cat.categoryColor!,
            // selectedColor: Colors.black.withOpacity(0.06),
            selectedColor: Colors.purple.withOpacity(0.12),
            onSelected: (bool selected) {
              sValue = selected ? i : null;
              selectedCategory = cat;
              print('selectedCategory.categoryType '
                  '${selectedCategory?.categoryType.toString()}');
              setState(() {});
            },
          )
              .sizedBox(null, 30)
              // .px(3.5)
              .rtl;
        },
      ).toList(),
    );
  }
}

InputDecoration fieldInputDeco(String? labelText, String? hintText, bool pinLabel) {
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
    hintStyle: GoogleFonts.openSans(textStyle: const TextStyle(color: Colors.black54)),
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
        textStyle: TextStyle(color: Colors.black.withOpacity(0.70), fontSize: 14)),
    decoration: fieldInputDeco(labelText, hintText, pinLabel),
  );
}
