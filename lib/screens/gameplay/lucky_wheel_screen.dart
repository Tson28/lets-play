import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    home: LuckyWheelScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class LuckyWheelScreen extends StatefulWidget {
  const LuckyWheelScreen({super.key});

  @override
  State<LuckyWheelScreen> createState() => _LuckyWheelScreenState();
}

class _LuckyWheelScreenState extends State<LuckyWheelScreen>
    with TickerProviderStateMixin {
  late AnimationController _wheelController;
  late Animation<double> _wheelAnimation;
  late AnimationController _decorController;
  bool _isSpinning = false;
  String? _result;
  int _spinsRemaining = 3;
  double _currentRotation = 0.0; // Lưu vị trí góc hiện tại

  // Danh sách phần thưởng
  final List<Map<String, dynamic>> _wheelItems = [
    {'label': '50 xu', 'color': const Color(0xFFFF6B6B)},
    {'label': '100 xu', 'color': const Color(0xFF4ECDC4)},
    {'label': 'Free Game', 'color': const Color(0xFFFFD93D)},
    {'label': '500 xu', 'color': const Color(0xFF6BCB77)},
    {'label': 'Bonus', 'color': const Color(0xFF9D84B7)},
    {'label': 'Try Again', 'color': const Color(0xFFFFA502)},
    {'label': '200 xu', 'color': const Color(0xFF00D2D3)},
    {'label': '1000 xu', 'color': const Color(0xFFF2CC8F)},
  ];

  @override
  void initState() {
    super.initState();
    _wheelController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _decorController = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    )..repeat();

    // Khởi tạo animation mặc định
    _wheelAnimation = Tween<double>(begin: 0, end: 0).animate(_wheelController);
  }

  @override
  void dispose() {
    _wheelController.dispose();
    _decorController.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (_isSpinning || _spinsRemaining <= 0) return;

    final random = Random();
    // Quay ít nhất 5 vòng + một góc ngẫu nhiên
    double totalTurns = 5 + random.nextDouble(); 
    
    setState(() {
      _isSpinning = true;
      _result = null;
      _spinsRemaining--;
      
      // Animation chạy từ vị trí hiện tại đến đích mới
      _wheelAnimation = Tween<double>(
        begin: _currentRotation,
        end: _currentRotation + totalTurns,
      ).animate(CurvedAnimation(
        parent: _wheelController,
        curve: Curves.easeOutQuart,
      ));
    });

    _wheelController.forward(from: 0.0).whenComplete(() {
      if (!mounted) return;

      _currentRotation += totalTurns; // Cập nhật vị trí dừng lại
      
      // Tính toán kết quả dựa trên kim chỉ ở đỉnh (góc 270 độ hoặc -pi/2)
      // Công thức: (1 - (vòng_dư)) * số_phần_tử
      final double finalPosition = _currentRotation % 1;
      int selectedIndex = (((1 - finalPosition) * _wheelItems.length).floor()) % _wheelItems.length;

      setState(() {
        _result = _wheelItems[selectedIndex]['label'];
        _isSpinning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Text(
                'Lượt còn lại: $_spinsRemaining',
                style: const TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              
              // KHU VỰC VÒNG QUAY
              Stack(
                alignment: Alignment.center,
                children: [
                  // Vòng ngoài xoay động
                  SizedBox(
                    width: 360,
                    height: 360,
                    child: AnimatedBuilder(
                      animation: _decorController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _decorController.value * 2 * pi,
                          child: child,
                        );
                      },
                      child: CustomPaint(
                        painter: GlowRingPainter(),
                      ),
                    ),
                  ),
                  // Vòng tròn trang trí bên ngoài
                  Container(
                    width: 310,
                    height: 310,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  // Vòng quay chính
                  RotationTransition(
                    turns: _wheelAnimation,
                    child: CustomPaint(
                      size: const Size(290, 290),
                      painter: WheelPainter(_wheelItems),
                    ),
                  ),
                  // Kim chỉ ở đỉnh
                  Positioned(
                    top: -10,
                    child: CustomPaint(
                      size: const Size(30, 40),
                      painter: PointerPainter(),
                    ),
                  ),
                  // Tâm vòng quay
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                    ),
                    child: const Icon(Icons.star, color: Colors.orange, size: 30),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              _buildResultDisplay(),
              const Spacer(),
              _buildSpinButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.of(context).maybePop()),
          const Text('VÒNG QUAY MAY MẮN', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildResultDisplay() {
    if (_result == null) return const SizedBox(height: 80);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Text(
        'Chúc mừng: $_result',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2575FC)),
      ),
    );
  }

  Widget _buildSpinButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: (_isSpinning || _spinsRemaining <= 0) ? null : _spinWheel,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 8,
          ),
          child: Text(
            _isSpinning ? 'ĐANG QUAY...' : (_spinsRemaining > 0 ? 'QUAY NGAY' : 'HẾT LƯỢT'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// LỚP VẼ VÒNG QUAY
class WheelPainter extends CustomPainter {
  final List<Map<String, dynamic>> items;
  WheelPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweepAngle = (2 * pi) / items.length;

    for (int i = 0; i < items.length; i++) {
      // 1. Vẽ miếng nan quạt
      final paint = Paint()..color = items[i]['color'];
      final startAngle = (i * sweepAngle) - (pi / 2); // Bắt đầu từ 12 giờ

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // 2. Vẽ viền trắng
      final borderPaint = Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        borderPaint,
      );

      // 3. Vẽ chữ
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(startAngle + (sweepAngle / 2) + (pi / 2));

      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i]['label'],
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(-textPainter.width / 2, -radius * 0.75));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GlowRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..shader = SweepGradient(
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.pink.withOpacity(0.5),
          Colors.yellow.withOpacity(0.5),
          Colors.cyan.withOpacity(0.5),
          Colors.white.withOpacity(0.2),
        ],
        stops: [0, 0.2, 0.45, 0.7, 1],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius - 8, paint);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = Colors.white.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawCircle(center, radius - 14, glowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// LỚP VẼ KIM CHỈ
class PointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    
    canvas.drawShadow(path, Colors.black, 4, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}