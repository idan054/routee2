import 'package:around/common/constants.dart';
import 'package:around/common/models/address_result.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:around/pages/create_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'common/google_location_complete.dart';
import 'gen/assets.gen.dart';

var fieldBorderDeco = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white38, width: 2),
    borderRadius: BorderRadius.circular(8));

var fieldDisableDeco = OutlineInputBorder(
    // borderSide: const BorderSide(color: Colors.transparent, width: 0),
    borderSide: const BorderSide(color: Colors.white38, width: 2),
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
                isErr,
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
                isErr,
                ageController,
                locationController,
                suggestions,
                selectedAddress,
                onConfirm,
              ),
            ),
          ),
  );
}

Widget updateInfoForm(
    bool fromUpdateButton,
    bool isErr,
    TextEditingController ageController,
    TextEditingController locationController,
    List<AddressResult> suggestions,
    AddressResult? selectedAddress,
    Function(UserData value) onConfirm) {
  var addressNode = FocusNode();

  // return SingleChildScrollView(
  return StatefulBuilder(
    builder: (context, setState) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.tagsAndIcon.image(),
        // .sizedBox(70, 70).py(20),
        // 'ב Around ניתן להזמין ולקבל הזמנות בקלות'
        'ב Around תיצרו ותצטרפו'
                '\nלקבוצות מסביבך'
            .toText(
              bold: true,
              maxLines: 5,
              fontSize: 18,
              textAlign: TextAlign.center,
            )
            .center,
        const SizedBox(height: 10),
        // if (!fromUpdateButton)
        //   Opacity(opacity: 0.8, child: Assets.tagsX.image().scale(scale: 1.1)),
        const SizedBox(height: 10),
        if (!fromUpdateButton)
          'פרטים להצטרפות'
              .toText(color: isErr ? Colors.red : Colors.white70)
              .centerRight
              .px(15),
        const SizedBox(height: 10),
        SizedBox(
          height: 55,
          child: Row(
            // shrinkWrap: true,
            // scrollDirection: Axis.horizontal,
            children: [
              TextFormField(
                controller: ageController,
                style: const TextStyle(color: Colors.white70),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  counterText: '',
                  labelText: 'גיל',
                  labelStyle:
                      const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                  fillColor: Colors.white,
                  enabledBorder: fieldBorderDeco,
                ),
              ).expanded(flex: 30),
              const SizedBox(width: 7),
              // TextFormField(
              //   controller: messageController,
              //   style: const TextStyle(color: Colors.white70),
              //   decoration: InputDecoration(
              //     contentPadding:
              //         const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              //     hintText: 'עיר מגורים',
              //     hintStyle: const TextStyle(color: Colors.white30),
              //     fillColor: Colors.white,
              //     enabledBorder: fieldBorderDeco,
              //   ),
              // )

              buildTextFormField(
                'עיר מגורים',
                locationController,
                focusNode: addressNode,
                onChanged: (value) async {
                  suggestions = await searchAddress(value) ?? [];
                  setState(() {});
                },
              ).expanded(flex: 70),
            ],
          ).px(15),
        ),

        Column(
          children: [
            if (suggestions.isNotEmpty) const SizedBox(height: 10),
            for (var sug in suggestions)
              Card(
                color: Colors.white24,
                child: ListTile(title: '${sug.name}'.toText(bold: true)),
              ).onTap(() async {
                suggestions = [];
                locationController.text = '${sug.name}'.toString();
                FocusScope.of(context).unfocus();
                selectedAddress = await getDetailsFromPlaceId(sug);
                setState(() {});
              }),
          ],
        ).px(15),

        const SizedBox(height: 10),
        Builder(builder: (context) {
          var isDisabled = (ageController.text.isEmpty || selectedAddress == null);
          return TextButton(
            onPressed: isDisabled
                ? null
                : () {
                    print('ageController.text ${ageController.text}');
                    print('selectedAddress ${selectedAddress}');

                    // if (isDisabled) {
                    //   isErr = true;
                    //   setState(() {});
                    //   return;
                    // }

                    if (onConfirm != null) {
                      var age = int.parse(ageController.text);
                      var box = Hive.box('uniBox');
                      box.put('userAge', int.parse(ageController.text));
                      box.put('userAddress', selectedAddress?.toJson());
                      // var name = box.get('name');
                      onConfirm(UserData(age, selectedAddress));
                    }
                    Navigator.pop(context);
                  },
            child: 'המשך'.toText(
                fontSize: 16,
                bold: true,
                color: isDisabled
                    ? Colors.purple[500]!.withOpacity(0.35)
                    : Colors.purple[500]!),
          ).centerRight;
        }).px(15),
        const SizedBox(height: 10),
        if (!fromUpdateButton) ...[
          const Spacer(),
          'גרסא $appVersion'.toText(color: Colors.grey, fontSize: 12).center,
          const SizedBox(height: 10),
        ]
      ],
    ),
  );
}
