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
import '../gen/assets.gen.dart';
import '../update_details_dialog.dart';
import '../widgets.dart';
import 'category_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  RangeValues _currentRangeValues = const RangeValues(16, 24);
  var ageRange = [16, 17, 18, 19, 20, 21, 22, 23, 24];
  var titleController = TextEditingController();
  var dateTimeController = TextEditingController();
  var phoneController = TextEditingController();
  var locationController = TextEditingController();
  bool isErrFound = false;
  int? sValue;
  int? catIndex;
  EventCategory? selectedCategory;
  DateTime? selectedDateTime;
  AddressResult? selectedAddress;
  List<AddressResult> suggestions = [];

  @override
  void initState() {
    var box = Hive.box('uniBox');
    phoneController.text = box.get('userPhone') ?? '';
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
              if (isErrFound)
                'אנא מלא את כל הפרטים'
                    .toText(bold: true, fontSize: 16, color: Colors.red)
                    .center,
              const SizedBox(height: 15),

              buildTextFormField('מה בתכנון?', titleController),
              const SizedBox(height: 15),
              Row(
                children: [
                  buildTextFormField('מתי נפגש?', dateTimeController, enabled: false)
                      .onTap(() async {
                    selectedDateTime = await showOmniDateTimePicker(
                      context: context,
                      is24HourMode: true,
                      startFirstDate: DateTime.now(),
                    );
                    if (selectedDateTime == null) return;
                    dateTimeController.text = timeFormat(selectedDateTime!).toString();
                    setState(() {});
                  }).expanded(),
                  const SizedBox(width: 10),
                  buildTextFormField(
                    'איפה נפגש?',
                    locationController,
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
                      color: Colors.white38,
                      child: ListTile(title: '${sug.name}'.toText(bold: true)),
                    ).onTap(() async {
                      suggestions = [];
                      locationController.text = sug.name.toString();
                      FocusScope.of(context).unfocus();
                      selectedAddress = await getDetailsFromPlaceId(sug);
                      setState(() {});
                    }),
                ],
              ),

              const SizedBox(height: 15),
              buildTextFormField(
                'ווטאספ לבקשות הצטרפות',
                phoneController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  var box = Hive.box('uniBox');
                  box.put('userPhone', phoneController.text);
                },
              ),
              const SizedBox(height: 5),
              " לדוגמא: 0545551234"
                  .toText(color: Colors.white54, fontSize: 13)
                  .centerRight,
              const SizedBox(height: 25),
              Row(
                children: [
                  (" מיועד לגיל ${_currentRangeValues.start.round()}")
                      .toText(color: Colors.white54, fontSize: 13, bold: true),
                  const Spacer(),
                  (" עד ${_currentRangeValues.end.round()}")
                      .toText(color: Colors.white54, fontSize: 13, bold: true),
                ],
              ).px(22),
              RangeSlider(
                values: _currentRangeValues,
                min: 10,
                max: 60,
                divisions: 25,
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
      backgroundColor: bgColor,
      // centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 'קבוצות מסביבך'.toText(bold: true, fontSize: 18),
          // 'Around'.toText(bold: true, fontSize: 18),
          const Spacer(),
          const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
          const SizedBox(width: 5),
          'קבוצה חדשה'.toText(bold: true, fontSize: 18),
          const Spacer(),
          const SizedBox(width: 50),

          TextButton(
            onPressed: () {
              if (selectedDateTime == null ||
                  selectedCategory == null ||
                  selectedAddress == null ||
                  phoneController.text.length != 10 ||
                  locationController.text.isEmpty ||
                  titleController.text.isEmpty) {
                isErrFound = true;
                setState(() {});
                return;
              }
              var newEvent = EventItem(
                title: titleController.text,
                eventAt: selectedDateTime,
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
      spacing: 10,
      children: List<Widget>.generate(
        categories.length,
        (int i) {
          var cat = categories[i];
          return ChoiceChip(
            label: '${cat.categoryName}'
                .toText(fontSize: 14, bold: true, color: Colors.white),
            side: BorderSide(color: cat.categoryColor!, width: 2),
            selected: sValue == i,
            backgroundColor: bgColor,
            selectedColor: cat.categoryColor!,
            onSelected: (bool selected) {
              sValue = selected ? i : null;
              selectedCategory = cat;
              setState(() {});
            },
          );
        },
      ).toList(),
    );
  }
}

InputDecoration fieldInputDeco(hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
    labelText: hintText,
    labelStyle: GoogleFonts.openSans(
        textStyle: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
    fillColor: Colors.white12,
    // filled: !enabled,
    disabledBorder: fieldDisableDeco,
    enabledBorder: fieldBorderDeco,
  );
}

Widget buildTextFormField(
  String hintText,
  TextEditingController? controller, {
  bool enabled = true,
  ValueChanged<String>? onChanged,
  TextInputType? keyboardType,
  FocusNode? focusNode,
}) {
  return TextFormField(
    focusNode: focusNode,
    keyboardType: keyboardType,
    enabled: enabled,
    controller: controller,
    onChanged: onChanged,
    style: GoogleFonts.openSans(
        textStyle: const TextStyle(color: Colors.white70, fontSize: 14)),
    decoration: fieldInputDeco(hintText),
  );
}
