import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isExpense = transaction.amount.startsWith('-');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF1B5E20).withOpacity(0.08),
          child: Icon(Icons.attach_money, color: const Color(0xFF2E7D32)),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B5E20),
          ),
        ),
        subtitle: Text(
          transaction.category,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Text(
          transaction.amount,
          style: TextStyle(
            color: isExpense ? Colors.red.shade400 : const Color(0xFF1B5E20),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
