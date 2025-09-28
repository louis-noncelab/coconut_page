import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 웹에서만 import
import 'package:universal_html/html.dart' as html show window;

class DeviceInfo {
  static bool get isMobile {
    if (kIsWeb) {
      return false; // 웹에서는 MediaQuery로 구분
    }
    return Platform.isAndroid || Platform.isIOS;
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false; // 웹에서는 MediaQuery로 구분
    }
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }

  static bool get isWeb => kIsWeb;

  static bool get isAndroid {
    if (kIsWeb) return false;
    return Platform.isAndroid;
  }

  static bool get isIOS {
    if (kIsWeb) return false;
    return Platform.isIOS;
  }

  static bool get isWindows {
    if (kIsWeb) return false;
    return Platform.isWindows;
  }

  static bool get isMacOS {
    if (kIsWeb) return false;
    return Platform.isMacOS;
  }

  static bool get isLinux {
    if (kIsWeb) return false;
    return Platform.isLinux;
  }

  // 플랫폼 이름을 문자열로 반환
  static String get platformName {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  // 기기 타입을 문자열로 반환
  static String get deviceType {
    if (isMobile) return 'Mobile';
    if (isDesktop) return 'Desktop';
    if (isWeb) return 'Web';
    return 'Unknown';
  }

  // 웹에서 UserAgent 기반으로 브라우저 정보
  static String getWebBrowserInfo() {
    if (!kIsWeb) return 'Not Web';

    try {
      final userAgent = html.window.navigator.userAgent ?? '';
      return _parseBrowserInfo(userAgent);
    } catch (e) {
      return 'Unknown Browser';
    }
  }

  // UserAgent 문자열을 파싱하여 브라우저 정보 추출
  static String _parseBrowserInfo(String userAgent) {
    if (userAgent.contains('Chrome') && !userAgent.contains('Edg')) {
      return 'Chrome';
    } else if (userAgent.contains('Firefox')) {
      return 'Firefox';
    } else if (userAgent.contains('Safari') && !userAgent.contains('Chrome')) {
      return 'Safari';
    } else if (userAgent.contains('Edg')) {
      return 'Edge';
    } else if (userAgent.contains('Opera') || userAgent.contains('OPR')) {
      return 'Opera';
    } else {
      return 'Unknown Browser';
    }
  }

  // 웹에서 UserAgent 기반으로 모바일/데스크톱 구분
  static bool isWebMobile() {
    if (!kIsWeb) return false;

    try {
      final userAgent = html.window.navigator.userAgent ?? '';
      return _isMobileUserAgent(userAgent);
    } catch (e) {
      return false;
    }
  }

  // UserAgent로 모바일 기기 판단
  static bool _isMobileUserAgent(String userAgent) {
    final mobileKeywords = ['Mobile', 'Android', 'iPhone', 'iPad', 'iPod', 'BlackBerry', 'Windows Phone'];

    return mobileKeywords.any((keyword) => userAgent.contains(keyword));
  }

  // 웹에서 UserAgent 기반으로 OS 정보
  static String getWebOSInfo() {
    if (!kIsWeb) return 'Not Web';

    try {
      final userAgent = html.window.navigator.userAgent ?? '';
      return _parseOSInfo(userAgent);
    } catch (e) {
      return 'Unknown OS';
    }
  }

  // UserAgent로 OS 정보 추출
  static String _parseOSInfo(String userAgent) {
    if (userAgent.contains('Windows')) {
      return 'Windows';
    } else if (userAgent.contains('Mac OS X') || userAgent.contains('macOS')) {
      return 'macOS';
    } else if (userAgent.contains('Linux')) {
      return 'Linux';
    } else if (userAgent.contains('Android')) {
      return 'Android';
    } else if (userAgent.contains('iPhone') || userAgent.contains('iPad')) {
      return 'iOS';
    } else {
      return 'Unknown OS';
    }
  }
}

// MediaQuery를 사용한 웹에서의 모바일/데스크톱 구분
class WebDeviceInfo {
  static bool isMobile(BuildContext context) {
    if (!kIsWeb) return false;
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 768; // 일반적인 모바일 화면 크기 기준
  }

  static bool isTablet(BuildContext context) {
    if (!kIsWeb) return false;
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 768 && screenWidth < 1024;
  }

  static bool isDesktop(BuildContext context) {
    if (!kIsWeb) return false;
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 1024;
  }

  static String getDeviceType(BuildContext context) {
    if (isMobile(context)) return 'Mobile';
    if (isTablet(context)) return 'Tablet';
    if (isDesktop(context)) return 'Desktop';
    return 'Unknown';
  }
}
