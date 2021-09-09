import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

setMood(String mood) async {
  try {
    moodMap = await getMoodMap();
  } catch (e) {}
  moodMap[mood] =
      (_search(moodMap, mood) == null ? 1 : _search(moodMap, mood) + 1);
  _set(moodMap);
  var printedMap = await getMoodMap();
  print('moodMap from setMood() method: $printedMap');
  print(
      'result: ${(_search(moodMap, mood) == null ? 1 : _search(moodMap, mood) + 1)}');
}

getMood(String mood) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final rawJsonG = prefs.getString('mood');
  moodMap = jsonDecode(rawJsonG!);
  print('moodMap from getMood() method: $moodMap');
  return moodMap[mood];
}

getMoodMap() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final rawJsonG = prefs.getString('mood');
  moodMap = jsonDecode(rawJsonG!);
  print('moodMap from getMoodMap() method: $moodMap');
  return moodMap;
}

_search(Map<String, dynamic> map, String mood) {
  if (map.containsKey(mood)) {
    return map[mood];
  }
}

Map<String, dynamic> moodMap = {};

_set(Map moodMapParmaeter) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String rawJson = jsonEncode(moodMapParmaeter);
  prefs.setString('mood', rawJson);
}
