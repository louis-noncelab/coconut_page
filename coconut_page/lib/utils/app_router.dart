import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/wallet_page.dart';
import '../pages/vault_page.dart';
import '../pages/not_found_page.dart';

class AppRouter {
  static const String home = '/';
  static const String wallet = '/wallet';
  static const String vault = '/vault';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: wallet,
        name: 'wallet',
        builder: (context, state) => const WalletPage(),
      ),
      GoRoute(
        path: vault,
        name: 'vault',
        builder: (context, state) => const VaultPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
