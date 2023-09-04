import 'package:flutter/material.dart';
import 'package:routee/common/models/user_model/user_model.dart';
import 'package:routee/common/string_ext.dart';
import 'package:routee/common/widget_ext.dart';
import 'package:routee/widgets.dart';

import '../common/constants.dart';
import '../common/database.dart';
import '../common/models/bank_details/bank_details.dart';
import 'create_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class FormData {
  String label;

  TextEditingController controller = TextEditingController();

  FormData(this.label);
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> trucksSuggestions = [];
  List<FormData> formFields = [
    FormData('שם מלא'),
    FormData('טלפון'),
    FormData('חברת הובלות'),
    FormData('סוג משאית'),
    //
    FormData('שם מחזיק החשבון'),
    FormData('מספר חשבון בנק'),
    FormData('מספר סניף'),
    FormData('שם הבנק'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildHomeAppBar(context, title: 'להצטרפות'),
      body: ListView(
        children: [
          _buildForm(formFields),
          myOutlinedButton(
            'צור משתמש',
            onPressed: () {
              bool isValid = _formKey.currentState?.validate() ?? false;
              if (isValid) {
                final userData = UserModel(
                  fullName: formFields[0].controller.text,
                  phone: formFields[1].controller.text,
                  deliveryCompany: formFields[2].controller.text,
                  truckType: formFields[3].controller.text,
                  bankDetails: BankDetailsModel(
                    accountHolder: formFields[4].controller.text,
                    accountNumber: formFields[5].controller.text,
                    branchNumber: formFields[6].controller.text,
                    bankName: formFields[7].controller.text,
                  ),
                );
                flushBar(context, 'המשתמש נוצר בהצלחה!', bgColor: Colors.purple[500]!);
                Database.updateFirestore(
                    collection: 'users',
                    toJson: userData.toJson(),
                    docName: '${userData.fullName}-${UniqueKey()}');
              }
            },
          ).px(60).py(10)
        ],
      ).form(_formKey),
    );
  }

  Widget _buildForm(List<FormData> list) {
    return Column(
      children: [
        'פרטי שליח'
            .toText(fontSize: 16, bold: true)
            .centerRight
            .pOnly(top: 15, bottom: 5),
        ListView.separated(
          separatorBuilder: (context, i) {
            return i == 3
                ? 'חשבון בנק'
                    .toText(fontSize: 16, bold: true)
                    .centerRight
                    .pOnly(top: 10, bottom: 5)
                : const Offstage();
          },
          shrinkWrap: true,
          itemCount: list.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            final data = list[i];
            final truckType = data.label == 'סוג משאית';
            final suggLimit =
                trucksSuggestions.length <= 4 ? trucksSuggestions.length : 4;
            return Column(
              children: [
                buildTextFormField(data.label, data.controller, pinLabel: false,
                    validator: (val) {
                  final text = data.controller.text;
                  String? errString = text.isEmpty ? 'נא הכנס ' '${data.label}' : null;

                  if (truckType && !trucks.contains(text)) {
                    errString = 'בחר משאית מהרשימה';
                  }

                  return errString;
                }, onChanged: (val) {
                  if (truckType) {
                    trucksSuggestions =
                        trucks.where((truck) => truck.contains(val)).toList();

                    if (data.controller.text.isEmpty) trucksSuggestions = [];
                    setState(() {});
                  }
                }).py(7),

                //~ Suggestions
                if (truckType)
                  for (var truck in trucksSuggestions)
                    // .sublist(0, suggLimit))
                    Card(
                      color: bgColorDark,
                      child: ListTile(title: truck.toText(bold: true)),
                    ).onTap(() async {
                      trucksSuggestions = [];
                      data.controller.text = truck;
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    }),
              ],
            );
          },
        )
      ],
    ).px(20).rtl;
  }
}
