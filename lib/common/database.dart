// .set() / .update() = WRITE.
import 'package:around/common/constants.dart';
import 'package:around/common/models/event_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haversine_distance/haversine_distance.dart';

import 'models/event_item.dart';

class Database {
  static var db = FirebaseFirestore.instance;
  static final advanced = FsAdvanced();

  get dbSetting {
    db.settings = const Settings(
        persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  }

  static void deleteDoc({required String collection, String? docName}) {
    db.collection(collection).doc(docName).delete();
  }

  static Future<Map<String, dynamic>?> docData(String documentPath) =>
      db.doc(documentPath).get().then((doc) => doc.data());

  static Future updateFirestore({
    required String collection,
    String? docName,
    required Map<String, dynamic> toJson,
    bool merge = true,
  }) async {
    db
        .collection(collection)
        .doc(docName)
        .set(toJson, SetOptions(merge: merge)) // Almost always true
        .onError((error, stackTrace) => print('updateFirestore ERR - $error'));
  }
}

class FsAdvanced {
  // Get 3 event start soon + Category filter
  // Get 3 lasted + Category filter
  // Get 3 location close + Category filter

  static final db = FirebaseFirestore.instance;
  static final reqBase = db
      .collection('events')
      .orderBy('eventAt', descending: false)
      .where('eventAt', isGreaterThanOrEqualTo: DateTime.now() // Hide DONE events;
          );

  //~ The 3 start soon events of each category:
  static Future<List<EventItem>> getHomeEvents(int age) async {
    print('START: getHomeEvents()');
    List eventDocs = [];
    List<EventItem> events = [];
    for (var category in categories) {
      var snap = await reqBase
          .where('ageRange', arrayContains: age)
          .where('eventCategory.categoryType', isEqualTo: category.categoryType?.name)
          .limit(3)
          .get();
      eventDocs.addAll(snap.docs);
    }
    events = eventDocs.map((doc) => EventItem.fromJson(doc.data())).toList();
    print('events ${events.length}');
    return events;
  }

  static Future<List<EventItem>> getCategoryEvents(
      UserData user, EventCategory eventCategory) async {
    print('START: getCategoryEvents()');
    List eventDocs = [];
    List<EventItem> events = [];
    var snap = await reqBase
        .where('ageRange', arrayContains: user.age)
        .where('eventCategory.categoryType', isEqualTo: eventCategory.categoryType?.name)
        .get();
    eventDocs.addAll(snap.docs);

    events = eventDocs.map((doc) => EventItem.fromJson(doc.data())).toList();

    print('events ${events.length}');
    return events;
  }
}

EventItem setDistance(UserData user, EventItem event) {
  final haversineDistance = HaversineDistance();
  final startCoordinate = Location(
    double.parse('${user.address?.lat}'),
    double.parse('${user.address?.lng}'),
  );
  final endCoordinate = Location(
    double.parse('${event.latitude}'),
    double.parse('${event.longitude}'),
  );

  var distance =
      haversineDistance.haversine(startCoordinate, endCoordinate, Unit.METER).floor();
  var updatedEvent = event.copyWith(distanceFromUser: distance);
  return updatedEvent;
}
