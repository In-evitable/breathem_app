import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

setUnlock(String track, bool value) async {
  try {
    unlockMap = await getUnlockMap();
  } catch (e) {}
  unlockMap[track] = value;
  _set(unlockMap);
  var printedMap = await getUnlockMap();
  print('unlockMap from setUnlock() method: $printedMap');
}

Future<bool> getUnlock(String track) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawJsonData = prefs.getString('unlock');
    unlockMap = jsonDecode(rawJsonData!);
    print('unlockMap from getUnlock() method: $unlockMap');
    print(unlockMap[track]);
    return unlockMap[track];
  } catch (e) {
    print('getUnlock error: ${e.toString()}');
    print(unlockMap);
    return false;
  }
}

getUnlockMap() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    final rawJsonData = prefs.getString('unlock');
    unlockMap = jsonDecode(rawJsonData!);
  } catch (e) {
    print('${e.toString()} Couldn\'t get unlockMap.');
  }

  print('unlockMap from getUnlockMap method: $unlockMap');
  return unlockMap;
}

Map<String, dynamic> unlockMap = {};

_set(Map _unlockMap) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String rawJson = jsonEncode(_unlockMap);
  prefs.setString('unlock', rawJson);
}
