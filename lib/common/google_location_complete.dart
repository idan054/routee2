import 'dart:convert';

import 'package:http/http.dart' as http;

// import "package:google_maps_webservice/places.dart";
import 'models/address_result.dart';
// import "package:google_maps_webservice/geocoding.dart";

// Future<List<AddressResult>?> searchAddressX(String searchTerm) async {
//   final places = GoogleMapsPlaces(
//       httpClient: http.Client(),
//       apiKey: "AIzaSyD-5oNLyCX9tiICMNCozzSH8ZoUbb_-7pg",
//       apiHeaders: {'Access-Control-Allow-Origin': '*'});
//   PlacesSearchResponse response = await places.searchByText(searchTerm, language: 'he');
//   // final geocoding = GoogleMapsGeocoding(apiKey: "AIzaSyD-5oNLyCX9tiICMNCozzSH8ZoUbb_-7pg");
//   // GeocodingResponse response = await geocoding.searchByAddress(searchTerm);
//   print('response.results ${response.results.length}');
//   List<AddressResult> suggestions = [];
//   for (var place in response.results) {
//     // final currSuggestion = AddressResult.fromJson(currJson);
//     final addressResult = AddressResult(
//       name: place.formattedAddress,
//       // main_text: גדרה description: גדרה, ישראל
//       placeId: place.placeId,
//       lat: place.geometry?.location.lat.toString(),
//       lng: place.geometry?.location.lng.toString(),
//     );
//     suggestions.add(addressResult);
//     // print('addressResult.toJson() ${addressResult.toJson()}');
//     print('suggestions ${suggestions.length}');
//   }
//   return suggestions;
// }

// var proxyBase = 'https://cors-anywhere.herokuapp.com/'; // Needed for WEB Access
var proxyBase = ''; // Needed for WEB Access

Future<List<AddressResult>?> searchAddress(String searchTerm) async {
  print('START: searchAddress() $searchTerm');

  // var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyCzo0DzVe0YEMjpPUVMOGX3rqTtKEXlS9g&language=he%26il&input=${input};
  // Just check index.js to see firebase functions (server) deploy
  var url =
      'https://us-central1-around-proj.cloudfunctions.net/autocomplete?input$searchTerm';
  final response =
      await http.get(Uri.parse(url), headers: {'Access-Control-Allow-Origin': '*'});

  print('response ${response.statusCode}');
  print('response ${response.body}');

  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    print('jsonBody ${(jsonBody['predictions'] as List).length}');
    // print('jsonBody ${jsonBody['predictions'][0]}');

    List<AddressResult> suggestions = [];
    for (var currJson in jsonBody['predictions']) {
      // final currSuggestion = AddressResult.fromJson(currJson);
      print('currJson ${currJson}');
      final currSuggestion = AddressResult(
        name: currJson['description'],
        // main_text: גדרה description: גדרה, ישראל
        placeId: currJson['place_id'],
      );
      suggestions.add(currSuggestion);
      print('suggestions ${suggestions.length}');
    }
    return suggestions;
  }
  print('START: return []()');
  return [];
}

// Future<PlaceByGooglePlaceIdModel> getDetailsFromPlaceId(String placeId) async {
Future getDetailsFromPlaceId(AddressResult address) async {
  print('START: getDetailsFromPlaceId()');

  // var url = 'https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyCzo0DzVe0YEMjpPUVMOGX3rqTtKEXlS9g&language=he&il&placeid=${placeId};
  // Just check index.js to see firebase functions (server) deploy
  var url =
      'https://us-central1-around-proj.cloudfunctions.net/placeDetails?placeId${address.placeId}';
  final response =
      await http.get(Uri.parse(url), headers: {'Access-Control-Allow-Origin': '*'});

  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    print('jsonBody $jsonBody');
    final result = jsonBody['result'];
    var addressResult = address.copyWith(
      lat: result['geometry']['location']['lat'].toString(),
      lng: result['geometry']['location']['lng'].toString(),
    );
    print('PlaceId addressResult.lat ${addressResult.lat}');
    print('PlaceId addressResult.lng ${addressResult.lng}');
    // final model = PlaceByGooglePlaceIdModel.fromJson(result, placeId: placeId);
    return addressResult;
  }
}
