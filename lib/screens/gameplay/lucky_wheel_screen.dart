import 'package:flutter/material.dart';
import 'dart:math';

class LuckyWheelScreen extends StatefulWidget {
  const LuckyWheelScreen({super.key});

  @override
  State<LuckyWheelScreen> createState() => _LuckyWheelScreenState();
}

class _LuckyWheelScreenState extends State<LuckyWheelScreen>
    with TickerProviderStateMixin {
  late AnimationController _wheelController;
  bool _isSpinning = false;
  String? _result;
  int _spinsRemaining = 3;

  final List<Map<String, dynamic>> _wheelItems = [
    {'label': '50 xu', 'color': Color(0xFFFF6B6B), 'icon': Icons.monetization_on},
    {'label': '100 xu', 'color': Color(0xFF4ECDC4), 'icon': Icons.monetization_on},
    {'label': 'Free Game', 'color': Color(0xFFFFD93D), 'icon': Icons.card_giftcard},
    {'label': '500 xu', 'color': Color(0xFF6BCB77), 'icon': Icons.monetization_on},
    {'label': 'Bonus', 'color': Color(0xFF9D84B7), 'icon': Icons.emoji_events},
    {'label': 'Try Again', 'color': Color(0xFFFFA502), 'icon': Icons.refresh},
    {'label': '200 xu', 'color': Color(0xFF00D2D3), 'icon': Icons.monetization_on},
    {'label': '1000 xu', 'color': Color(0xFFF2CC8F), 'icon': Icons.star},
  ];

  @override
  void initState() {
    super.initState();
    _wheelController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _wheelController.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (_isSpinning || _spinsRemaining <= 0) return;

    final random = Random();
    final randomAngle = random.nextDouble() * 360;
    final rotations = 5 + (randomAngle / 360);

    setState(() {
      _isSpinning = true;
      _result = null;
      _spinsRemaining--;
    });

    _wheelController.forward(from: 0.0);

    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        final selectedIndex =
            (((rotations % 1) * _wheelItems.length).toInt()) % _wheelItems.length;
        setState(() {
          _result = _wheelItems[selectedIndex]['label'];
          _isSpinning = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFA500), Color(0xFFFFD700)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header with Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Vòng Quay',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'May Mắn',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 48, // Match back button width for alignment
                      ),
                    ],
                  ),
                ),

                Text(
                  'Lượt còn lại: $_spinsRemaining',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                // Wheel Spinner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Wheel
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 5.0).animate(_wheelController),
                        child: Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Wheel Background
                              Container(
                                width: 260,
                                height: 260,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 8,
                                  ),
                                ),
                                child: CustomPaint(
                                  painter: WheelPainter(_wheelItems),
                                ),
                              ),
                              // Center Circle
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Color(0xFFFE4C71),
                                        size: 24,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "Let's\nPlay",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6B48FF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Pointer at top
                      Positioned(
                        top: 0,
                        child: Transform.translate(
                          offset: const Offset(0, -10),
                          child: CustomPaint(
                            painter: PointerPainter(),
                            size: const Size(30, 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Result Display
                if (_result != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Bạn đã thắng!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B48FF),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _result!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE4C71),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (!_isSpinning && _spinsRemaining > 0)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Ấn nút bên dưới để quay vòng!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const Spacer(),

                // Spin Button or Message
                if (_spinsRemaining > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: _isSpinning ? null : _spinWheel,
                        icon: const Icon(Icons.touch_app, size: 22),
                        label: Text(
                          _isSpinning ? 'Đang quay...' : 'QUAY NGAY',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFFFA500),
                          disabledBackgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Hôm nay bạn đã dùng hết lượt quay. Hãy quay lại vào ngày mai!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<Map<String, dynamic>> items;

  WheelPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final itemCount = items.length;
    final sweepAngle = (2 * pi) / itemCount;

    for (int i = 0; i < itemCount; i++) {
      final paint = Paint()
        ..color = items[i]['color']
        ..style = PaintingStyle.fill;

      final startAngle = i * sweepAngle - pi / 2;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw border
      final borderPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        borderPaint,
      );

      // Draw text
      final textAngle = startAngle + sweepAngle / 2;
      final textRadius = radius * 0.7;
      final textX = center.dx + textRadius * cos(textAngle);
      final textY = center.dy + textRadius * sin(textAngle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i]['label'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          textX - textPainter.width / 2,
          textY - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(WheelPainter oldDelegate) => false;
}

class PointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(PointerPainter oldDelegate) => false;
}
