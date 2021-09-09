import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

setFavourite(String favourite, bool value) async {
  try {
    favouriteMap = await getFavouriteMap();
  } catch (e) {}
  favouriteMap[favourite] = value;
  _set(favouriteMap);
  var printedMap = await getFavouriteMap();
  print('favouriteMap from setFavourite() method: $printedMap');
}

getFavourite(String favourite) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawJsonData = prefs.getString('favourite');
    favouriteMap = jsonDecode(rawJsonData!);
    print('favouriteMap from getFavourite() method: $favouriteMap');
    print(favouriteMap[favourite]);
    return favouriteMap[favourite];
  } catch (e) {
    print(e.toString());
    return false;
  }
}

getFavouriteMap() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    final rawJsonData = prefs.getString('favourite');
    favouriteMap = jsonDecode(rawJsonData!);
  } catch (e) {
    print('Couldn\'t get favourite map.');
  }
  print('favouriteMap from getFavouriteMap() method: $favouriteMap');
  return favouriteMap;
}

Map<String, dynamic> favouriteMap = {};

_set(Map favouriteMapParmaeter) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String rawJson = jsonEncode(favouriteMapParmaeter);
  prefs.setString('favourite', rawJson);
}
