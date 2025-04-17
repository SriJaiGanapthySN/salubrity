import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssalubrity/screens/ebook_screen.dart';
import 'package:ssalubrity/screens/home_page.dart';
import 'package:ssalubrity/screens/music_player_screen.dart';
import 'package:ssalubrity/screens/video_player_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salubrity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7E57C2),
          primary: const Color(0xFF7E57C2),
          secondary: const Color(0xFFB39DDB),
          tertiary: const Color(0xFF5E35B1),
          background: const Color(0xFFF5F5F7),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF7E57C2),
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const MentalHealthHomePage(),
    const MusicPlayerScreen(),
    const VideoPlayerScreen(),
    const EbookScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              activeIcon: Icon(Icons.home_rounded, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note_rounded),
              activeIcon: Icon(Icons.music_note_rounded, size: 28),
              label: 'Music',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_rounded),
              activeIcon: Icon(Icons.video_library_rounded, size: 28),
              label: 'Videos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_rounded),
              activeIcon: Icon(Icons.book_rounded, size: 28),
              label: 'Ebooks',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
