import 'implementations/local_storage_sharedpreferences.dart';

abstract class LocalStorageProvider {
  static String get storageKey => 'petClubDigital_app';

  Future<void> writeStorage({
    required String key,
    required String value,
  });

  Future<String> readStorage({
    required String key,
  });

  Future<void> deleteStorage({
    required String key,
  });

  factory LocalStorageProvider() {
    return LocalStorageProviderSharedPreferences();
  }
}
