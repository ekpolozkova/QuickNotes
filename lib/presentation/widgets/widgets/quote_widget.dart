import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  final String quote;
  final String author;
  final VoidCallback onRefresh;

  const QuoteWidget({
    super.key,
    this.quote = 'Программирование — это не о том, чтобы знать все ответы, '
        'а о том, чтобы задавать правильные вопросы.',
    this.author = 'Анонимный разработчик',
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF64B5F6), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Color(0xFF1976D2)),
                  SizedBox(width: 8),
                  Text(
                    'Цитата дня',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Color(0xFF1976D2)),
                onPressed: onRefresh,
                iconSize: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            quote,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— $author',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}