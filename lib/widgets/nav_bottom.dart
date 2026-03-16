import 'package:flutter/material.dart';
import 'package:lets_play/screens/home/home_screen.dart';
import 'package:lets_play/screens/discover/discover_screen.dart';
import 'package:lets_play/screens/gameplay/gameplay_screen.dart';
import 'package:lets_play/screens/chat/chat_screen.dart';
import 'package:lets_play/screens/profile/profile_screen.dart';

class NavBottom extends StatefulWidget {
  const NavBottom({super.key});

  @override
  State<NavBottom> createState() => _NavBottomState();
}

class _NavBottomState extends State<NavBottom> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    DiscoverScreen(),
    GameplayScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Map of labels to handle indexing around the FAB
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.home_outlined, 'active': Icons.home, 'label': 'Game'},
      {'icon': Icons.explore_outlined, 'active': Icons.explore, 'label': 'Discover'},
      {'icon': Icons.chat_bubble_outline, 'active': Icons.chat_bubble, 'label': 'Chat'},
      {'icon': Icons.person_outline, 'active': Icons.person, 'label': 'Me'},
    ];

    return Scaffold(
      extendBody: true, // Allows content to be behind the bottom bar
      body: _screens[_currentIndex],
      floatingActionButton: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFE6B8B), Color(0xFFFF8E53)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFE6B8B).withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 2; // Gameplay center
            });
          },
          elevation: 0,
          highlightElevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Home
            _buildNavItem(0, items[0]),
            // Discover
            _buildNavItem(1, items[1]),
            
            const SizedBox(width: 40), // Space for FAB
            
            // Chat
            _buildNavItem(3, items[2]),
            // Profile
            _buildNavItem(4, items[3]),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, Map<String, dynamic> item) {
    final bool isSelected = _currentIndex == index;
    final Color color = isSelected ? const Color(0xFFFE4C71) : const Color(0xFF94A3B8);

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (index == 1 && isSelected)
              // Specific style for Discover active like in mockup
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFE4C71),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.explore, color: Colors.white, size: 24),
              )
            else
              Icon(
                isSelected ? item['active'] : item['icon'],
                color: color,
                size: 28,
              ),
            const SizedBox(height: 4),
            Text(
              item['label'],
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
