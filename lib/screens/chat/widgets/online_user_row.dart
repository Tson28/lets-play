import 'package:flutter/material.dart';

class OnlineUserRow extends StatelessWidget {
  final List<OnlineUser> users;
  final Function(OnlineUser user)? onUserTap;

  const OnlineUserRow({
    super.key,
    required this.users,
    this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _OnlineUserAvatar(
            user: user,
            onTap: () => onUserTap?.call(user),
          );
        },
      ),
    );
  }
}

class OnlineUser {
  final String id;
  final String name;
  final String? avatarUrl;

  const OnlineUser({
    required this.id,
    required this.name,
    this.avatarUrl,
  });
}

class _OnlineUserAvatar extends StatelessWidget {
  final OnlineUser user;
  final VoidCallback? onTap;

  const _OnlineUserAvatar({
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6B48FF),
                        Color(0xFF8B68FF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B48FF).withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: user.avatarUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            user.avatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _placeholder(),
                          ),
                        )
                      : _placeholder(),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4CAF50).withOpacity(0.6),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Center(
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
