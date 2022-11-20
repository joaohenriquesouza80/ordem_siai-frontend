import 'package:flutter_native_timezone/flutter_native_timezone.dart' as tz;

import '../timezone_provider.dart';

class FlutterNativeTimezone implements TimeZoneProvider {
  @override
  Future<String> getLocalTimeZone() async {
    final locationName = await tz.FlutterNativeTimezone.getLocalTimezone();
    return locationName;
  }
}
