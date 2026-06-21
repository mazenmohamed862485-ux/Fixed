// packages/shared/lib/infrastructure/secure_screen_service.dart
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';

/// خدمة حماية الشاشات الحساسة من لقطات الشاشة والتسجيل
/// تعمل على Android فقط — على iOS لا توجد طريقة برمجية مكافئة
class SecureScreenService {
  SecureScreenService._();

  /// تفعيل الحماية — يُستدعى في initState() للشاشة الحساسة
  static Future<void> enable() async {
    if (!Platform.isAndroid) return;
    try {
      await FlutterWindowManagerPlus.addFlags(FlutterWindowManagerPlus.FLAG_SECURE);
      developer.log('FLAG_SECURE enabled', name: 'SecureScreenService');
    } catch (e) {
      developer.log('Failed to enable FLAG_SECURE: $e', name: 'SecureScreenService');
    }
  }

  /// تعطيل الحماية — يُستدعى في dispose() عند مغادرة الشاشة
  static Future<void> disable() async {
    if (!Platform.isAndroid) return;
    try {
      await FlutterWindowManagerPlus.clearFlags(FlutterWindowManagerPlus.FLAG_SECURE);
      developer.log('FLAG_SECURE disabled', name: 'SecureScreenService');
    } catch (e) {
      developer.log('Failed to disable FLAG_SECURE: $e', name: 'SecureScreenService');
    }
  }
}

/// Mixin لتسهيل تطبيق FLAG_SECURE في أي StatefulWidget
mixin SecureScreenMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    SecureScreenService.enable();
  }

  @override
  void dispose() {
    SecureScreenService.disable();
    super.dispose();
  }
}
