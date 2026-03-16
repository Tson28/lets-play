import 'package:flutter/material.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text(
          "Đội Ngũ Phát Triển",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF334155)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Logo hoặc Hình minh họa
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        size: 80,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "LET'S PLAY TEAM",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Member 1: Trưởng nhóm
                  _buildMemberCard(
                    context,
                    name: "Nguyễn Thái Sơn",
                    id: "23010196",
                    role: "Trưởng nhóm / Lead Developer",
                    icon: Icons.stars_rounded,
                    accentColor: Colors.orangeAccent,
                  ),

                  const SizedBox(height: 20),

                  // Member 2
                  _buildMemberCard(
                    context,
                    name: "Lê Phạm Thành Đạt",
                    id: "23010541",
                    role: "Fullstack Developer / UI Designer",
                    icon: Icons.code_rounded,
                    accentColor: Colors.blueAccent,
                  ),

                  const SizedBox(height: 50),
                  const Text(
                    "Version 1.0.0 • Made with ❤️ by Students",
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(
    BuildContext context, {
    required String name,
    required String id,
    required String role,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: accentColor, size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "MSSV: $id",
                  style: TextStyle(
                    fontSize: 14,
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  role,
                  style: const TextStyle(fontSize: 13, color: Colors.white60),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
