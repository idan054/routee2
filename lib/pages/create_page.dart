import 'dart:math';
import 'package:around/common/models/event_category.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../common/constants.dart';
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
  var titleController = TextEditingController();
  var dateTimeController = TextEditingController();
  var phoneController = TextEditingController();
  int? sValue;
  int? catIndex;
  EventCategory? selectedCategory;
  DateTime? selectedDateTime;

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
              const SizedBox(height: 30),

              _buildTextFormField('מה בתכנון?', titleController),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildTextFormField('מתי נפגש?', dateTimeController, enabled: false)
                      .onTap(() async {
                    selectedDateTime = await showOmniDateTimePicker(
                      context: context,
                      is24HourMode: true,
                      startFirstDate: DateTime.now(),
                    );
                    if (selectedDateTime == null) return;
                    dateTimeController.text =
                        timeFormat(selectedDateTime!, withDay: false).toString();
                    setState(() {});
                  }).expanded(),
                  const SizedBox(width: 10),
                  _buildTextFormField('איפה נפגש?', null).expanded(),
                ],
              ),
              const SizedBox(height: 15),
              _buildTextFormField('ווטאספ לבקשות הצטרפות', phoneController),
              const SizedBox(height: 5),
              " לדוגמא: 0545551234"
                  .toText(color: Colors.white54, fontSize: 13)
                  .centerRight,
              const SizedBox(height: 15),
              'מטרת הקבוצה'.toText(bold: true, fontSize: 16).centerRight,
              const SizedBox(height: 15),
              buildTags(),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  if (selectedDateTime == null ||
                      selectedCategory == null ||
                      phoneController.text.length != 10 ||
                      titleController.text.isEmpty) {
                    return;
                  }
                  var newEvent = EventItem(
                    title: titleController.text,
                    timestamp: selectedDateTime,
                    phone: phoneController.text,
                    eventCategory: selectedCategory,
                    address: 'חבקוק 114, גדרה',
                    latitude: '433224',
                    longitude: '334241',
                  );
                  Navigator.pop(context);
                },
                child: 'צור קבוצה'.toText(bold: true, color: Colors.purple[500]!),
              ),
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

  Widget _buildTextFormField(String hintText, TextEditingController? controller,
      {bool enabled = true}) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      style: GoogleFonts.openSans(textStyle: const TextStyle(color: Colors.white70)),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        labelText: hintText,
        labelStyle: GoogleFonts.openSans(
            textStyle:
                const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
        fillColor: Colors.white12,
        // filled: !enabled,
        disabledBorder: fieldDisableDeco,
        enabledBorder: fieldBorderDeco,
      ),
    );
  }
}
