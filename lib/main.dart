import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'screens/dictionary_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/translation_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider()..init(),
      child: const SignoTextApp(),
    ),
  );
}

class SignoTextApp extends StatelessWidget {
  const SignoTextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) => MaterialApp(
        title: 'SignoText',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: provider.themeMode,
        home: const MainShell(),
      ),
    );
  }
}

/// Coquille principale avec bottom navigation bar
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _goToTranslation() => setState(() => _currentIndex = 1);

  List<Widget> get _screens => [
        HomeScreen(onGoToTranslation: _goToTranslation),
        const TranslationScreen(),
        const HistoryScreen(),
        const FavoritesScreen(),
        const DictionaryScreen(),
        const SettingsScreen(),
      ];

  static const _navItems = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Accueil',
    ),
    NavigationDestination(
      icon: Icon(Icons.translate_outlined),
      selectedIcon: Icon(Icons.translate_rounded),
      label: 'Traduire',
    ),
    NavigationDestination(
      icon: Icon(Icons.history_outlined),
      selectedIcon: Icon(Icons.history_rounded),
      label: 'Historique',
    ),
    NavigationDestination(
      icon: Icon(Icons.star_outline_rounded),
      selectedIcon: Icon(Icons.star_rounded),
      label: 'Favoris',
    ),
    NavigationDestination(
      icon: Icon(Icons.menu_book_outlined),
      selectedIcon: Icon(Icons.menu_book_rounded),
      label: 'Dictionnaire',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings_rounded),
      label: 'Paramètres',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: _navItems,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 68,
      ),
    );
  }
}
