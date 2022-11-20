import 'implementations/flutter_native_timezone.dart';

abstract class TimeZoneProvider {
  Future<String> getLocalTimeZone();

  factory TimeZoneProvider() {
    return FlutterNativeTimezone();
  }
}
