import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:routee/common/models/event_category.dart';
import 'package:routee/common/num_extensions.dart';
import 'package:routee/common/string_ext.dart';
import 'package:routee/common/widget_ext.dart';

import '../common/constants.dart';
import '../common/database.dart';
import '../common/google_location_complete.dart';
import '../common/models/address_result.dart';
import '../common/models/event_item.dart';
import '../update_details_dialog.dart';
import 'home_page.dart';

class CreatePage extends StatefulWidget {
  final bool showAppBar;

  const CreatePage({this.showAppBar = true, Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  RangeValues _currentRangeValues = const RangeValues(10, 55); // This NOT set Min & Max

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

  // endregion ageList
  var titleController = TextEditingController();
  var dateTimeController = TextEditingController();
  var phoneController = TextEditingController();
  var originController = TextEditingController();
  var destController = TextEditingController();
  String? errText;
  int? sValue;
  int? catIndex;
  EventCategory? selectedCategory;
  AddressResult? selectedAddress;
  List<AddressResult> originSuggestions = [];
  List<AddressResult> destSuggestions = [];

  final List<bool> isFeeEvent = <bool>[false, false];

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
        appBar: widget.showAppBar ? buildHomeAppBar() : null,
        body: SingleChildScrollView(
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
                  buildTextFormField('פרטי הובלה', titleController, pinLabel: false)
                      .expanded(flex: 75),
                  const SizedBox(width: 10),
                  buildTextFormField(
                    'מחיר ₪',
                    phoneController,
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
                  ).expanded(),
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
                      selectedAddress = await getDetailsFromPlaceId(sug);
                      print('selectedAddress ${selectedAddress?.lng}');
                      print('selectedAddress ${selectedAddress?.lat}');
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
                      // destSuggestions = await searchAddress(value) ?? [];
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
                      child: ListTile(
                          title: '${sug.name}'.toText(
                        bold: true,
                      )),
                    ).onTap(() async {
                      destSuggestions = [];
                      destController.text = sug.name.toString();
                      FocusScope.of(context).unfocus();
                      selectedAddress = await getDetailsFromPlaceId(sug);
                      print('selectedAddress ${selectedAddress?.lng}');
                      print('selectedAddress ${selectedAddress?.lat}');
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
                  buildTextFormField('סוג משאית', titleController, pinLabel: false)
                      .expanded(),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.purple[500]!, width: 1.5),
                    shape: 5.roundedShape),
                child: 'צור הובלה'
                    .toText(bold: true, color: Colors.purple[500]!)
                    .px(20)
                    .py(10),
                onPressed: () {
                  // onSubmit();
                },
              ),
              const SizedBox(height: 10),
            ],
          ).px(10),
        ),
      ),
    );
  }

  void onSubmit() {
    if (titleController.text.isEmpty) {
      errText = '1. הזן מה בתכנון?';
      setState(() {});
      return;
    }

    if (originController.text.isEmpty || selectedAddress == null) {
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

    if (isFeeEvent.contains(true) == false) {
      // AKA not .contains
      errText = 'בחר האם הקבוצה בתשלום או בחינם';
      setState(() {});
      return;
    }

    if (selectedCategory == null) {
      // errText = 'יש לבחור את מטרת הקבוצה';
      errText = 'יש לבחור את סוג הקבוצה';
      setState(() {});
      return;
    }

    var newEvent = EventItem(
      title: titleController.text,
      createdAt: DateTime.now(),
      phone: phoneController.text,
      eventCategory: selectedCategory,
      // address: selectedAddress?.name.toString(),
      originLat: selectedAddress?.lat,
      originLong: selectedAddress?.lng,
      // ageRange: ageRange,
      // withFee: isFeeEvent.first,
    );

    print('newEvent.toJson() ${newEvent.toJson()}');
    Database.updateFirestore(
      collection: 'events',
      toJson: newEvent.toJson(),
    );
    Navigator.pop(context);
  }

  AppBar _buildAppBar() {
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
          // const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
          // Assets.wtspLocationGroupIconSolid.image(height: 22).px(1),
          'הובלה חדשה'.toText(bold: true, fontSize: 18),
          const Spacer(),

          TextButton(
            child: 'יצירה'.toText(bold: true, color: Colors.purple[500]!),
            onPressed: () {
              onSubmit();
            },
          ),
          //
        ],
      ),
    );
  }

  Widget _buildRangeSlider() {
    return Column(
      children: [
        Row(children: [
          (" מיועד מגיל ${_currentRangeValues.start.round()}")
              .toText(color: Colors.black54, fontSize: 13, bold: true),
          const Spacer(),
          (_currentRangeValues.end.round() == 60
                  ? "60+"
                  : (" עד ${_currentRangeValues.end.round()}"))
              .toText(color: Colors.black54, fontSize: 13, bold: true),
        ]).px(22),
        RangeSlider(
          values: _currentRangeValues,
          min: 10,
          max: 60,
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
      ],
    );
  }

  Widget _buildGroupType() {
    return Row(
      children: [
        'סוג הקבוצה'.toText(bold: true, fontSize: 16),
        const Spacer(),
        // const SizedBox(width: 10),
        ToggleButtons(
          direction: Axis.horizontal,
          borderWidth: 1.65,
          // 1.75
          borderColor: Colors.black.withOpacity(0.42),
          selectedBorderColor: Colors.black.withOpacity(0.70),
          fillColor: bgColorDark,
          onPressed: (int index) {
            for (int i = 0; i < isFeeEvent.length; i++) {
              isFeeEvent[i] = i == index;
            }
            setState(() {});
          },
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          isSelected: isFeeEvent,
          children: [
            'בתשלום'
                .toText(fontSize: 13, bold: true, color: Colors.black.withOpacity(0.66))
                .px(15),
            'בחינם'
                .toText(fontSize: 13, bold: true, color: Colors.black.withOpacity(0.66))
                .px(15),
          ],
        ).sizedBox(null, 30),
      ],
    ).pOnly(right: 15, left: 15);
  }

  Wrap _buildTags() {
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
