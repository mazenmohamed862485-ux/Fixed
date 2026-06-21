# 🚀 إعداد المشروع — خطوات ضرورية قبل البناء

## 1️⃣ إنشاء ملف الأسرار (secrets.dart)

```bash
cp packages/shared/lib/config/secrets.dart.example \
   packages/shared/lib/config/secrets.dart
```

افتح `secrets.dart` وأدخل القيم الحقيقية:

```dart
static const String gasBaseUrl    = 'https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec';
static const String gasSecretKey  = 'your-secret-key-here';
static const String geminiApiKey  = 'your-gemini-api-key-here';
```

## 2️⃣ تنزيل الحزم

```bash
flutter pub get
# أو عبر Melos:
melos bootstrap
```

## 3️⃣ توليد ملفات الكود (*.g.dart) — ضروري جداً!

```bash
# من جذر المشروع:
cd packages/shared
dart run build_runner build --delete-conflicting-outputs

cd ../../apps/tobest
dart run build_runner build --delete-conflicting-outputs

cd ../tobest_management
dart run build_runner build --delete-conflicting-outputs
```

أو عبر Melos:
```bash
melos run build_runner
```

> ⚠️ **بدون هذه الخطوة لن يُترجم المشروع.** ملفات `*.g.dart` مُضافة في
> `.gitignore` ويجب توليدها محلياً في كل جهاز.

## 4️⃣ تشغيل التطبيق

```bash
# tobest
cd apps/tobest && flutter run

# tobest_management
cd apps/tobest_management && flutter run
```

---

## 🐛 ملخص الأخطاء التي تم إصلاحها

| رقم | الملف | المشكلة | الإصلاح |
|-----|-------|---------|---------|
| R1 | `apps/tobest/lib/router.dart` | `ref.watch(authStateProvider)` يُعيد إنشاء GoRouter عند تغيّر المصادقة → Splash يعود مجدداً | استُبدل بـ `refreshListenable` + `_AuthRouterNotifier` |
| R1 | `apps/tobest_management/lib/router.dart` | نفس المشكلة | نفس الإصلاح |
| S1 | `splash_screen.dart` | منطق التنقل كان يتعارض مع إعادة إنشاء الـ router | حُذف منطق التنقل — الـ router يتولاه تلقائياً |
| S1 | `mgmt_splash_screen.dart` | `Future.delayed(_navigate)` بدون فحص `mounted` | نفس الإصلاح |
