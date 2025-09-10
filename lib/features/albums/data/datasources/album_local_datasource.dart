import 'package:shared_preferences/shared_preferences.dart';

class AlbumLocalDatasource {
  final SharedPreferences localStorage;

  AlbumLocalDatasource({required this.localStorage});

  static final albumLocalStorageKey = 'albums';

  void writeLocalData(String albums) {
    localStorage.setString(albumLocalStorageKey, albums);
  }

  String? readLocalData() {
    return localStorage.getString(albumLocalStorageKey);
  }
}
