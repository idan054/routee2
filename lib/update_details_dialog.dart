import 'package:around/common/constants.dart';
import 'package:around/common/models/address_result.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:around/pages/create_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'common/google_location_complete.dart';
import '../common/assets.gen.dart';

var fieldBorderDeco = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black38, width: 2),
    borderRadius: BorderRadius.circular(8));

var fieldDisableDeco = OutlineInputBorder(
    // borderSide: const BorderSide(color: Colors.transparent, width: 0),
    borderSide: const BorderSide(color: Colors.black38, width: 2),
    borderRadius: BorderRadius.circular(8));

// var fieldFocusBorderDeco = OutlineInputBorder(
//     borderSide: const BorderSide(color: Colors.grey, width: 2.5),
//     borderRadius: BorderRadius.circular(5));
//
// var fieldErrBorderDeco = OutlineInputBorder(
//     borderSide: const BorderSide(color: Colors.red, width: 2.5),
//     borderRadius: BorderRadius.circular(5));

Future showUpdateDetailsDialog(
  BuildContext context, {
  UserData? user,
  required Function(UserData value) onConfirm,
  bool fromUpdateButton = false,
}) {
  return showDialog(
    context: context,
    barrierColor: fromUpdateButton ? Colors.white12 : bgColor,
    barrierDismissible: false,
    builder: (_) {
      return updateInfoDialog(
        context,
        user: user,
        fromUpdateButton: fromUpdateButton,
        onConfirm: onConfirm,
      );
    },
  );
}

Widget updateInfoDialog(
  BuildContext context, {
  bool fromUpdateButton = false,
  UserData? user,
  required Function(UserData value) onConfirm,
}) {
  List<AddressResult> suggestions = [];
  AddressResult? selectedAddress;
  var ageController = TextEditingController();
  var locationController = TextEditingController();
  bool isErr = false;

  if (user != null) {
    ageController.text = '${user.age}';
    locationController.text = '${user.address?.name}';
    selectedAddress = user.address;
  }

  return LayoutBuilder(builder: (context, size) {
    bool wideMode = size.maxWidth < 600;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: fromUpdateButton
          ? AlertDialog(
              elevation: 0,
              backgroundColor: bgColor,
              contentPadding: EdgeInsets.zero,
              insetPadding: const EdgeInsets.symmetric(horizontal: 5),
              content: Directionality(
                textDirection: TextDirection.rtl,
                child: updateInfoForm(
                  fromUpdateButton,
                  wideMode,
                  ageController,
                  locationController,
                  suggestions,
                  selectedAddress,
                  onConfirm,
                ),
              ),
            )
          : Scaffold(
              backgroundColor: bgColor,
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: updateInfoForm(
                  fromUpdateButton,
                  wideMode,
                  ageController,
                  locationController,
                  suggestions,
                  selectedAddress,
                  onConfirm,
                ),
              ),
            ),
    );
  });
}

