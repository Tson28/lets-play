import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF381024), // Dark Burgundy
      body: Stack(
        children: [
          // Background Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  const Color(0xFF581238).withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Top Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Row(
                        children: [
                          _buildCircleButton(Icons.notifications_outlined),
                          const SizedBox(width: 12),
                          _buildCircleButton(Icons.settings_outlined),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Profile Header
                  _buildProfileHeader(),
                  
                  const SizedBox(height: 30),
                  
                  // Stats Row
                  Row(
                    children: [
                      Expanded(child: _buildStatBox("12.5k", "COINS", Icons.monetization_on, Colors.yellow)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatBox("540", "GEMS", Icons.diamond, Colors.purpleAccent)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatBox("8", "Lì xì", Icons.mail, Colors.redAccent)),
                    ],
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Fortune Wheel Banner
                  _buildPromotionBanner(),
                  
                  const SizedBox(height: 30),
                  
                  // My Gift Bag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "My Gift Bag",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 15),
                  
                  Row(
                    children: [
                      Expanded(child: _buildGiftItem("Firecracker", "x3", Icons.whatshot, Colors.orange)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildGiftItem("Bánh Chưng", "x12", Icons.eco, Colors.green)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildGiftItem("Lantern", "x5", Icons.lightbulb, Colors.amber)),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Settings List
                  _buildSettingsList(),
                  
                  const SizedBox(height: 40),
                  
                  Text(
                    "Version 2.4.0 (Build 108)",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.2),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 100), // Bottom padding for NavBottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.pinkAccent],
                ),
              ),
              child: CircleAvatar(
                radius: 65,
                backgroundColor: const Color(0xFF381024),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blueGrey[200],
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.emoji_events, size: 14, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(
                    "Level 15",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "NguyenVanA",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Grandmaster • VIP Member",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(String val, String label, IconData icon, Color iconCol) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconCol, size: 28),
          const SizedBox(height: 10),
          Text(
            val,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.4),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionBanner() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xFFFE6B8B), Color(0xFFFF8E53)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Pattern Overlay (Visual representation of local assets)
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'static_assets/images/tet_pattern.png',
                repeat: ImageRepeat.repeat,
                fit: BoxFit.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "DAILY",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Fortune Wheel",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Spin now to win exclusive Tet rewards!",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                  ),
                  child: const Icon(Icons.casino, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftItem(String name, String qty, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            qty,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          _buildSettingsItem(Icons.language, "Language", hasTrailing: true),
          Divider(color: Colors.white.withOpacity(0.05), height: 1),
          _buildSettingsItem(Icons.person_outline, "Edit Profile"),
          Divider(color: Colors.white.withOpacity(0.05), height: 1),
          _buildSettingsItem(Icons.volume_up_outlined, "Sound & Haptics", isSwitch: true),
          Divider(color: Colors.white.withOpacity(0.05), height: 1),
          _buildSettingsItem(Icons.help_outline, "Help & Support"),
          Divider(color: Colors.white.withOpacity(0.05), height: 1),
          _buildSettingsItem(Icons.logout, "Log Out", isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, {bool hasTrailing = false, bool isSwitch = false, bool isDestructive = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red.withOpacity(0.2) : Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isDestructive ? Colors.redAccent : Colors.white70, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: isSwitch 
        ? Switch(value: true, onChanged: (v){}, activeColor: Colors.pinkAccent)
        : hasTrailing 
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                 const Icon(Icons.flag, color: Colors.blue, size: 16),
                 const SizedBox(width: 8),
                 Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
              ],
            )
          : Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
      onTap: () {},
    );
  }
}
