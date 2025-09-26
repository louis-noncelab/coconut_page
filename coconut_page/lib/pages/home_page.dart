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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                backgroundColor: Colors.white.withOpacity(0.95),
                elevation: 0,
                title: Row(
                  children: [
                    Image.asset('assets/images/coconut_logo.png', height: 32),
                    const SizedBox(width: 8),
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
                              ? AppTheme.accentOrange
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
                              ? AppTheme.accentOrange
                              : AppTheme.textMuted,
                        ),
                        child: const Text('English'),
                      ),
                      const SizedBox(width: 8),
                    ],
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
                        Color(0xFFF8F9FA),
                        Color(0xFFE8F5E8),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 80, horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          l10n.heroHeadline,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          l10n.heroSubtext,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textSecondary,
                                    height: 1.6,
                                  ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 40),

                        // Hero CTAs
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CoconutButton(
                              text: l10n.coconutWallet,
                              variant: CoconutButtonVariant.wallet,
                              icon: LucideIcons.smartphone,
                              onPressed: () => context.go(AppRouter.wallet),
                            ),
                            const SizedBox(width: 16),
                            CoconutButton(
                              text: l10n.coconutVault,
                              variant: CoconutButtonVariant.vault,
                              icon: LucideIcons.lock,
                              onPressed: () => context.go(AppRouter.vault),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Badges
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            OutlineBadge(
                              text: l10n.openSource,
                              icon: LucideIcons.shield,
                              color: AppTheme.coconutGreen,
                            ),
                            OutlineBadge(
                              text: l10n.bitcoinOnly,
                              icon: LucideIcons.bitcoin,
                              color: AppTheme.coconutBrown,
                            ),
                            OutlineBadge(
                              text: '1.2k',
                              icon: LucideIcons.github,
                              color: AppTheme.coconutBlue,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.walletText,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    l10n.walletDesc,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppTheme.walletMuted,
                                          height: 1.5,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  CoconutButton(
                                    text: l10n.learnMore,
                                    variant: CoconutButtonVariant.outline,
                                    onPressed: () =>
                                        context.go(AppRouter.wallet),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.vaultText,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    l10n.vaultDesc,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppTheme.vaultMuted,
                                          height: 1.5,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  CoconutButton(
                                    text: l10n.learnMore,
                                    variant: CoconutButtonVariant.secondary,
                                    onPressed: () =>
                                        context.go(AppRouter.vault),
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
                        variant: CoconutButtonVariant.outline,
                        icon: LucideIcons.github,
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
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            languageProvider.isKorean ? '사용자' : 'Users',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
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

  ExpansionPanel _buildFAQItem(
      BuildContext context, String question, String answer, int index) {
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
