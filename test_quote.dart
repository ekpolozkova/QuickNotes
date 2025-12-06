import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('Тестируем API цитат...');
  try {
    final response = await http.get(Uri.parse('https://api.quotable.io/random'));
    print('Статус: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Цитата: ${data['content']}');
      print('Автор: ${data['author']}');
    }
  } catch (e) {
    print('Ошибка: $e');
  }
}
