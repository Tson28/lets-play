import 'package:flutter/material.dart';

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
                          _buildStoryItem("My Story", null, isMine: true),
                          _buildStoryItem("Mai Linh", null, isOnline: true, color: Colors.blue),
                          _buildStoryItem("Tuan N.", null, isOnline: true, color: Colors.green),
                          _buildStoryItem("Sarah Le", null, color: Colors.purple),
                          _buildStoryItem("Kevin", null, color: Colors.orange),
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
                          
                          _buildChatItem(
                            "Tuan Nguyen",
                            "Are we playing Bau Cua tonight?",
                            "2m",
                            null,
                            color: Colors.green,
                            unread: 1,
                            online: true,
                          ),
                          _buildChatItem(
                            "Mai Linh",
                            "Happy New Year! sent you a gift.",
                            "1h",
                            null,
                            color: Colors.blue,
                          ),
                          _buildChatItem(
                            "Tet Party Squad 🧧",
                            "Minh: Who has the lucky money?",
                            "Yesterday",
                            "group", // flag for group icon
                            unread: 3,
                          ),
                          _buildChatItem(
                            "David Tran",
                            "See you at the fireworks show!",
                            "Tue",
                            null,
                            color: Colors.purple,
                            isSeen: true,
                          ),
                          _buildChatItem(
                            "Anna Le",
                            "Thanks for the gems!",
                            "Tue",
                            null,
                            color: Colors.pink,
                            isSeen: true,
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

  Widget _buildStoryItem(String name, String? imagePath, {bool isMine = false, bool isOnline = false, Color? color}) {
    return Padding(
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
                  child: imagePath == null ? Center(child: Text(name[0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))) : null,
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
    );
  }

  Widget _buildChatItem(String name, String msg, String time, String? imagePath, {int unread = 0, bool online = false, bool isSeen = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              if (imagePath == "group")
                Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.group, color: Colors.white, size: 30),
                )
              else
                CircleAvatar(
                  radius: 32.5,
                  backgroundColor: color ?? Colors.blueGrey[100],
                  backgroundImage: imagePath != null ? AssetImage(imagePath) : null,
                  child: imagePath == null ? Text(name[0], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)) : null,
                ),
              if (online)
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              if (unread > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Color(0xFFFF4C71), shape: BoxShape.circle),
                    child: Text(
                      unread.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: unread > 0 ? const Color(0xFFFF4C71) : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        msg,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: unread > 0 ? FontWeight.w800 : FontWeight.w500,
                          color: unread > 0 ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    if (isSeen)
                      const Icon(Icons.done_all, size: 16, color: Color(0xFF94A3B8)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
