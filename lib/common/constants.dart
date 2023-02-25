import 'package:flutter/material.dart';

import 'models/event_category.dart';
import 'models/event_item.dart';

const bgColor = Color(0xff1d1b31);

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
      categoryName: 'קבוצות 18-24 ליציאה בסופש',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/weekend.png'),
  EventCategory(
      categoryType: CategoryType.barPub,
      categoryName: 'קבוצות 18-24 לברים ומועדונים',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/bar_pub.png'),
  EventCategory(
      categoryType: CategoryType.boardGames,
      categoryName: 'קבוצות 18-24 למשחקי קופסא',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/board_games.png'),
  EventCategory(
      categoryType: CategoryType.otherEvent,
      categoryName: 'קבוצות 18-24 למפגשים ספונטנים',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/other_event.png'),
  EventCategory(
      categoryType: CategoryType.sport,
      categoryName: 'קבוצות 18-24 לאימונים וספורט',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/sport.png'),
  EventCategory(
      categoryType: CategoryType.lecture,
      categoryName: 'קבוצות 18-24 לסדנאות והרצאות',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/lecture.png'),
  EventCategory(
      categoryType: CategoryType.party,
      categoryName: 'קבוצות 18-24 למסיבות ואירועים',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/party.png'),
  EventCategory(
      categoryType: CategoryType.trip,
      categoryName: 'קבוצות 18-24 לטיולים וחופשות',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/trip.png'),
  EventCategory(
      categoryType: CategoryType.show,
      categoryName: 'קבוצות 18-24 ללכת להופעות',
      categoryColor: categoryColors.first,
      coverImagePath: 'assets/covers/show.png'),
];

var sampleEvent = EventItem(
  title: 'באולינג בקניון של רחובות כולם מוזמנים',
  timestamp: DateTime.now(),
  address: 'חבקוק 114, גדרה',
  eventCategory: categories.first,
  latitude: '433224',
  longitude: '334241',
  phone: '+972584770076',
);