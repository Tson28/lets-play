import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final VoidCallback? onTap;

  const ChatItem({
    super.key,
    required this.name,
    this.avatarUrl,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: unreadCount > 0
                              ? const Color(0xFF6B48FF)
                              : Colors.grey[500],
                          fontWeight:
                              unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: unreadCount > 0
                                ? Colors.black87
                                : Colors.grey[600],
                            fontWeight:
                                unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (unreadCount > 0) _buildUnreadBadge(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6B48FF),
                Color(0xFF8B68FF),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B48FF).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: avatarUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _avatarPlaceholder(),
                  ),
                )
              : _avatarPlaceholder(),
        ),
        if (isOnline)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.5),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _avatarPlaceholder() {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUnreadBadge() {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B48FF), Color(0xFF8B68FF)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B48FF).withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        unreadCount > 99 ? '99+' : '$unreadCount',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
