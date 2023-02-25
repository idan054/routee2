import 'dart:math';
import 'package:around/common/string_ext.dart';
import 'package:around/common/widget_ext.dart';
import 'package:flutter/material.dart';
import '../common/constants.dart';
import '../widgets.dart';
import 'category_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isShowLastedEvents = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 'קבוצות מסביבך'.toText(bold: true, fontSize: 18),
            const Image(image: AssetImage('assets/GPS-icon-White.png'), width: 35),
            'Around'.toText(bold: true, fontSize: 18),
            const Spacer(),
            // 'קבוצות עדכניות'.toText(bold: true, fontSize: 18),
            // const SizedBox(width: 5),
            //
            buildModeButton(
              isShowLastedEvents,
              onPressed: () {
                isShowLastedEvents = !isShowLastedEvents;
                setState(() {});
              },
            ).rtl,
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),


          (isShowLastedEvents
          // ? 'קבוצות עדכניות אליהם הזמינו אותך'
              ? 'הצטרף לקבוצות עדכניות שמיועדות לך (גיל 18)'
              : 'הצטרף לקבוצות קרובות שמיועדות לך (גיל 18)')
              .toText(fontSize: 14, color: Colors.grey, bold: true)
              .px(15),

          // 'קבוצות שהזמינו אותך להצטרף אליהם (:'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
          // 'הזמנות קרובות אלייך לבני גיל 19'.toText(fontSize: 14, color: Colors.grey, bold: true).px(15),
          // 'הזמנות לקבוצות עבורך'.toText(fontSize: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              var color = Colors.accents[Random().nextInt(Colors.accents.length)];
              var subSize = 12.0;
              var titleSize = 14.5;
              bool isShowTitle = (i ~/ 3) == (i / 3); // AKA Every 4 posts.

              return Column(
                children: [
                  // if (isShowTitle)
                  Row(
                    children: [
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.5, color: Colors.transparent),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        label: 'עוד'.toText(fontSize: subSize, color: color, bold: true),
                        icon: Icons.arrow_back.icon(color: color),
                        onPressed: () {
                          _handleGoToCategory(i);
                        },
                      ),
                      const Spacer(),
                      '${categories[i].categoryName}'
                          .toText(color: color, fontSize: 15, bold: true)
                          .centerRight
                    ],
                  ).px(15).onTap(() {
                    _handleGoToCategory(i);
                  }),
                  buildEventCard(context, titleSize, subSize, categories[i]),
                  buildEventCard(context, titleSize, subSize, categories[i]),
                  buildEventCard(context, titleSize, subSize, categories[i]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleGoToCategory(int i) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryPage(categories[i])),
    );
  }
}