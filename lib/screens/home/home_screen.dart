import 'package:flutter/material.dart';
import 'package:lets_play/screens/gameplay/tai_xiu_screen.dart';
import 'package:lets_play/screens/home/widgets/event_banner.dart';
import 'package:lets_play/screens/home/widgets/lucky_wheel_card.dart';
import 'package:lets_play/screens/home/widgets/game_card.dart';
import 'package:lets_play/screens/home/widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.sports_esports, size: 32, color: Color(0xFF6B48FF)),
                        SizedBox(width: 12),
                        Text(
                          "Trang chủ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B48FF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Chào mừng bạn đến với Let's Play!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const EventBanner(
                title: "Sự kiện đặc biệt",
                subtitle: "Tham gia ngay để nhận quà hấp dẫn!",
                icon: Icons.celebration_rounded,
              ),
              const LuckyWheelCard(),
              const SizedBox(height: 20),
              const SectionTitle(
                title: "Game nổi bật",
                actionText: "Xem tất cả",
              ),
              const SizedBox(height: 12),
              GameCard(
                title: "Tài Xỉu Tết",
                subtitle: "Giao diện Tết, tỉ lệ thắng ~35%",
                icon: Icons.casino_rounded,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const TaiXiuScreen(),
                    ),
                  );
                },
              ),
              const GameCard(
                title: "Game hot 2",
                subtitle: "Thử thách mới mỗi ngày",
                icon: Icons.local_fire_department_rounded,
              ),
              const GameCard(
                title: "Game hot 3",
                subtitle: "Cùng bạn bè chơi vui",
                icon: Icons.group_rounded,
              ),
              const SizedBox(height: 24),
              const SectionTitle(
                title: "Game phổ biến",
                actionText: "Xem tất cả",
              ),
              const SizedBox(height: 12),
              const GameCard(
                title: "Game 1",
                subtitle: "Mô tả game 1",
              ),
              const GameCard(
                title: "Game 2",
                subtitle: "Mô tả game 2",
              ),
              const GameCard(
                title: "Game 3",
                subtitle: "Mô tả game 3",
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
