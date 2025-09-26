import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('ko', 'KR');

  Locale get currentLocale => _currentLocale;

  bool get isKorean => _currentLocale.languageCode == 'ko';
  bool get isEnglish => _currentLocale.languageCode == 'en';

  void setLanguage(Locale locale) {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      notifyListeners();
    }
  }

  void toggleLanguage() {
    if (isKorean) {
      setLanguage(const Locale('en', 'US'));
    } else {
      setLanguage(const Locale('ko', 'KR'));
    }
  }
}

