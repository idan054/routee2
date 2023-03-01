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

var proxyBase = 'https://cors-anywhere.herokuapp.com/'; // Needed for WEB Access

Future<List<AddressResult>?> searchAddress(String searchTerm) async {
  print('START: searchAddress() $searchTerm');

  // var url = 'https://pogoshneor.herokuapp.com/autocomplete';
  var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?key=AIzaSyCzo0DzVe0YEMjpPUVMOGX3rqTtKEXlS9g'
      '&language=he&il';

  final response = await http.get(
    Uri.parse('$proxyBase$url&input=$searchTerm'),
    headers: {
      'method': 'GET',
      'Access-Control-Allow-Methods': 'GET, HEAD, OPTIONS',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      // 'Access-Control-Allow-Origin': 'http://localhost:52610',
      'Access-Control-Allow-Credentials': 'true',
      'X-Requested-With': 'XMLHttpRequest',
      'Access-Control-Allow-Headers':
          'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
    },
  );

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
  var url = 'https://maps.googleapis.com/maps/api/place/details/json'
      '?key=AIzaSyCzo0DzVe0YEMjpPUVMOGX3rqTtKEXlS9g'
      '&language=he&il';
  final response = await http.get(
    Uri.parse('$proxyBase$url&placeid=${address.placeId}'),
    headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    },
  );

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
