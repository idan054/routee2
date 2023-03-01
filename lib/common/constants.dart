import 'package:flutter/material.dart';

import 'models/address_result.dart';
import 'models/event_category.dart';
import 'models/event_item.dart';

var appVersion = 1.6;
const bgColor = Color(0xff1d1b31);
const bgColorLight = Color(0xff2b2848);

class UserData {
  int? age;
  AddressResult? address;

  UserData(
    this.age,
    this.address,
  );
}

var categoryColors = const [
  Color(0xffCC59E9),
  Color(0xffFF4F03),
  Color(0xffFD114A),
  Color(0xff00DA8F),
  Color(0xffFFA800),
  Color(0xff00B4D3),
  Color(0xffA80292),
  Color(0xff7ADA00),
];

// class EventCategory {
//   final CategoryType? categoryType;
//   final String? categoryName;
//   final Color? categoryColor;
//   final String? coverImagePath;
//
//   EventCategory({
//     this.categoryType,
//     this.categoryName,
//     this.categoryColor,
//     this.coverImagePath,
//   });
// }

var categories = [
  EventCategory(
      categoryType: CategoryType.weekend,
      // categoryName: 'קבוצות 18-24 ליציאה בסופש',
      categoryName: 'ליציאות בסופש',
      categoryColor: categoryColors[0],
      coverImagePath: 'assets/covers/weekend.png'),
  EventCategory(
      categoryType: CategoryType.barPub,
      // categoryName: 'קבוצות 18-24 לברים ומועדונים',
      categoryName: 'לברים ומועדונים',
      categoryColor: categoryColors[1],
      coverImagePath: 'assets/covers/bar_pub.png'),
  EventCategory(
      categoryType: CategoryType.boardGames,
      // categoryName: 'קבוצות 18-24 למשחקי קופסא',
      categoryName: 'למשחקי קופסא',
      categoryColor: categoryColors[2],
      coverImagePath: 'assets/covers/board_games.png'),
  EventCategory(
      categoryType: CategoryType.otherEvent,
      // categoryName: 'קבוצות 18-24 למפגשים ספונטנים',
      categoryName: 'למפגשים ספונטנים',
      categoryColor: categoryColors[3],
      coverImagePath: 'assets/covers/other_event.png'),
  EventCategory(
      categoryType: CategoryType.sport,
      // categoryName: 'קבוצות 18-24 לאימונים וספורט',
      categoryName: 'לאימונים וספורט',
      categoryColor: categoryColors[4],
      coverImagePath: 'assets/covers/sport.png'),
  EventCategory(
      categoryType: CategoryType.lecture,
      // categoryName: 'קבוצות 18-24 לסדנאות והרצאות',
      categoryName: 'לסדנאות והרצאות',
      categoryColor: categoryColors[5],
      coverImagePath: 'assets/covers/lecture.png'),
  EventCategory(
      categoryType: CategoryType.party,
      // categoryName: 'קבוצות 18-24 למסיבות ואירועים',
      categoryName: 'למסיבות ואירועים',
      categoryColor: categoryColors[6],
      coverImagePath: 'assets/covers/party.png'),
  EventCategory(
      categoryType: CategoryType.trip,
      // categoryName: 'קבוצות 18-24 לטיולים וחופשות',
      categoryName: 'לטיולים וחופשות',
      categoryColor: categoryColors[7],
      coverImagePath: 'assets/covers/trip.png'),
  EventCategory(
      categoryType: CategoryType.show,
      // categoryName: 'קבוצות 18-24 ללכת להופעות',
      categoryName: 'ללכת להופעות',
      categoryColor: categoryColors[0],
      coverImagePath: 'assets/covers/show.png'),
];

var sampleEvent = EventItem(
  title: 'באולינג בקניון של רחובות כולם מוזמנים',
  // eventAt: DateTime.now(),
  createdAt: DateTime.now(),
  address: 'חבקוק 114, גדרה',
  eventCategory: categories.first,
  latitude: '433224',
  longitude: '334241',
  phone: '+972584770076',
);
