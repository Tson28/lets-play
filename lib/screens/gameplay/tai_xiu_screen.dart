import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lets_play/screens/gameplay/widgets/action_button.dart';
import 'package:lets_play/screens/gameplay/widgets/chip_selector.dart';

class TaiXiuScreen extends StatefulWidget {
  const TaiXiuScreen({super.key});

  @override
  State<TaiXiuScreen> createState() => _TaiXiuScreenState();
}

class _TaiXiuScreenState extends State<TaiXiuScreen> {
  final Random _random = Random();

  int _points = 500000;
  int _selectedChip = 1000;
  int _betTai = 0;
  int _betXiu = 0;

  String _selectedSide = 'tai'; // 'tai' or 'xiu'

  bool _isRolling = false;
  List<int> _dice = const [2, 4, 6];
  int _countdown = 16;
  Timer? _timer;

  String? _lastResultText;
  bool? _lastIsWin;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() {
      _countdown = 16;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_countdown <= 1) {
        setState(() {
          _countdown = 0;
        });
        timer.cancel();
        return;
      }
      setState(() {
        _countdown--;
      });
    });
  }

  void _onSelectSide(String side) {
    if (_isRolling) return;
    setState(() {
      _selectedSide = side;
      final currentTotal = _betTai + _betXiu;
      if (currentTotal + _selectedChip > _points) return;
      if (side == 'tai') {
        _betTai += _selectedChip;
      } else {
        _betXiu += _selectedChip;
      }
    });
  }

  void _onAllIn() {
    if (_isRolling || _points <= 0) return;
    setState(() {
      _betTai = 0;
      _betXiu = 0;
      if (_selectedSide == 'tai') {
        _betTai = _points;
      } else {
        _betXiu = _points;
      }
    });
  }

  void _onClearBets() {
    if (_isRolling) return;
    setState(() {
      _betTai = 0;
      _betXiu = 0;
    });
  }

  Future<void> _onPlaceBet() async {
    if (_isRolling) return;

    final totalBet = _betTai + _betXiu;
    if (totalBet <= 0) {
      _showMessage('Vui lòng chọn Tài hoặc Xỉu và đặt cược.');
      return;
    }
    if (totalBet > _points) {
      _showMessage('Số dư không đủ để đặt cược.');
      return;
    }

    setState(() {
      _isRolling = true;
      _lastResultText = null;
    });

    // Xác định kết quả thắng/thua với tỉ lệ thắng ~0.35
    final isWin = _random.nextDouble() < 0.35;
    final bool playerOnTai = _betTai >= _betXiu;
    final bool winningSide = isWin ? playerOnTai : !playerOnTai;

    // Tạo xúc xắc tương ứng với bên thắng
    final dice = _generateDiceForSide(winningSide);
    final sum = dice.fold<int>(0, (s, v) => s + v);
    final isTai = sum >= 11;

    // Hiệu ứng quay xúc xắc nhẹ
    for (int i = 0; i < 8; i++) {
      if (!mounted) return;
      await Future.delayed(const Duration(milliseconds: 90));
      setState(() {
        _dice = [
          _random.nextInt(6) + 1,
          _random.nextInt(6) + 1,
          _random.nextInt(6) + 1,
        ];
      });
    }

    if (!mounted) return;

    setState(() {
      _dice = dice;

      if (isWin) {
        _points += totalBet;
      } else {
        _points -= totalBet;
      }

      _lastIsWin = isWin;
      _lastResultText =
          '$sum - ${isTai ? 'Tài' : 'Xỉu'} (${isWin ? 'Bạn thắng +' : 'Bạn thua -'}$totalBet)';

      _betTai = 0;
      _betXiu = 0;
      _isRolling = false;
    });

    _startCountdown();
  }

  List<int> _generateDiceForSide(bool taiSide) {
    while (true) {
      final a = _random.nextInt(6) + 1;
      final b = _random.nextInt(6) + 1;
      final c = _random.nextInt(6) + 1;
      final sum = a + b + c;
      final isTai = sum >= 11 && sum <= 17;
      final isXiu = sum >= 4 && sum <= 10;
      if (!isTai && !isXiu) continue;
      if (taiSide && isTai) return [a, b, c];
      if (!taiSide && isXiu) return [a, b, c];
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  int get _totalBet => _betTai + _betXiu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3C001F),
              Color(0xFF160010),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 18),
                _buildMainBoard(),
                const SizedBox(height: 20),
                _buildDiceRow(),
                const SizedBox(height: 12),
                _buildLastResult(),
                const SizedBox(height: 16),
                _buildChipSelector(),
                const SizedBox(height: 8),
                _buildActionButtons(),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD740), Color(0xFFFF6F00)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.casino_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Tài Xỉu Tết',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Không khí Tết rực rỡ, đặt cược may mắn!',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD740), Color(0xFFFFA000)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD740).withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.monetization_on_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  _formatNumber(_points),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainBoard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF5F6D),
            Color(0xFFFFC371),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
          width: 1.4,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSideInfo(
                label: 'TÀI',
                color: const Color(0xFFFFD740),
                amount: _betTai,
                isActive: _selectedSide == 'tai',
              ),
              _buildCountdown(),
              _buildSideInfo(
                label: 'XỈU',
                color: const Color(0xFFFFD740),
                amount: _betXiu,
                isActive: _selectedSide == 'xiu',
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildSideButton(
                  label: 'TÀI',
                  sideKey: 'tai',
                  background: const [Color(0xFFB71C1C), Color(0xFFD32F2F)],
                  betAmount: _betTai,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSideButton(
                  label: 'XỈU',
                  sideKey: 'xiu',
                  background: const [Color(0xFF311B92), Color(0xFF512DA8)],
                  betAmount: _betXiu,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cược: ${_formatNumber(_totalBet)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_events_rounded,
                      color: Color(0xFFFFD740),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Tỉ lệ thắng ~35%',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSideInfo({
    required String label,
    required Color color,
    required int amount,
    required bool isActive,
  }) {
    return Column(
      crossAxisAlignment:
          label == 'TÀI' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(isActive ? 1 : 0.7),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Colors.black.withOpacity(0.25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.monetization_on_rounded,
                size: 14,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                _formatNumber(amount),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountdown() {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xFFFFF59D),
                Color(0xFFE53935),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              _countdown.toString().padLeft(2, '0'),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _countdown > 0 ? 'Đang nhận cược' : 'Chờ ván mới',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildSideButton({
    required String label,
    required String sideKey,
    required List<Color> background,
    required int betAmount,
  }) {
    final bool isSelected = _selectedSide == sideKey;

    return GestureDetector(
      onTap: () => _onSelectSide(sideKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? background
                : background
                    .map((c) => c.withOpacity(0.7))
                    .toList(growable: false),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: background.last.withOpacity(0.55),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
          border: Border.all(
            color: Colors.white.withOpacity(isSelected ? 0.8 : 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.casino_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Đặt cược',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatNumber(betAmount),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceRow() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: Colors.white.withOpacity(0.25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _dice
              .map(
                (value) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _buildDice(value),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildDice(int value) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFDE7),
            Color(0xFFFFF59D),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D4037),
          ),
        ),
      ),
    );
  }

  Widget _buildLastResult() {
    if (_lastResultText == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Đặt cược để bắt đầu một ván mới.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      );
    }

    final bool win = _lastIsWin ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: win
              ? const Color(0xFF1B5E20).withOpacity(0.6)
              : const Color(0xFFB71C1C).withOpacity(0.6),
          border: Border.all(
            color: win
                ? const Color(0xFF69F0AE).withOpacity(0.7)
                : const Color(0xFFFF8A80).withOpacity(0.7),
          ),
        ),
        child: Row(
          children: [
            Icon(
              win ? Icons.emoji_events_rounded : Icons.warning_rounded,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _lastResultText!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Chọn mức cược',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ChipSelector(
          chipValues: const [1000, 10000, 50000, 100000, 500000],
          selectedValue: _selectedChip,
          onChipSelected: (value) =>
              setState(() => _selectedChip = value),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ActionButton(
          text: 'ALL-IN',
          icon: Icons.bolt_rounded,
          onPressed: _onAllIn,
          type: ActionButtonType.secondary,
        ),
        ActionButton(
          text: _isRolling ? 'Đang quay...' : 'ĐẶT CƯỢC',
          icon: Icons.casino_rounded,
          onPressed: _isRolling ? null : _onPlaceBet,
          type: ActionButtonType.primary,
          isLoading: _isRolling,
        ),
        ActionButton(
          text: 'HỦY / XÓA CƯỢC',
          icon: Icons.close_rounded,
          onPressed: _onClearBets,
          type: ActionButtonType.danger,
        ),
      ],
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000000) return '${n ~/ 1000000}M';
    if (n >= 1000) return '${n ~/ 1000}K';
    return '$n';
  }
}

