import 'dart:async';
import 'package:flutter/material.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> with TickerProviderStateMixin {
  int _selectedChip = 1000;
  final Map<String, int> _bets = {};
  int _points = 50000;

  Timer? _resolutionTimer;
  bool _isResolving = false;
  int _secondsLeft = 0;
  String? _resultMessage;
  int _lastBetTotal = 0;
  String? _winningAnimal;
  late AnimationController _bounceController;

  final List<AnimalOption> _animals = [
    AnimalOption(id: 'bau', name: 'Bầu', emoji: '🎃', color: Color(0xFFD4AF37)),
    AnimalOption(id: 'cua', name: 'Cua', emoji: '🦀', color: Color(0xFFC4512A)),
    AnimalOption(id: 'ca', name: 'Cá', emoji: '🐟', color: Color(0xFF4A90E2)),
    AnimalOption(id: 'ga', name: 'Gà', emoji: '🐔', color: Color(0xFFFF7043)),
    AnimalOption(id: 'tom', name: 'Tôm', emoji: '🦐', color: Color(0xFFD4AF37)),
    AnimalOption(id: 'nai', name: 'Nai', emoji: '🦌', color: Color(0xFF8B5A3C)),
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _resolutionTimer?.cancel();
    _bounceController.dispose();
    super.dispose();
  }

  void _onAnimalTap(String animalId) {
    if (_isResolving) return;
    setState(() {
      final current = _bets[animalId] ?? 0;
      _bets[animalId] = current + _selectedChip;
    });
  }

  void _onPlaceBet() {
    final total = _getTotalBet();
    
    if (total == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn con vật để cược'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    
    if (total > _points) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFF8B3A3A),
          title: const Text(
            '⚠️ Không đủ tiền',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bạn cần: $total xu',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Tài khoản: $_points xu',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Thiếu: ${total - _points} xu',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
      return;
    }

    if (_isResolving) return;

    setState(() {
      _points -= total;
      _lastBetTotal = total;
      _isResolving = true;
      _secondsLeft = 4;
      _resultMessage = null;
      _winningAnimal = null;
    });

    _bounceController.forward(from: 0.0);

    _resolutionTimer?.cancel();
    _resolutionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        _resolveBet();
      } else {
        setState(() {
          _secondsLeft -= 1;
        });
      }
    });
  }

  void _resolveBet() {
    final animalIds = _animals.map((e) => e.id).toList();
    final winIndex = (DateTime.now().millisecondsSinceEpoch % 6).toInt();
    final winningId = animalIds[winIndex];
    final winning = _animals.firstWhere((e) => e.id == winningId);

    final didWin = _bets.containsKey(winningId) && _bets[winningId]! > 0;
    final winAmount = didWin ? _lastBetTotal * 2 : 0;

    setState(() {
      _isResolving = false;
      _winningAnimal = winningId;
      _resultMessage = didWin
          ? '🎉 THẮNG! ${winning.emoji} ${winning.name.toUpperCase()}\n+${winAmount} xu!'
          : '😢 Thua rồi! ${winning.emoji} ${winning.name.toUpperCase()} thắng';
      if (didWin) {
        _points += winAmount;
      }
      _bets.clear();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: didWin ? const Color(0xFFFFD700) : const Color(0xFF808080),
              title: Text(
                didWin ? '🎊 THẮNG LỚN! 🎊' : '😢 Thua',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: didWin ? Colors.red : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    winning.emoji,
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _resultMessage!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: didWin ? Colors.red : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tiếp tục', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _onClearBets() {
    setState(() {
      _bets.clear();
    });
  }

  int _getTotalBet() {
    return _bets.values.fold(0, (sum, val) => sum + val);
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
              colors: [Color(0xFF8B3A3A), Color(0xFFC4512A)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '🎲 TẾT ĐỎ VUI 🎲',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Trò chơi May Mắn Truyền Thống',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          '$_points xu',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B3A3A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Game Board Container
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Result Display
                        if (_isResolving || _winningAnimal != null)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                if (_isResolving)
                                  Column(
                                    children: [
                                      Text(
                                        'Công bố kết quả trong...',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF8B3A3A),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      ScaleTransition(
                                        scale: Tween(begin: 1.0, end: 1.3).animate(_bounceController),
                                        child: Text(
                                          '$_secondsLeft',
                                          style: const TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFC4512A),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (_winningAnimal != null && !_isResolving)
                                  Text(
                                    _resultMessage ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8B3A3A),
                                      height: 1.6,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 20),

                        // Animals Grid
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.95,
                              ),
                              itemCount: _animals.length,
                              itemBuilder: (context, index) {
                                final animal = _animals[index];
                                final betAmount = _bets[animal.id] ?? 0;
                                final isWinner = _winningAnimal == animal.id;

                                return GestureDetector(
                                  onTap: () => _onAnimalTap(animal.id),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: isWinner
                                          ? Colors.yellow.withOpacity(0.8)
                                          : (betAmount > 0
                                              ? animal.color.withOpacity(0.6)
                                              : Colors.white.withOpacity(0.08)),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isWinner
                                            ? Colors.yellow
                                            : (betAmount > 0 ? animal.color : Colors.white.withOpacity(0.2)),
                                        width: isWinner ? 3 : 2,
                                      ),
                                      boxShadow: isWinner
                                          ? [
                                              BoxShadow(
                                                color: Colors.yellow.withOpacity(0.6),
                                                blurRadius: 15,
                                                spreadRadius: 2,
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                animal.emoji,
                                                style: const TextStyle(fontSize: 48),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                animal.name,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: isWinner ? Colors.red : Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (betAmount > 0)
                                          Positioned(
                                            bottom: 8,
                                            right: 8,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '$betAmount',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF8B3A3A),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Chip Selector
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Chọn mức cược',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [1000, 5000, 10000, 50000].map((value) {
                                  final isSelected = _selectedChip == value;
                                  return GestureDetector(
                                    onTap: () => setState(() => _selectedChip = value),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
                                          width: isSelected ? 2 : 1,
                                        ),
                                      ),
                                      child: Text(
                                        '${value ~/ 1000}k',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? Color(0xFFDC2F02) : Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Total Bet Display
                        if (_getTotalBet() > 0)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Tổng: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8B3A3A),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${_getTotalBet()} xu',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF8B3A3A),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: (_isResolving || _getTotalBet() == 0)
                              ? null
                              : _onPlaceBet,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4AF37),
                            disabledBackgroundColor: Colors.grey[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            '💰 ĐẶT CƯỢC 💰',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B3A3A),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: _isResolving ? null : _onClearBets,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Xóa cược',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class AnimalOption {
  final String id;
  final String name;
  final String emoji;
  final Color color;

  AnimalOption({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });
}
