
import 'package:shared_preferences/shared_preferences.dart';

class ConstPreferences {

  var ADDRESS = "ADDRESS";
  var FLOOR = "FLOOR";
  var BUILDING = "BUILDING";
  var FLATE = "FLATE";
  var LANDMARK = "LANDMARK";
  var USERDATA = "USERDATA";
  var NAME = "NAME";
  var EMAIL = "EMAIL";
  var INDEX = "INDEX";
  var PINCODE = "PINCODE";
  var DISCOUNT = "DISCOUNT";


  Future<void> saveDistributorId(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorId(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }


  Future<void> saveDistributorEmail(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorEmail(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveDistributorName(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorName(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> saveDistributorAddress(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorAddress(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> saveDistributorImage(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorImage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }


  void clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
