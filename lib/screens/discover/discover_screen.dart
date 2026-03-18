import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // 2. Tet Festival Section
                    _buildSectionHeader("Tet Festival 2026", true),
                    const SizedBox(height: 15),
                    _buildEventCard(
                      "Lucky Money Hunt",
                      "Win big prizes in our daily red envelope hunt!",
                      "EVENT",
                      null, // Local decoration instead
                    ),

                    const SizedBox(height: 30),

                    // 3. New Friends Section
                    _buildSectionHeader("New Friends", false),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 110,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildFriendItem("Linh Nhi", Colors.blue[100]!),
                          _buildFriendItem("Minh Tuan", Colors.green[100]!),
                          _buildFriendItem("Sarah", Colors.purple[100]!),
                          _buildFriendItem("Dave", Colors.orange[100]!),
                          _buildFriendItem("Anna", Colors.pink[100]!),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 4. Hot Voice Rooms Section
                    Row(
                      children: [
                        const Text(
                          "Hot Voice Rooms",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.whatshot,
                          color: Colors.orange,
                          size: 24,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.tune,
                            size: 18,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    _buildRoomCard(
                      "Hanoi Gamers Chill 🎮",
                      "Join us for a quick Werewolf game! Newbies welcome.",
                      "WEREWOLF",
                      "#TETVIBES",
                      342,
                      Colors.blue,
                    ),

                    const SizedBox(height: 15),

                    _buildRoomCard(
                      "Hỏi xoáy đáp xoay 🎙️",
                      "Phòng tám chuyện đêm khuya, giải đáp thắc mắc.",
                      "TALK SHOW",
                      "#CHILLING",
                      128,
                      Colors.green,
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.sports_esports,
              color: Color(0xFFFF6B6B),
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            "Let's Play",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search, size: 26, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  size: 26,
                  color: Color(0xFF64748B),
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool showSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
          ),
        ),
        if (showSeeAll)
          const Text(
            "See All",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF4C71),
            ),
          ),
      ],
    );
  }

  Widget _buildEventCard(
    String title,
    String subtitle,
    String tag,
    String? imagePath,
  ) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF1E293B),
        image: imagePath != null
            ? DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover)
            : null,
        gradient: imagePath == null
            ? const LinearGradient(
                colors: [Color(0xFFFE4C71), Color(0xFF580345)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
      ),
      child: Stack(
        children: [
          if (imagePath == null)
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.local_florist,
                color: Colors.white.withOpacity(0.1),
                size: 150,
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4C71),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Icon(
              Icons.arrow_circle_right,
              color: Colors.white.withOpacity(0.5),
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendItem(String name, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFF4C71), width: 2),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: bgColor,
                  child: Text(
                    name[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4C71),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(
    String title,
    String desc,
    String tag1,
    String tag2,
    int users,
    Color hostColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSmallTag(
                tag1,
                const Color(0xFFF1E6FF),
                const Color(0xFF8B5CF6),
              ),
              const SizedBox(width: 8),
              _buildSmallTag(
                tag2,
                const Color(0xFFFFF7ED),
                const Color(0xFFF59E0B),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.group, size: 18, color: Color(0xFF94A3B8)),
                  const SizedBox(width: 4),
                  Text(
                    users.toString(),
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: hostColor,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4C71),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "HOST",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        _buildMiniAvatars(),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF1F2),
                            foregroundColor: const Color(0xFFFF4C71),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: const Text(
                            "Join",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTag(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: text,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMiniAvatars() {
    return SizedBox(
      width: 80,
      height: 30,
      child: Stack(
        children:
            List.generate(
              3,
              (i) => Positioned(
                left: i * 18.0,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: i % 2 == 0
                      ? null
                      : const AssetImage(
                          'static_assets/images/tet_pattern.png',
                        ),
                  backgroundColor:
                      Colors.blueGrey[100 * (i + 1) % 900] ?? Colors.blueGrey,
                  child: i % 2 == 0
                      ? Text(
                          (i + 1).toString(),
                          style: const TextStyle(fontSize: 10),
                        )
                      : null,
                ),
              ),
            )..add(
              Positioned(
                left: 3 * 18.0,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFFF1F5F9),
                  child: const Text(
                    "+8",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
