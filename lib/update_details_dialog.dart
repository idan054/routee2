import 'package:around/common/constants.dart';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';

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

void showUpdateDetailsDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.white12,
    builder: (_) {
      var emailController = TextEditingController();
      var messageController = TextEditingController();
      return AlertDialog(
        backgroundColor: bgColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 5),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child:
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 'ב Around ניתן להזמין ולקבל הזמנות בקלות'
                'ב Around תיצרו ותצטרפו '
                    'לקבוצות מסביבך'
                    .toText(bold: true, maxLines: 5, fontSize: 16)
                    .centerRight,
                const SizedBox(height: 10),
                Opacity(
                  opacity: .8,
                  child: Wrap(
                    spacing: 10,
                    children: [
                      for (var cat in categories)
                        Chip(
                          side: BorderSide(color: cat.categoryColor!, width: 2),
                          label: '${cat.categoryName}'.toText(fontSize: 12, bold: true),
                          backgroundColor: bgColor,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                'הפרטים שלך (להתאמה אישית)'.toText().centerRight,
                const SizedBox(height: 10),
                SizedBox(
                  height: 55,
                  child: Row(
                    // shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    children: [
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white70),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          counterText: '',
                          hintText: 'גיל',
                          hintStyle: const TextStyle(color: Colors.white30),
                          fillColor: Colors.white,
                          enabledBorder: fieldBorderDeco,
                        ),
                      ).expanded(flex: 30),
                      const SizedBox(width: 7),
                      TextFormField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          hintText: 'עיר מגורים',
                          hintStyle: const TextStyle(color: Colors.white30),
                          fillColor: Colors.white,
                          enabledBorder: fieldBorderDeco,
                        ),
                      ).expanded(flex: 70),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Send them to your email maybe?
                    var email = emailController.text;
                    var message = messageController.text;
                    Navigator.pop(context);
                  },
                  child: 'המשך'.toText(bold: true, color: Colors.purple[500]!),
                ).centerRight,
              ],
            ),
          ),
        ),
      );
    },
  );
}
