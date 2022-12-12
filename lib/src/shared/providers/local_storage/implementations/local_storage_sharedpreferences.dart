import 'package:shared_preferences/shared_preferences.dart';

import '../local_storage_provider.dart';

class LocalStorageProviderSharedPreferences implements LocalStorageProvider {
  @override
  Future<void> deleteStorage({
    required String key,
  }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final bool deleted = await pref.remove(key);
      if (!deleted) {
        throw ('Erro ao excluir localmente a key: $key');
      }
    } catch (err) {
      print(err);
    }
    return;
  }

  @override
  Future<String> readStorage({
    required String key,
  }) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? '';
  }

  @override
  Future<void> writeStorage({
    required String key,
    required String value,
  }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final bool saved = await pref.setString(key, value);
      if (!saved) {
        throw ('Erro ao salvar localmente a key: $key');
      }
    } catch (err) {
      print(err);
    }
    return;
  }
}
