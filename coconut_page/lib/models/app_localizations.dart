import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('ko', 'KR'),
    Locale('en', 'US'),
  ];

  // Header
  String get wallet => _localizedValues[locale.languageCode]!['wallet']!;
  String get vault => _localizedValues[locale.languageCode]!['vault']!;
  String get docs => _localizedValues[locale.languageCode]!['docs']!;
  String get github => _localizedValues[locale.languageCode]!['github']!;
  String get download => _localizedValues[locale.languageCode]!['download']!;

  // Hero
  String get heroHeadline =>
      _localizedValues[locale.languageCode]!['heroHeadline']!;
  String get heroSubtext =>
      _localizedValues[locale.languageCode]!['heroSubtext']!;
  String get coconutWallet =>
      _localizedValues[locale.languageCode]!['coconutWallet']!;
  String get coconutVault =>
      _localizedValues[locale.languageCode]!['coconutVault']!;
  String get openSource =>
      _localizedValues[locale.languageCode]!['openSource']!;
  String get bitcoinOnly =>
      _localizedValues[locale.languageCode]!['bitcoinOnly']!;

  // Product Cards
  String get walletTitle =>
      _localizedValues[locale.languageCode]!['walletTitle']!;
  String get walletDesc =>
      _localizedValues[locale.languageCode]!['walletDesc']!;
  String get vaultTitle =>
      _localizedValues[locale.languageCode]!['vaultTitle']!;
  String get vaultDesc => _localizedValues[locale.languageCode]!['vaultDesc']!;
  String get learnMore => _localizedValues[locale.languageCode]!['learnMore']!;

  // Core Values
  String get coreValuesTitle =>
      _localizedValues[locale.languageCode]!['coreValuesTitle']!;
  String get value1 => _localizedValues[locale.languageCode]!['value1']!;
  String get value2 => _localizedValues[locale.languageCode]!['value2']!;
  String get value3 => _localizedValues[locale.languageCode]!['value3']!;
  String get value4 => _localizedValues[locale.languageCode]!['value4']!;

  // Open Source
  String get openSourceTitle =>
      _localizedValues[locale.languageCode]!['openSourceTitle']!;
  String get openSourceDesc =>
      _localizedValues[locale.languageCode]!['openSourceDesc']!;
  String get viewOnGithub =>
      _localizedValues[locale.languageCode]!['viewOnGithub']!;

  // Trust
  String get trustTitle =>
      _localizedValues[locale.languageCode]!['trustTitle']!;
  String get trustDesc => _localizedValues[locale.languageCode]!['trustDesc']!;

  // FAQ
  String get faqTitle => _localizedValues[locale.languageCode]!['faqTitle']!;
  String get faq1Q => _localizedValues[locale.languageCode]!['faq1Q']!;
  String get faq1A => _localizedValues[locale.languageCode]!['faq1A']!;
  String get faq2Q => _localizedValues[locale.languageCode]!['faq2Q']!;
  String get faq2A => _localizedValues[locale.languageCode]!['faq2A']!;
  String get faq3Q => _localizedValues[locale.languageCode]!['faq3Q']!;
  String get faq3A => _localizedValues[locale.languageCode]!['faq3A']!;
  String get faq4Q => _localizedValues[locale.languageCode]!['faq4Q']!;
  String get faq4A => _localizedValues[locale.languageCode]!['faq4A']!;

  // Footer
  String get footerLinks =>
      _localizedValues[locale.languageCode]!['footerLinks']!;
  String get footerPolicies =>
      _localizedValues[locale.languageCode]!['footerPolicies']!;
  String get footerCommunity =>
      _localizedValues[locale.languageCode]!['footerCommunity']!;
  String get privacyPolicy =>
      _localizedValues[locale.languageCode]!['privacyPolicy']!;
  String get termsOfService =>
      _localizedValues[locale.languageCode]!['termsOfService']!;
  String get openSourceNotice =>
      _localizedValues[locale.languageCode]!['openSourceNotice']!;
  String get contact => _localizedValues[locale.languageCode]!['contact']!;

  static final Map<String, Map<String, String>> _localizedValues = {
    'ko': {
      // Header
      'wallet': 'Wallet',
      'vault': 'Vault',
      'docs': 'Docs',
      'github': 'GitHub',
      'download': 'Get the app',

      // Hero
      'heroHeadline': '비트코인 셀프커스터디의 새로운 기준',
      'heroSubtext': '코코넛처럼 단단하고 친숙한 비트코인 셀프커스터디용 비트코인 지갑을 만나보세요.',
      'coconutWallet': 'Coconut Wallet',
      'coconutVault': 'Coconut Vault',
      'openSource': 'Open Source',
      'bitcoinOnly': 'Bitcoin-only',

      // Product Cards
      'walletTitle': 'Coconut Wallet',
      'walletDesc': '스마트폰으로 안전하게 자산을 \'보는\' 와치온리. PSBT로 서명 기기를 분리해 더 안전하게.',
      'vaultTitle': 'Coconut Vault',
      'vaultDesc': '공기계를 하드월렛처럼. 네트워크 없이, PSBT로 오프라인 서명.',
      'learnMore': '자세히 보기',

      // Core Values
      'coreValuesTitle': '핵심 가치',
      'value1': '비트코인 셀프커스터디의 새로운 기준',
      'value2': '코코넛 과일의 단단함을 비트코인에 접목했습니다.',
      'value3': '코코넛의 모든 소스코드는 공개되어 있어요.',
      'value4': '많은 비트코이너들이 코코넛을 사용하고 있어요.',

      // Open Source
      'openSourceTitle': '오픈소스 & 투명성',
      'openSourceDesc': '모든 소스코드를 공개합니다. 누구나 감사하고, 함께 개선할 수 있어요.',
      'viewOnGithub': 'GitHub에서 보기',

      // Trust
      'trustTitle': '신뢰받는 솔루션',
      'trustDesc': '많은 비트코이너가 코코넛을 선택했습니다. 당신도 합류하세요.',

      // FAQ
      'faqTitle': '자주 묻는 질문',
      'faq1Q': '왜 비트코인만 지원하나요?',
      'faq1A':
          '비트코인은 가장 안전하고 검증된 디지털 자산입니다. 단일 자산에 집중함으로써 보안성을 극대화하고 복잡성을 줄였습니다.',
      'faq2Q': '와치온리 지갑과 하드월렛의 차이는?',
      'faq2A':
          '와치온리 지갑은 잔액과 거래내역만 확인할 수 있고, 하드월렛은 개인키를 안전하게 보관하며 거래에 서명할 수 있습니다.',
      'faq3Q': '복구 문구 백업은 어떻게 하나요?',
      'faq3A':
          '복구 문구는 종이에 적어 안전한 곳에 보관하세요. 디지털로 저장하지 마시고, 여러 장소에 분산 보관하는 것을 권장합니다.',
      'faq4Q': 'PSBT와 에어갭이 무엇인가요?',
      'faq4A':
          'PSBT는 부분적으로 서명된 비트코인 거래를 의미하며, 에어갭은 네트워크 연결 없이 안전하게 거래에 서명하는 방식입니다.',

      // Footer
      'footerLinks': '링크',
      'footerPolicies': '정책',
      'footerCommunity': '커뮤니티',
      'privacyPolicy': '개인정보처리방침',
      'termsOfService': '이용약관',
      'openSourceNotice': '오픈소스 고지',
      'contact': '연락처',
    },
    'en': {
      // Header
      'wallet': 'Wallet',
      'vault': 'Vault',
      'docs': 'Docs',
      'github': 'GitHub',
      'download': 'Get the app',

      // Hero
      'heroHeadline': 'A new standard for Bitcoin self-custody',
      'heroSubtext':
          'Meet the Bitcoin self-custody wallet that is as strong and friendly as a coconut.',
      'coconutWallet': 'Coconut Wallet',
      'coconutVault': 'Coconut Vault',
      'openSource': 'Open Source',
      'bitcoinOnly': 'Bitcoin-only',

      // Product Cards
      'walletTitle': 'Coconut Wallet',
      'walletDesc':
          'A watch-only wallet on your phone. Safer with PSBT and a separate signing device.',
      'vaultTitle': 'Coconut Vault',
      'vaultDesc':
          'Turn a spare phone into a hardware-style vault. Offline PSBT signing, no network.',
      'learnMore': 'Learn more',

      // Core Values
      'coreValuesTitle': 'Core Values',
      'value1': 'A new standard for Bitcoin self-custody',
      'value2': 'Coconut-tough security meets Bitcoin excellence.',
      'value3': '100% open source. Auditable by anyone, improved by everyone.',
      'value4': 'Join thousands of Bitcoiners who trust Coconut.',

      // Open Source
      'openSourceTitle': 'Open Source & Transparency',
      'openSourceDesc':
          '100% open source. Auditable by anyone, improved by everyone.',
      'viewOnGithub': 'View on GitHub',

      // Trust
      'trustTitle': 'Trusted Solution',
      'trustDesc': 'Join thousands of Bitcoiners who trust Coconut.',

      // FAQ
      'faqTitle': 'Frequently Asked Questions',
      'faq1Q': 'Why Bitcoin-only?',
      'faq1A':
          'Bitcoin is the most secure and battle-tested digital asset. By focusing on a single asset, we maximize security and minimize complexity.',
      'faq2Q':
          'What\'s the difference between watch-only wallet and hardware wallet?',
      'faq2A':
          'Watch-only wallets can only view balances and transactions, while hardware wallets securely store private keys and can sign transactions.',
      'faq3Q': 'How should I backup my recovery phrase?',
      'faq3A':
          'Write your recovery phrase on paper and store it in a secure location. Never store it digitally, and consider distributed storage across multiple locations.',
      'faq4Q': 'What are PSBT and air-gap?',
      'faq4A':
          'PSBT stands for Partially Signed Bitcoin Transaction, and air-gap refers to safely signing transactions without network connectivity.',

      // Footer
      'footerLinks': 'Links',
      'footerPolicies': 'Policies',
      'footerCommunity': 'Community',
      'privacyPolicy': 'Privacy Policy',
      'termsOfService': 'Terms of Service',
      'openSourceNotice': 'Open Source Notice',
      'contact': 'Contact',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ko', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
