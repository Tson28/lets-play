import 'package:flutter/material.dart';

enum ActionButtonType { primary, secondary, danger }

class ActionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ActionButtonType type;
  final bool isLoading;
  final bool isEnabled;

  const ActionButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.type = ActionButtonType.primary,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();

    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: GestureDetector(
        onTap: isEnabled && !isLoading ? onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            gradient: isEnabled
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colors,
                  )
                : null,
            color: isEnabled ? null : Colors.grey[400],
            borderRadius: BorderRadius.circular(28),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: colors.first.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        type == ActionButtonType.primary
                            ? Colors.white
                            : colors.first,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: type == ActionButtonType.secondary
                              ? const Color(0xFF6B48FF)
                              : Colors.white,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: type == ActionButtonType.secondary
                              ? const Color(0xFF6B48FF)
                              : Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  List<Color> _getColors() {
    switch (type) {
      case ActionButtonType.primary:
        return [const Color(0xFF6B48FF), const Color(0xFF8B68FF)];
      case ActionButtonType.secondary:
        return [
          Colors.white.withOpacity(0.9),
          Colors.white.withOpacity(0.7),
        ];
      case ActionButtonType.danger:
        return [const Color(0xFFFF2E63), const Color(0xFFFF5E7C)];
    }
  }
}
