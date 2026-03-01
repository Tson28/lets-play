import 'package:flutter/material.dart';

class BetBoard extends StatelessWidget {
  final List<BetOption> options;
  final Map<String, int> bets;
  final Function(String optionId)? onOptionTap;

  const BetBoard({
    super.key,
    required this.options,
    required this.bets,
    this.onOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2D1B4E),
            const Color(0xFF1A0D2E),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B48FF).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bảng cược',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B48FF).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Tổng: ${_formatNumber(_totalBet())}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFC107),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              final amount = bets[option.id] ?? 0;
              return _BetCell(
                option: option,
                amount: amount,
                onTap: () => onOptionTap?.call(option.id),
              );
            },
          ),
        ],
      ),
    );
  }

  int _totalBet() {
    return bets.values.fold(0, (sum, val) => sum + val);
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${n ~/ 1000}K';
    return '$n';
  }
}

class BetOption {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const BetOption({
    required this.id,
    required this.label,
    required this.icon,
    this.color = const Color(0xFF6B48FF),
  });
}

class _BetCell extends StatelessWidget {
  final BetOption option;
  final int amount;
  final VoidCallback? onTap;

  const _BetCell({
    required this.option,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasBet = amount > 0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: hasBet
              ? option.color.withOpacity(0.35)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasBet ? option.color : Colors.white.withOpacity(0.1),
            width: hasBet ? 2 : 1,
          ),
          boxShadow: hasBet
              ? [
                  BoxShadow(
                    color: option.color.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 0,
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
                  Icon(
                    option.icon,
                    size: 32,
                    color: hasBet ? option.color : Colors.white.withOpacity(0.6),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: hasBet ? Colors.white : Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (amount > 0)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$amount',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
