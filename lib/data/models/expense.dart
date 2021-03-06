import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final DateTime date;
  final String userId;
  final double price;
  final IconData icon;

  Expense({
    required this.id,
    required this.title,
    required this.date,
    required this.userId,
    required this.price,
    required this.icon,
  });
}
