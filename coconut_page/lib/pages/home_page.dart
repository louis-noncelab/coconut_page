import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:coconut_page_flutter/animations/slide_up_animation.dart';
import 'package:coconut_page_flutter/widgets/shrink_animation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../providers/language_provider.dart';
import '../models/app_localizations.dart';
// import '../widgets/coconut_button.dart';
import '../widgets/coconut_card.dart';
import '../widgets/coconut_badge.dart';
import '../theme/app_theme.dart';
import '../utils/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isPinned = false;
  double _currentScrollOffset = 0.0; // 현재 스크롤 위치 저장

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final scrollOffset = _scrollController.offset;
    final shouldPin = scrollOffset <= 200;

    // 스크롤 위치가 변경되었을 때만 setState 호출
    if (_currentScrollOffset != scrollOffset || _isPinned != shouldPin) {
      setState(() {
        _currentScrollOffset = scrollOffset;
        _isPinned = shouldPin;
      });
    }
  }

  // 스크롤에 따른 bottom 값 계산
  double _calculateBottom(double originalBottom, double scrollOffset) {
    // ScrollController가 연결되지 않았으면 원래 위치 반환
    if (!_scrollController.hasClients) return originalBottom;

    const maxScroll = 300.0; // 최대 스크롤 거리
    final progress = (scrollOffset / maxScroll).clamp(0.0, 1.0);

    // 부드러운 곡선으로 0에 가까워지도록
    final easedProgress = Curves.easeOut.transform(progress);

    return originalBottom * (1 - easedProgress) + 30;
  }

  // 스크롤에 따른 left 값 계산 (왼쪽으로 이동)
  double _calculateLeft(double originalLeft, double scrollOffset) {
    if (!_scrollController.hasClients) return originalLeft;

    const leftMoveStart = 300.0; // left 이동이 시작되는 스크롤 위치
    final leftMoveEnd = MediaQuery.of(context).size.height + 30; // left 이동이 완료되는 스크롤 위치

    if (scrollOffset <= leftMoveStart) {
      // 아직 left 이동이 시작되지 않음
      return originalLeft;
    }

    // left 이동 진행률 계산
    final leftProgress = ((scrollOffset - leftMoveStart) / (leftMoveEnd - leftMoveStart)).clamp(0.0, 1.0);
    final easedLeftProgress = Curves.easeInOut.transform(leftProgress);

    // 왼쪽으로 이동 (음수 값)
    const leftMoveDistance = -150.0; // 왼쪽으로 이동할 거리
    return originalLeft + (leftMoveDistance * easedLeftProgress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          final l10n = AppLocalizations(languageProvider.currentLocale);

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Header
              SliverAppBar(
                backgroundColor: CoconutColors.white,
                forceElevated: true,
                elevation: 8,
                pinned: _isPinned,
                floating: true,
                shadowColor: Colors.black.withOpacity(0.3),
                surfaceTintColor: Colors.white,
                title: Row(
                  children: [
                    ShrinkAnimationButton(
                      pressedColor: CoconutColors.gray200,
                      borderRadius: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset('assets/svg/coconut-logo.svg', height: 36),
                      ),
                      onPressed: () {
                        final currentLocation = GoRouterState.of(context).uri.path;

                        if (currentLocation == AppRouter.home) {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          context.go(AppRouter.home);
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                actions: [
                  // Language Dropdown
                  PopupMenuButton<Locale>(
                    tooltip: 'Change language',
                    onSelected: (locale) => languageProvider.setLanguage(locale),
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    shadowColor: Colors.black,
                    itemBuilder: (context) => [
                      CheckedPopupMenuItem<Locale>(
                        value: const Locale('ko', 'KR'),
                        checked: languageProvider.isKorean,
                        child: const Text('한국어'),
                      ),
                      CheckedPopupMenuItem<Locale>(
                        value: const Locale('en', 'US'),
                        checked: languageProvider.isEnglish,
                        child: const Text('English'),
                      ),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Icon(Icons.language, color: AppTheme.textSecondary),
                          const SizedBox(width: 8),
                          Text(languageProvider.isKorean ? '한국어' : 'English', style: CoconutTypography.body2_14),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  CoconutLayout.spacing_400w,
                ],
              ),

              // Hero Section
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        CoconutColors.white,
                        CoconutColors.white,
                        CoconutColors.sky.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            left: _calculateLeft(MediaQuery.of(context).size.width / 2 - 1200, _currentScrollOffset),
                            bottom: _calculateBottom(20 + kToolbarHeight, _currentScrollOffset),
                            child: SlideUpAnimation(
                              delay: const Duration(milliseconds: 400),
                              child: Image.asset(
                                'assets/images/${languageProvider.isKorean ? '4' : '4-en'}.png',
                                width: 600,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            left: _calculateLeft(MediaQuery.of(context).size.width / 2 - 510, _currentScrollOffset),
                            bottom: _calculateBottom(-20, _currentScrollOffset),
                            child: SlideUpAnimation(
                              delay: const Duration(milliseconds: 200),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: CoconutColors.black, width: 4),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.asset('assets/images/${languageProvider.isKorean ? '1' : '1-en'}.png',
                                      height: MediaQuery.of(context).size.height / 2.5),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: _calculateLeft(MediaQuery.of(context).size.width / 2 - 270, _currentScrollOffset),
                            bottom: _calculateBottom(20, _currentScrollOffset),
                            child: SlideUpAnimation(
                              delay: const Duration(milliseconds: 600),
                              child: Image.asset(
                                'assets/images/${languageProvider.isKorean ? '5' : '5-en'}.png',
                                width: 600,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            left: _calculateLeft(MediaQuery.of(context).size.width / 2 + 390, _currentScrollOffset),
                            bottom: _calculateBottom(120, _currentScrollOffset),
                            child: SlideUpAnimation(
                              delay: const Duration(milliseconds: 800),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: CoconutColors.black, width: 4),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.asset('assets/images/${languageProvider.isKorean ? '2' : '2-en'}.png',
                                      height: MediaQuery.of(context).size.height / 2.5),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: _calculateLeft(MediaQuery.of(context).size.width / 2 + 660, _currentScrollOffset),
                            bottom: _calculateBottom(-30, _currentScrollOffset),
                            child: SlideUpAnimation(
                              delay: const Duration(milliseconds: 1000),
                              child: Image.asset(
                                'assets/images/${languageProvider.isKorean ? '6' : '6-en'}.png',
                                width: 600,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/svg/coconut-mainnet.svg', height: 60),
                            CoconutLayout.spacing_400h,
                            Text(
                              l10n.heroHeadline,
                              style: CoconutTypography.heading1_32_Bold
                                  .setColor(CoconutColors.black)
                                  .copyWith(fontSize: 64),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              l10n.heroSubtext,
                              style: CoconutTypography.heading3_21.setColor(CoconutColors.black),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 40),

                            // Hero CTAs
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShrinkAnimationButton(
                                  borderRadius: 12,
                                  border: Border.all(color: CoconutColors.gray200),
                                  defaultColor: CoconutColors.white,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Text(l10n.coconutWallet,
                                        style: CoconutTypography.heading3_21_Bold.setColor(CoconutColors.black)),
                                  ),
                                  onPressed: () => context.go(AppRouter.wallet),
                                ),
                                const SizedBox(width: 16),
                                ShrinkAnimationButton(
                                  borderRadius: 12,
                                  border: Border.all(color: CoconutColors.gray200),
                                  defaultColor: CoconutColors.white,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Text(l10n.coconutVault,
                                        style: CoconutTypography.heading3_21_Bold.setColor(CoconutColors.black)),
                                  ),
                                  onPressed: () => context.go(AppRouter.vault),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Product Cards Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: WalletCard(
                              child: Column(
                                children: [
                                  Container(
                                    height: 64,
                                    width: 64,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.coconutGreen,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      LucideIcons.eye,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.walletTitle,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.walletText,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    l10n.walletDesc,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppTheme.walletMuted,
                                          height: 1.5,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  CoconutButton(
                                    text: l10n.learnMore,
                                    // variant: CoconutButtonVariant.outline,
                                    onPressed: () => context.go(AppRouter.wallet),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: VaultCard(
                              child: Column(
                                children: [
                                  Container(
                                    height: 64,
                                    width: 64,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.coconutBrown,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      LucideIcons.laptop,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.vaultTitle,
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.vaultText,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    l10n.vaultDesc,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppTheme.vaultMuted,
                                          height: 1.5,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  CoconutButton(
                                    text: l10n.learnMore,
                                    // variant: CoconutButtonVariant.secondary,
                                    onPressed: () => context.go(AppRouter.vault),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Core Values Section
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.background.withOpacity(0.5),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        l10n.coreValuesTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                          _buildValueCard(context, l10n.value1, '1'),
                          _buildValueCard(context, l10n.value2, '2'),
                          _buildValueCard(context, l10n.value3, '3'),
                          _buildValueCard(context, l10n.value4, '4'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Open Source Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        l10n.openSourceTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.openSourceDesc,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                              height: 1.6,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      CoconutButton(
                        text: l10n.viewOnGithub,
                        // variant: CoconutButtonVariant.outline,
                        // icon: LucideIcons.github,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // Trust Section
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.background.withOpacity(0.5),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        l10n.trustTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.trustDesc,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                              height: 1.6,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.users,
                            color: AppTheme.textMuted,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '10,000+',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            languageProvider.isKorean ? '사용자' : 'Users',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textMuted,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // FAQ Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        l10n.faqTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 32),
                      ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          // Handle expansion
                        },
                        children: [
                          _buildFAQItem(context, l10n.faq1Q, l10n.faq1A, 0),
                          _buildFAQItem(context, l10n.faq2Q, l10n.faq2A, 1),
                          _buildFAQItem(context, l10n.faq3Q, l10n.faq3A, 2),
                          _buildFAQItem(context, l10n.faq4Q, l10n.faq4A, 3),
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
                        children: [
                          Image.asset(
                            'assets/images/coconut-logo.png',
                            height: 32,
                            width: 32,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Coconut',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        languageProvider.isKorean ? '비트코인 셀프커스터디의 새로운 기준' : 'A new standard for Bitcoin self-custody',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppTheme.textMuted,
                            ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        '© 2024 NonceLab. All rights reserved.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

  Widget _buildValueCard(BuildContext context, String text, String number) {
    return CoconutCard(
      child: Column(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.coconutGreen, AppTheme.coconutBrown],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  ExpansionPanel _buildFAQItem(BuildContext context, String question, String answer, int index) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          question,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Text(
          answer,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
        ),
      ),
      isExpanded: false,
    );
  }
}
