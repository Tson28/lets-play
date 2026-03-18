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
  bool _isShaking = false;
  bool _isOpen = true;

  // 0: Trắng, 1: Đỏ
  List<int> _coins = [0, 0, 0, 0];
  
  // Lưu trữ tiền cược cho từng ô
  Map<String, int> _bets = {
    'chan': 0, 'le': 0, 
    '4_do': 0, '4_trang': 0, 
    '3_do': 0, '3_trang': 0
  };

  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) _shakeController.reverse();
      });
  }

  void _play() {
    int totalCurrentBet = _bets.values.fold(0, (sum, item) => sum + item);
    if (_isShaking || totalCurrentBet == 0 || totalCurrentBet > _money) return;

    setState(() {
      _isShaking = true;
      _isOpen = false;
      _money -= totalCurrentBet;
    });

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _shakeController.forward();
      if (timer.tick > 15) {
        timer.cancel();
        setState(() {
          _isShaking = false;
          _coins = List.generate(4, (_) => Random().nextInt(2));
        });
      }
    });
  }

  void _openBowl() {
    if (_isOpen || _isShaking) return;
    
    int redCount = _coins.where((c) => c == 1).length;
    int whiteCount = 4 - redCount;
    int winAmount = 0;

    // Tính toán thắng thua
    if (redCount % 2 == 0) {
      winAmount += _bets['chan']! * 2;
    } else {
      winAmount += _bets['le']! * 2;
    }

    if (redCount == 4) winAmount += _bets['4_do']! * 12;
    if (whiteCount == 4) winAmount += _bets['4_trang']! * 12;
    if (redCount == 3) winAmount += _bets['3_do']! * 4;
    if (whiteCount == 3) winAmount += _bets['3_trang']! * 4;

    setState(() {
      _isOpen = true;
      _money += winAmount;
    });

    _showResult(redCount, whiteCount, winAmount);
    setState(() => _bets.updateAll((key, value) => 0));
  }

  void _showResult(int red, int white, int win) {
    final isWin = win > 0;
    final title = isWin ? 'THẮNG LỚN!' : 'THUA RỒI';
    final resultText = '$red Đỏ - $white Trắng';
    final foText = red % 2 == 0 ? 'Kết quả: CHẴN' : 'Kết quả: LẺ';
    final gradientColors = isWin
        ? [Colors.greenAccent.shade400, Colors.green.shade900]
        : [Colors.deepOrange.shade400, Colors.red.shade900];

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Result',
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (ctx, anim1, anim2) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.white70, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.45),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ])),
                          GestureDetector(
                            onTap: () => Navigator.of(ctx).pop(),
                            child: const Icon(Icons.close, color: Colors.white, size: 26),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(
                          7,
                          (index) => Icon(
                            isWin ? Icons.star : Icons.flash_on,
                            color: index.isEven ? Colors.amberAccent : Colors.white70,
                            size: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Icon(
                        isWin ? Icons.emoji_events : Icons.sentiment_very_dissatisfied,
                        size: 60,
                        color: Colors.yellowAccent.shade700,
                      ),
                      const SizedBox(height: 10),
                      Text(resultText,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(foText,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      if (isWin)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            '+$win xu',
                            style: const TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black45, blurRadius: 6)],
                            ),
                          ),
                        ),
                      if (!isWin)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            'Cố gắng lần sau!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('ĐÓNG', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(
            parent: anim1,
            curve: Curves.easeOutBack,
          )),
          child: FadeTransition(opacity: anim1, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('static_assets/images/back.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildStatusHeader(),
              const SizedBox(height: 20),
              _buildTable(),
              const Spacer(),
              _buildBettingBoard(),
              _buildChipSelector(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.black38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("TIỀN: $_money xu", style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(icon: Icon(Icons.help_outline, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(sin(_shakeController.value * pi * 10) * 8, 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Cái đĩa
              Container(
                width: 240, height: 240,
                decoration: BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[400]!, width: 8),
                  boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15)],
                ),
              ),
              // Quân vị
              if (_isOpen || !_isShaking)
                Wrap(
                  spacing: 15, runSpacing: 15,
                  children: _coins.map((c) => Container(
                    width: 45, height: 45,
                    decoration: BoxDecoration(
                      color: c == 1 ? Colors.red : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black45, width: 2),
                    ),
                  )).toList(),
                ),
              // Cái bát
              AnimatedPositioned(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                top: _isOpen ? -300 : 20,
                child: Container(
                  width: 200, height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50], shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [Colors.white, Colors.grey[400]!]),
                    boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
                  ),
                  child: Center(child: Icon(Icons.adjust, size: 60, color: Colors.red[800])),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBettingBoard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              _betButton("CHẴN", "chan", Colors.red[700]!, 1),
              _betButton("LẺ", "le", Colors.grey[800]!, 1),
            ],
          ),
          Row(
            children: [
              _betButton("4 ĐỎ", "4_do", Colors.red[900]!, 12),
              _betButton("4 TRẮNG", "4_trang", Colors.white24, 12),
              _betButton("3 ĐỎ", "3_do", Colors.red[400]!, 4),
              _betButton("3 TRẮNG", "3_trang", Colors.white12, 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _betButton(String label, String key, Color color, int rate) {
    final betAmount = _bets[key]!;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _bets[key] = _bets[key]! + _selectedChip),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.yellow.withOpacity(0.8), width: betAmount > 0 ? 2.5 : 1.3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(betAmount > 0 ? 0.35 : 0.18),
                blurRadius: betAmount > 0 ? 12 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on_rounded, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Text("x$rate", style: const TextStyle(color: Colors.white70, fontSize: 10)),
              if (betAmount > 0) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.attach_money, color: Colors.lightGreenAccent, size: 15),
                      const SizedBox(width: 4),
                      Text("${betAmount}", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChipSelector() {
    List<int> chips = [1000, 5000, 10000, 50000];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: chips.map((c) => GestureDetector(
          onTap: () => setState(() => _selectedChip = c),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _selectedChip == c ? Colors.amberAccent.withOpacity(0.95) : Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
              border: Border.all(
                color: _selectedChip == c ? Colors.orange.shade700 : Colors.white54,
                width: _selectedChip == c ? 3 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_selectedChip == c ? 0.35 : 0.2),
                  blurRadius: _selectedChip == c ? 12 : 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.monetization_on, size: 28, color: _selectedChip == c ? Colors.deepOrange : Colors.white),
                Positioned(
                  bottom: 8,
                  child: Text(
                    '${c ~/ 1000}k',
                    style: TextStyle(
                      color: _selectedChip == c ? Colors.black87 : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[800], padding: EdgeInsets.all(15)),
              onPressed: _play, child: Text("XÓC ĐĨA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800], padding: EdgeInsets.all(15)),
              onPressed: _openBowl, child: Text("MỞ BÁT", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}