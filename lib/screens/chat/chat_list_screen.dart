import 'package:flutter/material.dart';
import 'package:lets_play/screens/chat/widgets/chat_item.dart';
import 'package:lets_play/screens/chat/widgets/online_user_row.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onlineUsers = [
      const OnlineUser(id: '1', name: 'Minh'),
      const OnlineUser(id: '2', name: 'Linh'),
      const OnlineUser(id: '3', name: 'Tuấn'),
      const OnlineUser(id: '4', name: 'Hương'),
      const OnlineUser(id: '5', name: 'Đức'),
    ];

    final chats = [
      _ChatData(
        name: 'Minh',
        lastMessage: 'Ê chơi Bầu Cua không?',
        time: '2 phút',
        unreadCount: 2,
        isOnline: true,
      ),
      _ChatData(
        name: 'Linh',
        lastMessage: 'Gửi quà cho bạn rồi nè 💝',
        time: '15 phút',
        unreadCount: 0,
        isOnline: true,
      ),
      _ChatData(
        name: 'Tuấn',
        lastMessage: 'Tối nay chơi game nhé!',
        time: '1 giờ',
        unreadCount: 1,
        isOnline: false,
      ),
      _ChatData(
        name: 'Hương',
        lastMessage: 'Vòng quay may mắn có quà mới',
        time: 'Hôm qua',
        unreadCount: 0,
        isOnline: true,
      ),
      _ChatData(
        name: 'Đức',
        lastMessage: '👍',
        time: '2 ngày',
        unreadCount: 0,
        isOnline: false,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Đang hoạt động',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            OnlineUserRow(
              users: onlineUsers,
              onUserTap: (user) {
                // Navigate to chat with user
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 20,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5FA),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              size: 22,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Tìm kiếm tin nhắn...',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return ChatItem(
                            name: chat.name,
                            lastMessage: chat.lastMessage,
                            time: chat.time,
                            unreadCount: chat.unreadCount,
                            isOnline: chat.isOnline,
                            onTap: () {
                              // Navigate to chat room
                            },
                          );
                        },
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tin nhắn',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Kết nối với bạn bè',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: [
              _HeaderIconButton(
                icon: Icons.group_add_rounded,
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _HeaderIconButton(
                icon: Icons.settings_rounded,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 22,
          color: const Color(0xFF6B48FF),
        ),
      ),
    );
  }
}

class _ChatData {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  _ChatData({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
  });
}