Widget updateInfoForm(
    bool fromUpdateButton,
    bool wideMode,
    TextEditingController ageController,
    TextEditingController addressController,
    List<AddressResult> suggestions,
    AddressResult? selectedAddress,
    Function(UserData value) onConfirm) {
  var addressNode = FocusNode();
  bool showLoader = false;

  var ageHint = ageController.text;
  var addressHint = addressController.text;
  if (fromUpdateButton) {
    ageController.text = '';
    addressController.text = '';
  }

  // return SingleChildScrollView(
  return StatefulBuilder(builder: (context, setState) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: .8,
          //   child: wideMode
          //       ? Assets.tagsAndIcon.image()
          //       : Assets.tagsAndIconWide.image().sizedBox(null, 300),
          // ),

          // .sizedBox(70, 70).py(20),
          // 'ב Around ניתן להזמין ולקבל הזמנות בקלות'

          // 'ב Around תיצרו ותצטרפו' '\nלקבוצות מסביבך'
          // 'להצטרף וליצור ' 'קבוצות חברתיות'
          // 'קבוצות חברתיות מסביבך'

          SizedBox(height: fromUpdateButton ? 20 : 200),
          Assets.appIcon.image(height: 80),

          // Assets.wtspBgWithIconX.image(),
          const SizedBox(height: 20),

          'Around - '
                  'קבוצות מסביבך'
              .toText(
                bold: true,
                maxLines: 5,
                fontSize: wideMode ? 16 : 26,
                textAlign: TextAlign.center,
              )
              .center,

          const SizedBox(height: 5),

          // 'לא משנה אם בא לך'
          ' ללכת למסיבה, לים, לטייל, או אפילו להתאמן.'
                  ' הכל כיף יותר ביחד (:'
              .toText(
                maxLines: 5,
                fontSize: wideMode ? 16 : 26,
                textAlign: TextAlign.center,
              )
              .center
              .px(20),
          const SizedBox(height: 5),

          // if (!fromUpdateButton)
          //   Opacity(opacity: 0.8, child: Assets.tagsX.image().scale(scale: 1.1)),
          const SizedBox(height: 25),
          if (!fromUpdateButton)
            Row(
              children: [
                'פרטים להצטרפות'.toText(color: Colors.black54).centerRight.px(15),
                SizedBox(width: width * 0.085),
                if (showLoader) const CircularProgressIndicator().sizedBox(15, 15),
              ],
            ),
          const SizedBox(height: 10),
          SizedBox(
            height: 55,
            child: Row(
              // shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              children: [
                TextFormField(
                  controller: ageController,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.black.withOpacity(0.70)),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  onChanged: (value) {
                    if (value.length == 2) {
                      if (selectedAddress == null) {
                        FocusScope.of(context).requestFocus(addressNode);
                      }
                      setState(() {});
                    }
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    counterText: '',
                    labelText: 'גיל',
                    hintText: ageHint,
                    labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.70),
                        fontWeight: FontWeight.bold),
                    hintStyle: const TextStyle(color: Colors.black54),
                    enabledBorder: fieldBorderDeco,
                  ),
                ).expanded(flex: 30),
                const SizedBox(width: 7),
                buildTextFormField(
                  'עיר מגורים',
                  hintText: addressHint,
                  addressController,
                  focusNode: addressNode,
                  onChanged: (value) async {
                    showLoader = true;
                    setState(() {});
                    // setState(() {}); // To start loader
                    suggestions = await searchAddress(value) ?? [];
                    showLoader = false;
                    setState(() {});
                  },
                ).expanded(flex: 70),
              ],
            ).px(15),
          ),

          // suggestions cards
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (suggestions.isNotEmpty) const SizedBox(height: 10),
              for (var sug in suggestions)
                Card(
                  color: bgColorDark,
                  child: ListTile(title: '${sug.name}'.toText(bold: true)),
                ).onTap(() async {
                  suggestions = [];
                  addressController.text = '${sug.name}'.toString();
                  showLoader = true;
                  setState(() {});
                  // FocusScope.of(context).unfocus();  // Hide keyboard
                  FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard
                  selectedAddress = await getDetailsFromPlaceId(sug);
                  showLoader = false;
                  setState(() {});
                }, radius: 10),
            ],
          ).px(15),

          const SizedBox(height: 10),
          Builder(builder: (context) {
            var age = ageController.text.isNotEmpty ? ageController.text : ageHint;
            var isDisabled = ((ageController.text.isEmpty && ageHint.isEmpty) ||
                selectedAddress == null);
            return TextButton(
              style: TextButton.styleFrom(
                  backgroundColor:
                      isDisabled ? bgColorDark.withOpacity(0.35) : bgColorDark),
              onPressed: isDisabled
                  ? null
                  : () {
                      // print('ageController.text ${ageController.text}');
                      print('age ${age}');
                      print('selectedAddress $selectedAddress');

                      // if (isDisabled) {
                      //   isErr = true;
                      //   setState(() {});
                      //   return;
                      // }

                      var intAge = int.parse(age);
                      var box = Hive.box('uniBox');
                      box.put('userAge', intAge);
                      box.put('userAddress', selectedAddress?.toJson());
                      // var name = box.get('name');
                      onConfirm(UserData(intAge, selectedAddress));
                      Navigator.pop(context);
                    },
              child: 'המשך'.toText(
                  fontSize: 16,
                  bold: true,
                  color: isDisabled ? Colors.black26 : Colors.black),
            ).centerRight;
          }).px(15),
          // AKA PlaceHolder
          if (suggestions.isEmpty) const SizedBox(height: 100),
          const SizedBox(height: 10),

          // if (!fromUpdateButton) ...[
          //   const SizedBox(height: 175),
          //   // const Spacer(),
          //   'גרסא $appVersion'.toText(color: Colors.grey, fontSize: 12).center,
          //   const SizedBox(height: 10),
          // ]
        ],
      ),
    );
  });
}
