import 'package:flutter/material.dart';

class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const GridMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF81C784).withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF1B5E20).withOpacity(0.08),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF1B5E20).withOpacity(0.12),
              child: Icon(icon, color: const Color(0xFF2E7D32), size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
