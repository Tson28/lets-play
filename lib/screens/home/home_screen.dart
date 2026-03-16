import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              // 1. Header
              _buildHeader(),
              
              const SizedBox(height: 25),
              
              // 2. Main Lucky Spin Banner
              _buildLuckySpinBanner(),
              
              const SizedBox(height: 30),
              
              // 3. Featured Games Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                     children: [
                       const Icon(Icons.sports_esports, color: Color(0xFFFE4C71)),
                       const SizedBox(width: 8),
                       const Text(
                         "Trò Chơi Nổi Bật",
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.w900,
                           color: Color(0xFF1E293B),
                         ),
                       ),
                     ],
                   ),
                   Text(
                     "Xem tất cả",
                     style: TextStyle(
                       fontSize: 13,
                       fontWeight: FontWeight.w600,
                       color: Colors.blueGrey.withOpacity(0.6),
                     ),
                   ),
                ],
              ),
              
              const SizedBox(height: 15),
              
              // Game Grid (2x2)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.82,
                children: [
                  _buildGameCard("Memory Flip", "Luyện trí nhớ siêu phàm", "static_assets/images/game_memory.png", const Color(0xfffce4ea)),
                _buildGameCard("Riddle Master", "Giải đố hại não", "static_assets/images/game_riddle.png", const Color(0xffe0f7fa)),
                _buildGameCard("Quick Draw", "Họa sĩ tài ba", "static_assets/images/game_quick_draw.png", const Color(0xfffff3e0)),
                _buildGameCard("2048", "Thử thách ghép số", "static_assets/images/game_2048.png", const Color(0xfff1f8e9)),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // 4. Tet Tradition Games Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B0000), Color(0xFFE44D26)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "MỚI",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Vui Xuân Đón Tết",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Trò chơi dân gian ngày Tết",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildTetGameItem("Bầu Cua", "1.2k đang chơi", "static_assets/images/bau_cua.png")),
                        const SizedBox(width: 15),
                        Expanded(child: _buildTetGameItem("Xóc Đĩa", "3.5k đang chơi", "static_assets/images/xoc_dia.png")),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.blueGrey[100],
                  child: const Icon(Icons.person, color: Colors.blueGrey),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Xin chào,",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "Minh Anh!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.orange, size: 20),
              SizedBox(width: 6),
              Text(
                "12,500",
                style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLuckySpinBanner() {
    return Container(
      width: double.infinity,
      height: 240, // Increased height more to be safe
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: const LinearGradient(
          colors: [Color(0xFFFE6B8B), Color(0xFFFF8E53)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFE6B8B).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 15,
            bottom: 20,
            top: 20,
            width: 140,
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                'static_assets/images/lucky_spin.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stars, color: Colors.yellow, size: 14),
                      SizedBox(width: 4),
                      Text(
                        "SỰ KIỆN TẾT",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Vòng Quay",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1),
                ),
                const Text(
                  "May Mắn",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.yellow, height: 1.1),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 160,
                  child: Text(
                    "Thử vận may đầu năm, rinh ngay lì xì khủng!",
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.rotate_right, color: Color(0xFFFE4C71), size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Quay Ngay",
                        style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFFE4C71)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(String title, String subtitle, String? imagePath, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                child: imagePath != null 
                  ? Image.asset(imagePath, fit: BoxFit.cover)
                  : _buildFallbackImage(title),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: Colors.blueGrey.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTetGameItem(String title, String players, String? imagePath) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (imagePath != null)
             ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
             ),
          Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               color: Colors.black.withOpacity(0.4),
             ),
          ),
          Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Icon(
                 title == "Bầu Cua" ? Icons.casino_outlined : Icons.monetization_on_outlined,
                 color: Colors.white70,
                 size: 24,
               ),
               const SizedBox(height: 8),
               Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
               const SizedBox(height: 4),
               Text(players, style: const TextStyle(color: Colors.white70, fontSize: 10)),
             ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackImage(String title) {
    if (title == "2048") {
      return Container(
        color: const Color(0xFFEDC22E),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "2048",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              Icon(Icons.grid_4x4, color: Colors.white70, size: 24),
            ],
          ),
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sports_esports, size: 40, color: Colors.blueGrey[200]),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: Colors.blueGrey[300], fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
