import 'package:flutter/material.dart';

class EventRoomScreen extends StatefulWidget {
  final String eventTitle;
  final String eventDescription;

  const EventRoomScreen({super.key, required this.eventTitle, required this.eventDescription});

  @override
  State<EventRoomScreen> createState() => _EventRoomScreenState();
}

class _EventRoomScreenState extends State<EventRoomScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;
  late Animation<Offset> _headerSlide;
  late Animation<Offset> _participantSlide;

  final List<Map<String, String>> _participants = [
    {'name': 'Linh Nhi', 'role': 'Host'},
    {'name': 'Minh Tuan', 'role': 'Player'},
    {'name': 'Sarah', 'role': 'Player'},
    {'name': 'Dave', 'role': 'Player'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeIn));
    _scale = CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.9, curve: Curves.easeOutBack));
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.25), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.35, curve: Curves.easeOut)),
    );
    _participantSlide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.85, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room: ${widget.eventTitle}'),
        backgroundColor: const Color(0xFFAF8EE9),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFFFE0F7), const Color(0xFFC8A1F5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CustomPaint(painter: _BackgroundPainter()),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: _headerSlide,
                    child: ScaleTransition(
                      scale: _scale,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.eventTitle,
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.eventDescription,
                            style: const TextStyle(fontSize: 16, color: Color(0xFFBFC9D9)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeIn,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade300,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.pink.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: const Text('Live', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: LinearProgressIndicator(
                              value: 0.62,
                              color: Colors.purpleAccent,
                              backgroundColor: Colors.white24,
                              minHeight: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('342 online', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Participants', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SlideTransition(
                      position: _participantSlide,
                      child: ListView.builder(
                        itemCount: _participants.length,
                        itemBuilder: (context, index) {
                          final participant = _participants[index];
                          final appearIntervalStart = 0.4 + index * 0.1;
                          final appearAnim = CurvedAnimation(
                            parent: _controller,
                            curve: Interval(appearIntervalStart, appearIntervalStart + 0.2, curve: Curves.easeOut),
                          );
                          return FadeTransition(
                            opacity: appearAnim,
                            child: SlideTransition(
                              position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(appearAnim),
                              child: _ParticipantItem(name: participant['name']!, role: participant['role']!),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF4C71),
                            elevation: 6,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Bạn đã vào phòng thành công, bắt đầu trò chơi nào!')),
                            );
                          },
                          child: const Text('Tham gia phòng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white70),
                            foregroundColor: Colors.white70,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Quay lại', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParticipantItem extends StatelessWidget {
  final String name;
  final String role;

  const _ParticipantItem({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.70),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: role == 'Host' ? const Color(0xFFFF4C71) : const Color(0xFF64748B),
            child: Text(name.substring(0, 1), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
              Text(role, style: const TextStyle(fontSize: 13, color: Color(0xFFABB7D6))),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: role == 'Host' ? const Color(0xFFFF4C71) : const Color(0xFF64748B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(role, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF143366).withOpacity(0.26);
    final path = Path();
    path.moveTo(0, size.height * 0.26);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.14, size.width * 0.46, size.height * 0.26);
    path.quadraticBezierTo(size.width * 0.62, size.height * 0.35, size.width, size.height * 0.20);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);

    final bigCircle = Paint()..color = const Color(0xFF4B6DCA).withOpacity(0.16);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.15), 72, bigCircle);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.60), 56, bigCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
