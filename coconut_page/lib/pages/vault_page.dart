import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../providers/language_provider.dart';
import '../models/app_localizations.dart';
import '../widgets/coconut_button.dart';
import '../widgets/coconut_card.dart';
import '../widgets/coconut_badge.dart';
import '../theme/app_theme.dart';
import '../utils/app_router.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  bool _isComparisonExpanded = false;
  bool _isOfflineSafetyExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          final l10n = AppLocalizations(languageProvider.currentLocale);

          return CustomScrollView(
            slivers: [
              // Header
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: AppTheme.vaultBg.withOpacity(0.95),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(LucideIcons.arrowLeft),
                  onPressed: () => context.go(AppRouter.home),
                ),
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/coconut-logo.png',
                      height: 32,
                      width: 32,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Coconut',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: AppTheme.coconutBlack,
                      ),
                    ),
                  ],
                ),
                actions: [
                  // Language Toggle
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => languageProvider.setLanguage(
                          const Locale('ko', 'KR'),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: languageProvider.isKorean
                              ? AppTheme.coconutBlack
                              : AppTheme.vaultMuted,
                        ),
                        child: const Text('한국어'),
                      ),
                      TextButton(
                        onPressed: () => languageProvider.setLanguage(
                          const Locale('en', 'US'),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: languageProvider.isEnglish
                              ? AppTheme.coconutBlack
                              : AppTheme.vaultMuted,
                        ),
                        child: const Text('English'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  // Vault Badge
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CoconutBadge(
                      text: l10n.vault,
                      backgroundColor: Colors.transparent,
                      textColor: AppTheme.coconutBlack,
                      borderColor: AppTheme.coconutBlack.withOpacity(0.2),
                    ),
                  ),
                ],
              ),

              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.vaultBg,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          languageProvider.isKorean
                              ? '네트워크를 끊는 순간,'
                              : 'The moment you disconnect,',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coconutBlack,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          languageProvider.isKorean
                              ? '당신의 폰이 비트코인 금고가 됩니다'
                              : 'your phone becomes a Bitcoin vault',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coconutBlack,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          languageProvider.isKorean
                              ? '복잡하고 비싼 하드웨어 월렛 없이도,'
                              : 'Without complex and expensive hardware wallets,',
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppTheme.coconutBlack,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          languageProvider.isKorean
                              ? '오프라인으로 안전하게 셀프 커스터디 하세요'
                              : 'safely self-custody offline',
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppTheme.coconutBlack,
                            height: 1.6,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // Hero CTAs
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CoconutButton(
                              text: languageProvider.isKorean
                                  ? 'Android 다운로드'
                                  : 'Download for Android',
                              variant: CoconutButtonVariant.primary,
                              icon: LucideIcons.download,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 16),
                            CoconutButton(
                              text: languageProvider.isKorean
                                  ? 'iPhone 다운로드'
                                  : 'Download for iPhone',
                              variant: CoconutButtonVariant.outline,
                              icon: LucideIcons.download,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Quick Setup
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.vaultSurface,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean
                            ? '쉽고 빠르게, 비트코인 금고 만들기'
                            : 'Easy and fast Bitcoin vault setup',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                      const SizedBox(height: 40),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildSetupStep(
                            LucideIcons.download,
                            languageProvider.isKorean
                                ? '① 앱 다운로드'
                                : '① Download App',
                            languageProvider.isKorean
                                ? '스토어에서 코코넛 볼트를 설치하세요'
                                : 'Install Coconut Vault from the store',
                          ),
                          _buildSetupStep(
                            LucideIcons.wifiOff,
                            languageProvider.isKorean
                                ? '② 오프라인 모드 ON'
                                : '② Offline Mode ON',
                            languageProvider.isKorean
                                ? 'Wi-Fi, 블루투스 모두 끄기'
                                : 'Turn off Wi-Fi and Bluetooth',
                          ),
                          _buildSetupStep(
                            LucideIcons.smartphone,
                            languageProvider.isKorean
                                ? '③ 앱 실행'
                                : '③ Launch App',
                            languageProvider.isKorean
                                ? '비트코인 금고 완성 🙏'
                                : 'Bitcoin vault complete 🙏',
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Offline Safety Section
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isOfflineSafetyExpanded =
                                !_isOfflineSafetyExpanded;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppTheme.coconutBlack.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                languageProvider.isKorean
                                    ? '왜 오프라인이면 안전할까? - 스마트폰을 하드웨어 월렛처럼 쓰는 법'
                                    : 'Why is offline safe? - How to use your smartphone like a hardware wallet',
                                style: const TextStyle(
                                  color: AppTheme.coconutBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _isOfflineSafetyExpanded
                                    ? LucideIcons.chevronUp
                                    : LucideIcons.chevronDown,
                                size: 16,
                                color: AppTheme.coconutBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Detailed Offline Safety Section (Expandable)
                      if (_isOfflineSafetyExpanded)
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppTheme.coconutBlack.withOpacity(0.1)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                languageProvider.isKorean
                                    ? '“스마트폰이 하드웨어 월렛처럼 안전해질 수 있을까?”'
                                    : '"Can a smartphone be as safe as a hardware wallet?"',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.coconutBlack,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                languageProvider.isKorean
                                    ? '대부분의 사용자는 하드웨어 월렛을 ‘물리적 보안’이 보장된 안전한 장치로 인식합니다. 하지만 하드웨어 월렛도 인터넷에 연결되면 위험합니다. 그렇다면, 스마트폰을 완전히 오프라인 상태로 만든다면? 코코넛 볼트는 이 질문에서 출발합니다.'
                                    : 'Most users recognize hardware wallets as safe devices with ‘physical security’ guaranteed. However, hardware wallets are also at risk when connected to the internet. If a smartphone is completely offline, then? Coconut Vault starts from this question.',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: AppTheme.vaultMuted,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.isKorean
                                    ? '“오프라인 상태의 강력함 – 공격 벡터 원천 차단”'
                                    : '"The power of offline state – blocking attack vectors at source"',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.coconutBlack,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // 공격 벡터 비교 표
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppTheme.coconutBlack
                                          .withOpacity(0.1)),
                                ),
                                child: Table(
                                  children: [
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppTheme.vaultSurface)),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '공격 유형'
                                                : 'Attack Type',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.coconutBlack,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '네트워크 연결 시'
                                                : 'When Connected',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.vaultMuted,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '오프라인 상태 시'
                                                : 'When Offline',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.accentGreen,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppTheme.vaultSurface)),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '원격해킹'
                                                : 'Remote Hacking',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.coconutBlack,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                LucideIcons.check,
                                                color: Colors.red,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                languageProvider.isKorean
                                                    ? '가능'
                                                    : 'Possible',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                LucideIcons.x,
                                                color: AppTheme.accentGreen,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                languageProvider.isKorean
                                                    ? '불가능'
                                                    : 'Impossible',
                                                style: const TextStyle(
                                                  color: AppTheme.accentGreen,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppTheme.vaultSurface)),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '피싱/악성코드'
                                                : 'Phishing/Malware',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.coconutBlack,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '이메일/메시지 등을 통해 감염'
                                                : 'Infection via email/messages',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 7,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                LucideIcons.x,
                                                color: AppTheme.accentGreen,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                languageProvider.isKorean
                                                    ? '인터넷 접근 불가'
                                                    : 'No internet access',
                                                style: const TextStyle(
                                                  color: AppTheme.accentGreen,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppTheme.vaultSurface)),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '키 입력 도청'
                                                : 'Keylogging',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.coconutBlack,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '로거 또는 앱 감염 가능'
                                                : 'Logger or app infection possible',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 7,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                LucideIcons.x,
                                                color: AppTheme.accentGreen,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                languageProvider.isKorean
                                                    ? '네트워크/앱 설치 불가'
                                                    : 'No network/app install',
                                                style: const TextStyle(
                                                  color: AppTheme.accentGreen,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '백업 탈취'
                                                : 'Backup Theft',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.coconutBlack,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            languageProvider.isKorean
                                                ? '클라우드 연동 위험'
                                                : 'Cloud sync risk',
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 7,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                LucideIcons.x,
                                                color: AppTheme.accentGreen,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                languageProvider.isKorean
                                                    ? '클라우드 차단'
                                                    : 'Cloud blocked',
                                                style: const TextStyle(
                                                  color: AppTheme.accentGreen,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              Text(
                                languageProvider.isKorean
                                    ? '오프라인 상태는 모든 디지털 위협의 입구를 차단합니다. 잘 사용하기만 하면, 심지어 하드웨어 월렛보다 더 강력한 물리적 격리도 가능합니다.'
                                    : 'Offline state blocks all entry points of digital threats.If used properly, it can provide even stronger physical isolation than hardware wallets.',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: AppTheme.coconutBlack,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              // 스마트폰의 위협 요소
                              Text(
                                languageProvider.isKorean
                                    ? '스마트폰의 위협 요소는 \'연결성\'이다'
                                    : 'The threat factor of smartphones is \'connectivity\'',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.coconutBlack,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.isKorean
                                    ? '대부분의 보안 사고는 연결성 때문에 발생합니다.'
                                    : 'Most security incidents occur due to connectivity.',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: AppTheme.coconutBlack,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              // 위협 요소 목록
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppTheme.vaultSurface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    _buildThreatItem(
                                      languageProvider.isKorean
                                          ? '악성 앱 설치'
                                          : 'Malicious app installation',
                                    ),
                                    _buildThreatItem(
                                      languageProvider.isKorean
                                          ? '백업 자동 저장'
                                          : 'Automatic backup storage',
                                    ),
                                    _buildThreatItem(
                                      languageProvider.isKorean
                                          ? '알림 클릭을 통한 피싱'
                                          : 'Phishing through notification clicks',
                                    ),
                                    _buildThreatItem(
                                      languageProvider.isKorean
                                          ? '네트워크 스캔/도청'
                                          : 'Network scanning/eavesdropping',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              // 코코넛 볼트의 해결책
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppTheme.accentGreen
                                          .withOpacity(0.3)),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      '📴',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        languageProvider.isKorean
                                            ? '그래서 코코넛 볼트는 \'네트워크 완전 차단\'을 전제로 합니다.'
                                            : 'That\'s why Coconut Vault is based on \'complete network blocking\'.',
                                        style: const TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.coconutBlack,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.isKorean
                                    ? '스마트폰, 연결되었을 때는 가장 위험한 장치가 될 수 있지만, 끊어버리면 강력한 금고로 활용할 수 있습니다.'
                                    : 'Smartphones can be the most dangerous device when connected, but when disconnected, they can be used as a powerful vault.',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: AppTheme.coconutBlack,
                                  height: 1.6,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              // 스마트폰의 보안 잠재력
                              Text(
                                languageProvider.isKorean
                                    ? '당신의 스마트폰, 하드웨어 월렛 못지 않게 안전할 수 있습니다'
                                    : 'Your smartphone can be as safe as a hardware wallet',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.coconutBlack,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              // 보안 기술 목록
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppTheme.coconutBlack
                                          .withOpacity(0.1)),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      languageProvider.isKorean
                                          ? '오프라인, 암호화, 격리된 보안 공간, 생체 인증.'
                                          : 'Offline, encryption, isolated security space, biometric authentication.',
                                      style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.coconutBlack,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      languageProvider.isKorean
                                          ? '이 모든 기술이 이미 당신의 스마트폰에 있습니다.'
                                          : 'All these technologies are already in your smartphone.',
                                      style: const TextStyle(
                                        fontSize: 7,
                                        color: AppTheme.vaultMuted,
                                        height: 1.4,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                languageProvider.isKorean
                                    ? '코코넛 볼트는 이 환경을 안전하게 구성하고, 누구나 쉽게 사용할 수 있도록 디자인되었습니다.'
                                    : 'Coconut Vault is designed to safely configure this environment and make it easy for anyone to use.',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: AppTheme.coconutBlack,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              // 핵심 메시지
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.accentGreen.withOpacity(0.1),
                                      AppTheme.accentGreen.withOpacity(0.05),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: AppTheme.accentGreen
                                          .withOpacity(0.3)),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      '🎯',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      languageProvider.isKorean
                                          ? '핵심은 하나입니다. 연결을 끊으세요. 그러면, 금고가 됩니다.'
                                          : 'The key is one. Disconnect. Then it becomes a vault.',
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.coconutBlack,
                                        height: 1.5,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              // 내용은 나중에 추가될 예정
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppTheme.vaultSurface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  languageProvider.isKorean
                                      ? '내용은 곧 추가될 예정입니다.'
                                      : 'Content will be added soon.',
                                  style: const TextStyle(
                                    fontSize: 7,
                                    color: AppTheme.vaultMuted,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 32),
                      Text(
                        languageProvider.isKorean
                            ? '설명서? 택배 추적? 펌웨어 업데이트?'
                            : 'Manual? Package tracking? Firmware updates?',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        languageProvider.isKorean
                            ? '코코넛 볼트를 사용하면 신경쓸 필요 없어요.'
                            : 'With Coconut Vault, you don\'t need to worry about any of that.',
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppTheme.vaultMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Comparison Table
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean
                            ? '기존 하드월렛 vs 코코넛 볼트'
                            : 'Hardware Wallets vs Coconut Vault',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                      const SizedBox(height: 32),
                      CoconutCard(
                        child: Table(
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppTheme.vaultSurface)),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    languageProvider.isKorean
                                        ? '구분'
                                        : 'Category',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.coconutBlack,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    languageProvider.isKorean
                                        ? '기존 하드월렛'
                                        : 'Hardware Wallets',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.vaultMuted,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    languageProvider.isKorean
                                        ? '코코넛 볼트'
                                        : 'Coconut Vault',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.accentGreen,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            _buildComparisonRow(
                              languageProvider.isKorean ? '가격' : 'Price',
                              languageProvider.isKorean ? '8~20만원' : '\$60-150',
                              languageProvider.isKorean ? '무료' : 'Free',
                            ),
                            _buildComparisonRow(
                              languageProvider.isKorean
                                  ? '배송기간'
                                  : 'Shipping Time',
                              languageProvider.isKorean
                                  ? '평균 5~14일'
                                  : '5-14 days average',
                              languageProvider.isKorean
                                  ? '즉시사용'
                                  : 'Instant use',
                            ),
                            _buildComparisonRow(
                              languageProvider.isKorean
                                  ? '설치/초기 설정'
                                  : 'Installation/Setup',
                              languageProvider.isKorean
                                  ? '펌웨어 업데이트, 백업 필수'
                                  : 'Firmware update, backup required',
                              languageProvider.isKorean
                                  ? '앱 설치만'
                                  : 'App install only',
                            ),
                            _buildComparisonRow(
                              languageProvider.isKorean
                                  ? '보안성 확보 조건'
                                  : 'Security Requirements',
                              languageProvider.isKorean
                                  ? '기본 탑재'
                                  : 'Built-in by default',
                              languageProvider.isKorean
                                  ? '오프라인 상태 유지'
                                  : 'Maintain offline state',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Expandable Link
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isComparisonExpanded = !_isComparisonExpanded;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppTheme.coconutBlack.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                languageProvider.isKorean
                                    ? '하드월렛? 코코넛 볼트? 나에게 맞는 선택은?'
                                    : 'A hardware wallet? Coconut Vault? Which one’s the right fit for me?',
                                style: const TextStyle(
                                  color: AppTheme.coconutBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _isComparisonExpanded
                                    ? LucideIcons.chevronUp
                                    : LucideIcons.chevronDown,
                                size: 16,
                                color: AppTheme.coconutBlack,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Detailed Comparison Section (Expandable)
              if (_isComparisonExpanded)
                SliverToBoxAdapter(
                  child: Container(
                    color: AppTheme.vaultSurface,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          languageProvider.isKorean
                              ? '나에게 코코넛 볼트가 적합할까?'
                              : 'Is a Coconut Vault the right fit for me?',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coconutBlack,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // 상세 설명 블록들
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"누군가에게 비트코인 지갑이 있다는 사실을 알리고 싶지 않아요."'
                              : '"I don\'t want anyone to know I have a Bitcoin wallet."',
                          languageProvider.isKorean
                              ? '스마트폰에 비트코인 지갑이 있다는 건 겉으로 전혀 드러나지 않습니다.\n집에서 우연히 하드월렛을 발견했을 때와, 사용하지 않는 스마트폰을 발견했을 때\n사람들의 반응을 한번 상상해보세요.'
                              : 'Having a Bitcoin wallet on a smartphone is completely invisible from the outside.\nImagine people\'s reactions when they accidentally find a hardware wallet at home\nversus when they find an unused smartphone.',
                          languageProvider.isKorean
                              ? '그래서 코코넛 볼트는 비트코인 지갑으로 적합합니다.'
                              : 'That\'s why a Coconut Vault is perfect as a Bitcoin wallet.',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"비트코인 지갑이 고장 날까 봐 걱정이에요."'
                              : '"I\'m worried my Bitcoin wallet might break."',
                          languageProvider.isKorean
                              ? '대부분의 하드월렛은 겉보기엔 튼튼해 보여도, 실제로는 일반 스마트폰보다 충격이나 압력에 더 약합니다.\n실수로 밟거나 앉는 등 일상적인 사고에 더 취약하죠.\n반면, 스마트폰은 일상의 혹독한 사용 환경을 견디도록 설계되어 있어, 물리적인 내구성 면에서 더 신뢰할 수 있습니다.'
                              : 'Most hardware wallets may look sturdy on the outside, but they are actually more vulnerable to shock and pressure than regular smartphones.\nThey are more susceptible to everyday accidents like accidentally stepping on them or sitting on them.\nOn the other hand, smartphones are designed to withstand harsh daily use environments, making them more reliable in terms of physical durability.',
                          languageProvider.isKorean
                              ? '내구성 좋은 지갑을 원한다면 코코넛 볼트가 더 적합합니다.'
                              : 'If you want a durable wallet, a Coconut Vault is more suitable.',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"실수로 스마트폰을 인터넷에 연결할까 봐 걱정돼요."'
                              : '"I\'m worried I might accidentally connect my smartphone to the internet."',
                          languageProvider.isKorean
                              ? '스스로 통신 기능을 완전히 차단하지 못하면, 오프라인 스마트폰 사용은 잠재적인 위험이 될 수 있습니다.\n와이파이나 블루투스가 켜지는 순간, 외부 공격의 가능성이 생기니까요.\n기기에 익숙하지 않거나 통신 제어에 자신이 없다면, 이러한 리스크를 줄이기 어려울 수 있습니다.'
                              : 'If you cannot completely block communication functions yourself, using an offline smartphone can be a potential risk.\nThe moment Wi-Fi or Bluetooth is turned on, the possibility of external attacks arises.\nIf you are not familiar with the device or not confident in communication control, it may be difficult to reduce these risks.',
                          languageProvider.isKorean
                              ? '이런 경우엔 하드월렛이 더 적합합니다.'
                              : 'In such cases, a hardware wallet is more suitable.',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"스마트폰(또는 하드월렛) 제조사를 믿지 못하겠어요."'
                              : '"I can\'t trust smartphone (or hardware wallet) manufacturers."',
                          languageProvider.isKorean
                              ? '스마트폰이든 하드월렛이든, 제조사를 완전히 신뢰할 수 있을지에 대한 의문은 늘 존재합니다.\n하지만 한 관점을 떠올려볼 수 있습니다.\n\n스마트폰은 애초에 비트코인을 보관하도록 설계된 기기가 아닙니다.\n즉, 제조사 입장에선 이 기기에 비트코인이 들어 있을 것이라 예상하지 않죠.\n반면, 하드월렛은 처음부터 비트코인을 담기 위해 만들어진 기기입니다.\n하드월렛 제조사는 이 기기를 통해 실제 비트코인이 보관될 것임을 명확히 인지하고 있죠.\n\n그렇다면, 어느 쪽이 백도어를 심을 동기가 더 클까요? 결국 어떤 제조사를 더 신뢰할지는 여러분의 몫입니다.\n하지만 그 가능성과 동기를 함께 고려해보는 것, 그것이 보안의 출발점이 될 수 있습니다.'
                              : 'Whether it\'s a smartphone or a hardware wallet, there are always doubts about whether you can completely trust the manufacturer.\nBut there\'s one perspective to consider.\n\nSmartphones were not originally designed to store Bitcoin.\nIn other words, from the manufacturer\'s perspective, they don\'t expect Bitcoin to be stored on this device.\nOn the other hand, hardware wallets are devices created specifically to hold Bitcoin from the beginning.\nHardware wallet manufacturers clearly recognize that actual Bitcoin will be stored through this device.\n\nSo, which side has more motivation to plant a backdoor? Ultimately, which manufacturer to trust more is up to you.\nBut considering both the possibility and motivation together can be the starting point of security.',
                          languageProvider.isKorean
                              ? '이런 관점에서 보면, 코코넛 볼트가 더 적합할 수 있습니다.'
                              : 'From this perspective, a Coconut Vault may be more suitable.',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"스마트폰 OS는 오픈소스가 아니라서 불안해요."'
                              : '"I\'m worried because smartphone OS is not open source."',
                          languageProvider.isKorean
                              ? '소스코드가 공개되어 있고, 누구나 검증할 수 있다는 점은 신뢰에 있어 매우 중요한 기준입니다.\n이 기준은 하드월렛을 포함한 모든 장비에 적용될 수 있습니다.\n\n실제로 많은 하드월렛 제조사들이 펌웨어는 오픈소스로 제공하지만,\n운영체제(OS)는 오픈소스가 아닌 경우도 적지 않습니다.\n\n만약 운영체제까지도 오픈소스이기를 바란다면,\n선택지는 매우 한정적일 수 있습니다.'
                              : 'The fact that source code is open and anyone can verify it is a very important criterion for trust.\nThis criterion can be applied to all equipment, including hardware wallets.\n\nIn fact, many hardware wallet manufacturers provide firmware as open source,\nbut there are also quite a few cases where the operating system (OS) is not open source.\n\nIf you want the operating system to be open source as well,\nyour choices may be very limited.',
                          languageProvider.isKorean
                              ? '이런 기준을 중요하게 생각한다면, 하드월렛이 더 적합합니다.'
                              : 'If you consider this criterion important, a hardware wallet is more suitable.',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"누군가가 지갑의 비밀번호를 풀까봐 두려워요."'
                              : '"I\'m afraid someone might crack my wallet password."',
                          languageProvider.isKorean
                              ? '하드월렛 제조사들은 비밀번호를 반복적으로 틀릴 경우\n기기를 초기화하거나 잠그는 브루트포스 공격 차단 기능을 제공합니다.\n\n스마트폰의 경우도 마찬가지입니다.\n예를 들어, 아이폰이나 갤럭시 같은 주요 기기들은\n비밀번호를 여러 번 틀리면 잠금 또는 초기화되는 강력한 보안 메커니즘을 탑재하고 있습니다.\n\n어느 쪽이 더 안전한지 단정하기는 어렵습니다.\n결국, 보안 수준은 제조사의 설계와 정책에 달려 있기 때문입니다.'
                              : 'Hardware wallet manufacturers provide brute force attack prevention features that\ninitialize or lock the device when passwords are entered incorrectly repeatedly.\n\nSmartphones are no different.\nFor example, major devices like iPhones or Galaxies are equipped with\nstrong security mechanisms that lock or initialize when passwords are entered incorrectly multiple times.\n\nIt\'s difficult to definitively say which is safer.\nUltimately, the security level depends on the manufacturer\'s design and policies.',
                          languageProvider.isKorean
                              ? '보안 정책과 구현 방식을 잘 따져보고 선택하세요.'
                              : 'Carefully consider security policies and implementation methods when choosing.',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"누군가가 지갑을 분해해서 메모리에 직접 접근하면 어떻게 하죠?"'
                              : '"What if someone disassembles the wallet and accesses memory directly?"',
                          languageProvider.isKorean
                              ? '이 부분은 하드월렛이 강점을 가지는 영역입니다.\n많은 하드월렛 제조사들은 기기가 물리적으로 분해될 경우를 대비한 다양한 보안 장치를 내장하고 있습니다.\n\n하지만 스마트폰도 만만치 않습니다.\n대부분의 스마트폰에는 \'보안 엔클레이브(Secure Enclave)\' 또는 \'신뢰 실행 환경(TEE)\'이라는\n격리된 보안 영역이 탑재되어 있어, 민감한 데이터를 안전하게 보호할 수 있습니다.\n\n만약 니모닉 문구를 이 공간에 저장하고, 스마트폰을 오프라인 상태로 유지한다면,\n하드월렛에 버금가는 높은 보안 수준을 기대할 수 있습니다.'
                              : 'This is an area where hardware wallets have strengths.\nMany hardware wallet manufacturers have built-in various security devices to prepare for cases where the device is physically disassembled.\n\nBut smartphones are not to be underestimated either.\nMost smartphones are equipped with isolated security areas called \'Secure Enclave\' or \'Trusted Execution Environment (TEE)\'\nthat can safely protect sensitive data.\n\nIf you store mnemonic phrases in this space and keep your smartphone offline,\nyou can expect a high level of security comparable to hardware wallets.',
                          languageProvider.isKorean
                              ? '하드월렛이 더 적합하지만, 코코넛 볼트도 충분히 안전한 선택지가 될 수 있습니다.'
                              : 'Hardware wallets are more suitable, but offline smartphones can also be a sufficiently safe choice.',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"난수 생성기의 무작위성이 의심돼요."'
                              : '"I doubt the randomness of the random number generator."',
                          languageProvider.isKorean
                              ? '하드월렛은 보통 하드웨어 기반 난수 생성기(HWRNG/TRNG)를 내장하고 있어\n상대적으로 높은 수준의 무작위성을 제공합니다.\n반면, 스마트폰은 주로 소프트웨어 기반 난수 생성기(PRNG)를 사용하기 때문에\n운영체제나 앱 환경에 따라 예측 가능성이 높아질 수 있습니다.\n\n결론적으로, 무작위성만 놓고 본다면 하드월렛이 더 유리하다고 볼 수 있습니다.\n하지만 그보다 더 강력한 방법이 있죠.\n\n바로 직접 무작위값을 생성하는 것입니다.\n동전이나 주사위를 던져서 니모닉을 만드는 방식은\n기기에 의존하지 않고도 최상의 무작위성을 확보할 수 있는 방법입니다.'
                              : 'Hardware wallets usually have built-in hardware-based random number generators (HWRNG/TRNG)\nthat provide a relatively high level of randomness.\nOn the other hand, smartphones mainly use software-based random number generators (PRNG),\nso predictability can increase depending on the operating system or app environment.\n\nIn conclusion, in terms of randomness alone, hardware wallets can be seen as more advantageous.\nBut there\'s an even more powerful method.\n\nThat is generating random values directly.\nCreating mnemonics by flipping coins or rolling dice\nis a way to secure the best randomness without depending on devices.',
                          languageProvider.isKorean
                              ? '아무도 없는 곳에서 직접 동전을 던져보는건 어떨까요?'
                              : 'How about flipping a coin directly in a place where no one is around?',
                        ),
                        _buildDetailedExplanationBlock(
                          languageProvider.isKorean
                              ? '"좀 더 편리하고 쾌적하게 비트코인 지갑을 쓰고 싶어요."'
                              : '"I want to use a Bitcoin wallet more conveniently and comfortably."',
                          languageProvider.isKorean
                              ? '하드월렛 제조사가 아이폰이나 갤럭시처럼 선명한 화면, 고성능 카메라, 생체 인증 기능을 모두 갖춘 기기를 만든다면\n제작비가 크게 올라 현실적으로는 시장 경쟁력을 갖기 어렵습니다.\n그래서 대부분의 하드월렛은 기본적인 기능만을 갖춘 저사양 기기일 수밖에 없습니다.\n\n만약 크고 선명한 화면, 안전한 생체 인증, 편리한 카메라 기능이 필요하시다면\n더 고민하실 필요가 없습니다.\n오프라인 스마트폰을 비밀 사진첩, 패스워드 보관함, 일기장 등 프라이버시 중심의 기기로 활용해보세요.\n그 안에 비트코인을 보관하는 것도 충분히 훌륭한 선택이 될 수 있습니다.'
                              : 'If hardware wallet manufacturers made devices with all the features like clear screens, high-performance cameras, and biometric authentication like iPhones or Galaxies,\nmanufacturing costs would rise significantly, making it realistically difficult to have market competitiveness.\nThat\'s why most hardware wallets are inevitably low-spec devices with only basic functions.\n\nIf you need a large, clear screen, secure biometric authentication, and convenient camera functions,\nyou don\'t need to think about it anymore.\nUse an offline smartphone as a privacy-focused device like a secret photo album, password storage, or diary.\nStoring Bitcoin in it can also be an excellent choice.',
                          languageProvider.isKorean
                              ? '코코넛 볼트가 적합합니다.'
                              : 'A Coconut Vault is suitable.',
                        ),
                      ],
                    ),
                  ),
                ),

              // Target Users
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.vaultSurface,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean
                            ? '이런 분께 추천해요'
                            : 'Recommended for',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                      const SizedBox(height: 40),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildTargetUserCard(
                            '👶',
                            languageProvider.isKorean
                                ? '비트코인 입문자'
                                : 'Bitcoin Beginners',
                            languageProvider.isKorean
                                ? '비트코인을 처음으로 셀프 커스터디 하시려는 분'
                                : 'Those trying Bitcoin self-custody for the first time',
                          ),
                          _buildTargetUserCard(
                            '🚚',
                            languageProvider.isKorean
                                ? '배송이 급한 분'
                                : 'Need It Fast',
                            languageProvider.isKorean
                                ? '기나긴 하드웨어 월렛 해외 배송, 기다리기 싫으신 분'
                                : 'Don\'t want to wait for long international hardware wallet shipping',
                          ),
                          _buildTargetUserCard(
                            '🛫',
                            languageProvider.isKorean
                                ? '임시 금고 필요'
                                : 'Temporary Vault Needed',
                            languageProvider.isKorean
                                ? '여행 중, 긴급 상황에서 백업 키로 사용할 수 있는 임시 금고가 필요하신 분'
                                : 'Need a backup vault for travel or emergency situations',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // CTA Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean
                            ? '지금 바로 코코넛 볼트를 시작해보세요'
                            : 'Start using Coconut Vault right now',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        languageProvider.isKorean
                            ? '인터넷을 끊는 순간, 당신의 폰이 금고가 됩니다.'
                            : 'The moment you disconnect, your phone becomes a vault.',
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppTheme.vaultMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        languageProvider.isKorean
                            ? '설치부터 사용까지 단 3단계'
                            : 'Just 3 steps from installation to use',
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppTheme.vaultMuted,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CoconutButton(
                            text: languageProvider.isKorean
                                ? 'Android 지금 설치하기'
                                : 'Install for Android Now',
                            variant: CoconutButtonVariant.primary,
                            icon: LucideIcons.download,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          CoconutButton(
                            text: languageProvider.isKorean
                                ? 'iPhone 지금 설치하기'
                                : 'Install for iPhone Now',
                            variant: CoconutButtonVariant.outline,
                            icon: LucideIcons.download,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Wallet Integration
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.vaultSurface,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean
                            ? '코코넛 월렛과 함께 사용하세요'
                            : 'Use with Coconut Wallet',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(
                            child: CoconutCard(
                              child: Column(
                                children: [
                                  Container(
                                    height: 64,
                                    width: 64,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    child: const Icon(
                                      LucideIcons.smartphone,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    languageProvider.isKorean
                                        ? '코코넛 월렛'
                                        : 'Coconut Wallet',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.coconutBlack,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    languageProvider.isKorean
                                        ? '트랜잭션 생성 → PSBT'
                                        : 'Create transaction → PSBT',
                                    style: const TextStyle(
                                      color: AppTheme.vaultMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CoconutCard(
                              child: Column(
                                children: [
                                  Container(
                                    height: 64,
                                    width: 64,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.coconutBlack,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    child: const Icon(
                                      LucideIcons.shield,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    languageProvider.isKorean
                                        ? '코코넛 볼트'
                                        : 'Coconut Vault',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.coconutBlack,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    languageProvider.isKorean
                                        ? '오프라인 서명'
                                        : 'Offline signing',
                                    style: const TextStyle(
                                      color: AppTheme.vaultMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        languageProvider.isKorean
                            ? '코코넛 월렛은 트랜잭션을 만들고,'
                            : 'Coconut Wallet creates transactions,',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                      Text(
                        languageProvider.isKorean
                            ? '코코넛 볼트는 오프라인에서 안전하게 서명합니다.'
                            : 'Coconut Vault signs them safely offline.',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coconutBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.vaultSurface.withOpacity(0.5),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/coconut-logo.png',
                            height: 32,
                            width: 32,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Coconut',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: AppTheme.coconutBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        languageProvider.isKorean
                            ? '비트코인 셀프커스터디의 새로운 기준'
                            : 'A new standard for Bitcoin self-custody',
                        style: const TextStyle(
                          color: AppTheme.vaultMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSetupStep(IconData icon, String title, String description) {
    return Column(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: AppTheme.accentGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppTheme.accentGreen,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppTheme.coconutBlack,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            color: AppTheme.vaultMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  TableRow _buildComparisonRow(String category, String hardware, String vault) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.vaultSurface)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppTheme.coconutBlack,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            hardware,
            style: const TextStyle(
              color: AppTheme.vaultMuted,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            vault,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.accentGreen,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildTargetUserCard(String emoji, String title, String description) {
    return CoconutCard(
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppTheme.coconutBlack,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: AppTheme.vaultMuted,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedExplanationBlock(
      String quote, String explanation, String conclusion) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.coconutBlack.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 인용문
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.coconutBlack.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              quote,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: AppTheme.coconutBlack,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 설명
          Text(
            explanation,
            style: const TextStyle(
              fontSize: 7.5,
              color: AppTheme.coconutBlack,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          // 결론
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.arrowRight,
                  size: 16,
                  color: AppTheme.accentGreen,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    conclusion,
                    style: const TextStyle(
                      fontSize: 7.5,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentGreen,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreatItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 7,
                color: AppTheme.coconutBlack,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
