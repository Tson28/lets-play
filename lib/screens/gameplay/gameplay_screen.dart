import 'package:flutter/material.dart';
import 'package:lets_play/screens/gameplay/widgets/bet_board.dart';
import 'package:lets_play/screens/gameplay/widgets/chip_selector.dart';
import 'package:lets_play/screens/gameplay/widgets/action_button.dart';

class GameplayScreen extends StatefulWidget {
  const GameplayScreen({super.key});

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  int _selectedChip = 1000;
  final Map<String, int> _bets = {};
  int _points = 50000;

  final List<BetOption> _betOptions = const [
    BetOption(id: 'bau', label: 'Bầu', icon: Icons.water_drop_rounded, color: Color(0xFF4CAF50)),
    BetOption(id: 'cua', label: 'Cua', icon: Icons.pets_rounded, color: Color(0xFFE91E63)),
    BetOption(id: 'ca', label: 'Cá', icon: Icons.set_meal_rounded, color: Color(0xFF2196F3)),
    BetOption(id: 'ga', label: 'Gà', icon: Icons.egg_rounded, color: Color(0xFFFF9800)),
    BetOption(id: 'tom', label: 'Tôm', icon: Icons.eco_rounded, color: Color(0xFF009688)),
    BetOption(id: 'nai', label: 'Nai', icon: Icons.park_rounded, color: Color(0xFF9C27B0)),
  ];

  void _onOptionTap(String optionId) {
    setState(() {
      final current = _bets[optionId] ?? 0;
      _bets[optionId] = current + _selectedChip;
    });
  }

  void _onPlaceBet() {
    final total = _bets.values.fold(0, (sum, val) => sum + val);
    if (total > 0 && total <= _points) {
      setState(() {
        _points -= total;
        _bets.clear();
      });
    }
  }

  void _onClearBets() {
    setState(() {
      _bets.clear();
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
            colors: [
              Color(0xFF1A0D2E),
              Color(0xFF0D0618),
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
                const SizedBox(height: 24),
                BetBoard(
                  options: _betOptions,
                  bets: _bets,
                  onOptionTap: _onOptionTap,
                ),
                const SizedBox(height: 20),
                _buildChipSection(),
                const SizedBox(height: 16),
                ActionButton(
                  text: 'Đặt cược',
                  icon: Icons.casino_rounded,
                  onPressed: _onPlaceBet,
                  type: ActionButtonType.primary,
                ),
                ActionButton(
                  text: 'Xóa cược',
                  icon: Icons.refresh_rounded,
                  onPressed: _onClearBets,
                  type: ActionButtonType.secondary,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bầu Cua',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Chọn ô và đặt cược',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFC107).withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.monetization_on_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 6),
                Text(
                  '$_points',
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

  Widget _buildChipSection() {
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
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ChipSelector(
          selectedValue: _selectedChip,
          onChipSelected: (value) => setState(() => _selectedChip = value),
        ),
      ],
    );
  }
}
