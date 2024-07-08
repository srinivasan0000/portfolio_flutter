import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode {
  light,
  dark,
}

class AppThemeModeNotifier extends Notifier<AppThemeMode> {
  @override
  AppThemeMode build() {
    final themeMode = ref.watch(sharedPreferencesProvider).getString("themeMode");
    return themeMode == AppThemeMode.dark.name ? AppThemeMode.dark : AppThemeMode.light;
  }

  void toggleTheme() {
    final newThemeMode = state == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
    ref.read(sharedPreferencesProvider).setString("themeMode", newThemeMode.name);
    state = newThemeMode;
  }
}

class AppThemeColorNotifier extends Notifier<int> {
  @override
  int build() {
    return ref.watch(sharedPreferencesProvider).getInt("themeColor") ?? 0xFF673AB7;
  }

  void changeColor(int color) {
    ref.read(sharedPreferencesProvider).setInt("themeColor", color);
    state = color;
  }
}

final appThemeModeProvider = NotifierProvider<AppThemeModeNotifier, AppThemeMode>(AppThemeModeNotifier.new);
final appThemeColorProvider = NotifierProvider<AppThemeColorNotifier, int>(AppThemeColorNotifier.new);

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class DateDiffNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final dateDiff = prefs.getString("dateDiff");
    if (dateDiff == null) {
      prefs.setString("dateDiff", DateTime.now().toIso8601String());
      return true;
    } else {
      final previousDate = DateTime.parse(dateDiff);
      int difference = DateTime.now().difference(previousDate).inDays;
      if (difference > 0) {
        prefs.remove("themeColor");
        prefs.remove("themeMode");
        prefs.setString("dateDiff", DateTime.now().toIso8601String());
        return true;
      } else {
        return false;
      }
    }
  }
}

final dateDiffProvider = NotifierProvider<DateDiffNotifier, bool>(DateDiffNotifier.new);
