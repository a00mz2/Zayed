import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceUUID {
  static const String _key = "device_uuid";

  // الحصول على UUID
  static Future<String> getUUID() async {
    final prefs = await SharedPreferences.getInstance();

    // لو UUID محفوظ مسبقاً → أعده
    String? existing = prefs.getString(_key);
    if (existing != null) return existing;

    // إنشاء UUID جديد لأول مرة
    String newId = const Uuid().v4();

    // حفظه ليصبح ثابتًا
    await prefs.setString(_key, newId);

    return newId;
  }
}
