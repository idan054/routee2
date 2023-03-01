import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/address_result.dart';

Future<List<AddressResult>?> searchAddress(String searchTerm) async {
  print('START: searchAddress() $searchTerm');

  var url = 'https://pogoshneor.herokuapp.com/autocomplete';
  // var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json''?key=AIzaSyCzo0DzVe0YEMjpPUVMOGX3rqTtKEXlS9g''&language=he&il';

  final response = await http.get(
    Uri.parse('$url&input=$searchTerm'),
    headers: {
      'method': 'GET',
      'Access-Control-Allow-Methods': 'GET, HEAD, OPTIONS',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      // 'Access-Control-Allow-Origin': 'http://localhost:52610',
      'Access-Control-Allow-Credentials': 'true',
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
    Uri.parse('$url&placeid=${address.placeId}'),
    headers: {
      'Content-Type': 'application/json',
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
    print('addressResult ${addressResult.lat}');
    print('addressResult ${addressResult.lng}');
    // final model = PlaceByGooglePlaceIdModel.fromJson(result, placeId: placeId);
    return addressResult;
  }
}
