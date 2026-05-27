import 'package:flutter/material.dart';

class PaperButton extends StatelessWidget {
  const PaperButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            width: 1.2,
          ),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );

    return expanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
