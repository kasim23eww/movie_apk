import 'package:connectivity_plus/connectivity_plus.dart';

class AppMethods {
  static Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static String getImageUrl(String path, {String size = "w500"}) {
    return "https://image.tmdb.org/t/p/$size$path";
  }
}
