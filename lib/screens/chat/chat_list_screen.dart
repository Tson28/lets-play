import 'package:flutter/material.dart';
import 'package:lets_play/screens/chat/chat_detail_screen.dart';
import 'package:lets_play/screens/chat/widgets/chat_item.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF7F8), // Very light pinkish white
      body: SafeArea(
        child: Column(
          children: [
            // 1. Header
            _buildHeader(),
            
            // 2. Search Bar
            _buildSearchBar(),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    
                    // 3. Online Now Area
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "ONLINE NOW",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20),
                        children: [
                          _buildStoryItem(context, "My Story", null, isMine: true),
                          _buildStoryItem(context, "Mai Linh", null, isOnline: true, color: Colors.blue),
                          _buildStoryItem(context, "Nguyễn Hằng.", null, isOnline: true, color: Colors.green),
                          _buildStoryItem(context, "Sarah Le", null, color: Colors.purple),
                          _buildStoryItem(context, "Kevin", null, color: Colors.orange),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // 4. Recent Chats Area
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "RECENT CHATS",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF94A3B8),
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          ChatItem(
                            name: "Nguyễn Hằng",
                            lastMessage: "nhớ em không? 😘",
                            time: "2m",
                            unreadCount: 1,
                            isOnline: true,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatDetailScreen(
                                  name: "Nguyễn Hằng",
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          ChatItem(
                            name: "Khánh Huyền",
                            lastMessage: "Em nhớ anh lắm luôn đó!  🥰",
                            time: "1h",
                            isOnline: true,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatDetailScreen(
                                  name: "Khánh Huyền",
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                          ChatItem(
                            name: "Tet Party Squad 🧧",
                            lastMessage: "Minh: Who has the lucky money?",
                            time: "Yesterday",
                            unreadCount: 3,
                            isGroup: true,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatDetailScreen(
                                  name: "Tet Party Squad 🧧",
                                ),
                              ),
                            ),
                          ),
                          ChatItem(
                            name: "David Tran",
                            lastMessage: "See you at the fireworks show!",
                            time: "Tue",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatDetailScreen(
                                  name: "David Tran",
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ),
                          ChatItem(
                            name: "Thành Đạt",
                            lastMessage: "Tài xỉu không !",
                            time: "Tue",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatDetailScreen(
                                  name: "Thành Đạt",
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 100), // Bottom padding
                        ],
                      ),
                    ),
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
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chats",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Lunar New Year Event",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF4C71).withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text("🧧", style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
              ],
            ),
            child: const Icon(Icons.add, color: Color(0xFFFF4C71), size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFFFF4C71), size: 24),
            const SizedBox(width: 15),
            Text(
              "Search friends & groups...",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF94A3B8).withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryItem(BuildContext context, String name, String? imagePath, {bool isMine = false, bool isOnline = false, Color? color}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: isMine
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(
                    name: name,
                    color: color,
                  ),
                ),
              );
            },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isOnline ? const Color(0xFFFF4C71) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color ?? Colors.blueGrey[100],
                      image: imagePath != null ? DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover) : null,
                    ),
                    child: imagePath == null
                        ? Center(
                            child: Text(name[0],
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          )
                        : null,
                  ),
                ),
                if (isMine)
                  Positioned(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(Icons.add_circle, color: Color(0xFFFF4C71), size: 24),
                    ),
                  ),
                if (isOnline && !isMine)
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
