import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../providers/language_provider.dart';
import '../widgets/coconut_button.dart';
import '../widgets/coconut_card.dart';
import '../theme/app_theme.dart';
import '../utils/app_router.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return CustomScrollView(
            slivers: [
              // Header
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: Colors.white.withOpacity(0.95),
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
                        color: AppTheme.textPrimary,
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
                              ? AppTheme.coconutGreen
                              : AppTheme.textMuted,
                        ),
                        child: const Text('한국어'),
                      ),
                      TextButton(
                        onPressed: () => languageProvider.setLanguage(
                          const Locale('en', 'US'),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: languageProvider.isEnglish
                              ? AppTheme.coconutGreen
                              : AppTheme.textMuted,
                        ),
                        child: const Text('English'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  // Download Button
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CoconutButton(
                      text:
                          languageProvider.isKorean ? '앱 다운로드' : 'Download App',
                      variant: CoconutButtonVariant.outline,
                      icon: LucideIcons.smartphone,
                      onPressed: () {
                        // TODO: Add download link
                      },
                    ),
                  ),
                ],
              ),

              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.walletBg,
                        Color(0xFFE8F5E8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: AppTheme.coconutGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            LucideIcons.eye,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          languageProvider.isKorean
                              ? '코코넛 월렛'
                              : 'Coconut Wallet',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.walletText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          languageProvider.isKorean
                              ? '빠르고, 신뢰받고, 투명한 비트코인 와치온리 지갑'
                              : 'Fast, Trusted, and Transparent Bitcoin Watch-Only Wallet',
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppTheme.coconutGreen,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          languageProvider.isKorean
                              ? '스마트폰으로 안전하게 자산을 모니터링하고, PSBT로 서명 기기를 분리해 더 안전하게 관리하세요.'
                              : 'Safely monitor your assets on your smartphone and manage them more securely by separating signing devices with PSBT.',
                          style: const TextStyle(
                            fontSize: 8,
                            color: AppTheme.walletMuted,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Hero CTAs
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CoconutButton(
                              text: languageProvider.isKorean
                                  ? '안드로이드 다운로드'
                                  : 'Download for Android',
                              variant: CoconutButtonVariant.outline,
                              icon: LucideIcons.smartphone,
                              onPressed: () {
                                // TODO: Add Android download link
                              },
                            ),
                            const SizedBox(width: 16),
                            CoconutButton(
                              text: languageProvider.isKorean
                                  ? '아이폰 다운로드'
                                  : 'Download for iPhone',
                              variant: CoconutButtonVariant.ghost,
                              icon: LucideIcons.smartphone,
                              onPressed: () {
                                // TODO: Add iOS download link
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Key Features Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean ? '핵심 기능' : 'Key Features',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
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
                          _buildFeatureCard(
                            LucideIcons.zap,
                            languageProvider.isKorean
                                ? '빠른 동기화 속도'
                                : 'Fast Synchronization',
                            languageProvider.isKorean
                                ? '최적화된 동기화 엔진으로 블록체인 데이터를 빠르게 불러와 대기 시간을 최소화합니다.'
                                : 'Optimized sync engine quickly loads blockchain data to minimize waiting time.',
                          ),
                          _buildFeatureCard(
                            LucideIcons.users,
                            languageProvider.isKorean
                                ? '검증된 사용자 리뷰'
                                : 'Verified User Reviews',
                            languageProvider.isKorean
                                ? '실제 비트코이너들의 긍정적인 리뷰와 피드백을 통해 검증된 신뢰성을 확인하세요.'
                                : 'Proven reliability through positive reviews and feedback from real Bitcoiners.',
                          ),
                          _buildFeatureCard(
                            LucideIcons.github,
                            languageProvider.isKorean
                                ? '완전 오픈소스'
                                : 'Fully Open Source',
                            languageProvider.isKorean
                                ? '모든 소스코드가 공개되어 누구나 감사하고 검증할 수 있어 투명성을 보장합니다.'
                                : 'All source code is public, allowing anyone to audit and verify for complete transparency.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Reviews Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean ? '사용자 리뷰' : 'User Reviews',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        languageProvider.isKorean
                            ? '실제 비트코이너들이 남긴 솔직한 후기'
                            : 'Honest feedback from real Bitcoiners',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppTheme.textSecondary,
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
                          _buildReviewCard(
                            languageProvider.isKorean
                                ? '동기화 속도가 정말 빠르고 UI가 깔끔해서 매일 사용하고 있어요. 특히 PSBT 연동이 편리합니다.'
                                : 'The sync speed is really fast and the UI is clean. I use it daily, especially love the PSBT integration.',
                            languageProvider.isKorean ? '김비트코인' : 'BitcoinKim',
                            languageProvider.isKorean
                                ? '비트코인 트레이더'
                                : 'Bitcoin Trader',
                          ),
                          _buildReviewCard(
                            languageProvider.isKorean
                                ? '오픈소스라서 안심이 되고, 개발팀의 업데이트도 활발해서 믿고 쓰고 있습니다.'
                                : 'Feel safe because it\'s open source, and the dev team\'s updates are active. Trust and use it.',
                            languageProvider.isKorean
                                ? '박셀프커스터디'
                                : 'SelfCustodyPark',
                            languageProvider.isKorean ? '개발자' : 'Developer',
                          ),
                          _buildReviewCard(
                            languageProvider.isKorean
                                ? '하드웨어 월렛과 연동해서 쓰는데 정말 편해요. 안전하면서도 사용성이 좋습니다.'
                                : 'Really convenient when connected with hardware wallet. Safe yet user-friendly.',
                            languageProvider.isKorean ? '이HODL' : 'HODLLee',
                            languageProvider.isKorean
                                ? '장기 투자자'
                                : 'Long-term Investor',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Technical Features
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.background.withOpacity(0.5),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean
                            ? '기술적 특징'
                            : 'Technical Features',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 40),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildTechFeature(
                            LucideIcons.eye,
                            languageProvider.isKorean
                                ? '와치온리 모니터링'
                                : 'Watch-Only Monitoring',
                            languageProvider.isKorean
                                ? '개인키 없이 안전하게 잔액과 거래내역을 확인'
                                : 'Safely check balances and transaction history without private keys',
                          ),
                          _buildTechFeature(
                            LucideIcons.shield,
                            languageProvider.isKorean
                                ? 'PSBT 통합'
                                : 'PSBT Integration',
                            languageProvider.isKorean
                                ? '부분 서명된 비트코인 거래로 하드웨어 월렛과 완벽 연동'
                                : 'Perfect integration with hardware wallets via Partially Signed Bitcoin Transactions',
                          ),
                          _buildTechFeature(
                            LucideIcons.zap,
                            languageProvider.isKorean
                                ? '라이트닝 지원'
                                : 'Lightning Support',
                            languageProvider.isKorean
                                ? '온체인과 라이트닝 네트워크 거래 모두 모니터링'
                                : 'Monitor both on-chain and Lightning Network transactions',
                          ),
                          _buildTechFeature(
                            LucideIcons.lock,
                            languageProvider.isKorean
                                ? '프라이버시 보호'
                                : 'Privacy Protection',
                            languageProvider.isKorean
                                ? '로컬 데이터 저장으로 개인정보 보호 최적화'
                                : 'Optimized privacy protection with local data storage',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Download Section
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.background.withOpacity(0.5),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        languageProvider.isKorean
                            ? '지금 다운로드하고 시작하세요'
                            : 'Download Now and Get Started',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        languageProvider.isKorean
                            ? '몇 분 안에 설정을 완료하고 안전한 비트코인 관리를 경험해보세요.'
                            : 'Complete setup in minutes and experience safe Bitcoin management.',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppTheme.textSecondary,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CoconutButton(
                            text: languageProvider.isKorean
                                ? '안드로이드 다운로드'
                                : 'Download for Android',
                            variant: CoconutButtonVariant.primary,
                            icon: LucideIcons.smartphone,
                            onPressed: () {
                              // TODO: Add Android download link
                            },
                          ),
                          const SizedBox(width: 16),
                          CoconutButton(
                            text: languageProvider.isKorean
                                ? '아이폰 다운로드'
                                : 'Download for iPhone',
                            variant: CoconutButtonVariant.outline,
                            icon: LucideIcons.smartphone,
                            onPressed: () {
                              // TODO: Add iOS download link
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.background.withOpacity(0.1),
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
                              color: AppTheme.textPrimary,
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
                          color: AppTheme.textMuted,
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

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return CoconutCard(
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: const BoxDecoration(
              color: AppTheme.coconutGreen,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String review, String author, String role) {
    return CoconutCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
                5,
                (index) => const Icon(
                      LucideIcons.star,
                      color: AppTheme.coconutGreen,
                      size: 16,
                    )),
          ),
          const SizedBox(height: 16),
          Text(
            '"$review"',
            style: const TextStyle(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: AppTheme.coconutGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    author[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 6,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechFeature(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 32,
          width: 32,
          decoration: const BoxDecoration(
            color: AppTheme.coconutGreen,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 7,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
