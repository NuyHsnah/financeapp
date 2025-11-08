import 'package:flutter/material.dart';

class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String balance;
  final Color color1;
  final Color color2;

  const AtmCard({
    super.key,
    required this.bankName,
    required this.cardNumber,
    required this.balance,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.28),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: bank name + chip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bankName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                // small stylized chip
                Container(
                  width: 44,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.credit_card,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Card number
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            // Balance label + amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      balance,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // subtle circular logo
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.14),
                  ),
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
