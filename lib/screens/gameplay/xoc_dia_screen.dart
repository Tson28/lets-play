import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class XocDiaScreen extends StatefulWidget {
  const XocDiaScreen({super.key});

  @override
  State<XocDiaScreen> createState() => _XocDiaScreenState();
}

class _XocDiaScreenState extends State<XocDiaScreen> with TickerProviderStateMixin {
  int _money = 50000;
  int _selectedChip = 1000;
  bool _isRolling = false;

  List<int> _dices = [1, 2, 3];
  List<String> _history = [];
  List<String> _botChat = ["Chúc mừng năm mới! 🧧", "Khai xuân phát tài! 🧧"];

  Map<String, int> _bets = {};

  late AnimationController _diceController;

  @override
  void initState() {
    super.initState();

    _diceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _startBotChat();
  }

  void _startBotChat() {
    Timer.periodic(const Duration(seconds: 3), (t) {
      if (!mounted) return;
      final msgs = [
        'Lì xì tới tấp! 🧧',
        'Chẵn đi anh em ơi! 💰',
        'Lẻ về như ý! ✨',
        'Tết này ấm no rồi 😂',
        'Đánh đâu thắng đó nha!',
        'Vào cầu rồi! 🔥',
      ];
      setState(() {
        _botChat.insert(0, msgs[Random().nextInt(msgs.length)]);
        if (_botChat.length > 5) _botChat.removeLast();
      });
    });
  }

  @override
  void dispose() {
    _diceController.dispose();
    super.dispose();
  }

  void _roll() {
    if (_isRolling || _bets.isEmpty) return;

    final totalBet = _bets.values.fold(0, (a, b) => a + b);
    if (totalBet > _money) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không đủ tiền cược!')),
      );
      return;
    }

    setState(() {
      _money -= totalBet;
      _isRolling = true;
    });

    _diceController.repeat();

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isRolling) {
        timer.cancel();
        return;
      }
      setState(() {
        _dices = List.generate(3, (_) => Random().nextInt(6) + 1);
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      _diceController.stop();
      setState(() {
        _isRolling = false;
        _dices = List.generate(3, (_) => Random().nextInt(6) + 1);
      });
      _checkResult(totalBet);
    });
  }

  void _checkResult(int totalBet) {
    int totalPoints = _dices.fold(0, (a, b) => a + b);
    bool isEven = totalPoints % 2 == 0;
    int win = 0;

    if (_bets.containsKey('chan') && isEven) win += _bets['chan']! * 2;
    if (_bets.containsKey('le') && !isEven) win += _bets['le']! * 2;

    setState(() {
      _money += win;
      _history.insert(0, isEven ? 'C' : 'L');
      if (_history.length > 10) _history.removeLast();
      _bets.clear();
    });

    _showResultDialog(win, totalPoints, isEven, totalBet);
  }

  void _showResultDialog(int win, int total, bool isEven, int lost) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) => const SizedBox(),
      transitionBuilder: (context, a1, a2, child) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            backgroundColor: const Color(0xFFC41E3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.yellow, width: 3),
            ),
            title: Center(
              child: Text(
                win > 0 ? '🧧 PHÁT TÀI 🧧' : '🧨 CHÚC MAY MẮN 🧨',
                style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'KẾT QUẢ: ${isEven ? "CHẴN" : "LẺ"} ($total điểm)',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  win > 0 ? '+$win xu' : '-$lost xu',
                  style: TextStyle(
                    color: win > 0 ? Colors.yellow : Colors.white70,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('TIẾP TỤC', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDice(int val) {
    return AnimatedBuilder(
      animation: _diceController,
      builder: (context, child) {
        final angle = _diceController.value * 2 * pi;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateX(angle)
            ..rotateY(angle),
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(2, 4))
              ],
            ),
            child: _drawDiceFace(val),
          ),
        );
      },
    );
  }

  Widget _drawDiceFace(int val) {
    // FIX LỖI Ở ĐÂY
    List<int> dots = {
      1: [4],
      2: [0, 8],
      3: [0, 4, 8],
      4: [0, 2, 6, 8],
      5: [0, 2, 4, 6, 8],
      6: [0, 2, 3, 5, 6, 8],
    }[val]!;

    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(6),
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(9, (index) {
        return Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: dots.contains(index) ? 1 : 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B1538),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _dices.map((e) => _buildSingleDice(e)).toList(),
        ),
      ),
    );
  }
}