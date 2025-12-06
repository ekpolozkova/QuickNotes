import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class QuoteService {
  // Используем рабочий API
  static const String _apiUrl = 'https://api.quotable.io/quotes/random';
  
  // Локальные цитаты как fallback
  final List<Map<String, String>> _localQuotes = [
    {
      'quote': 'Если предали один раз - то это только первый раз. Если предали ещё - то это уже второй',
      'author': 'Конфуций -935 до н.э.',
    },
    {
      'quote': 'Ты живёшь как карта ляжет, пока все живут как Катя скажет',
      'author': 'Сократ 2026 после н.э.',
    },
    {
      'quote': 'Если волк дышит, то волк живой. Если волк не дышит - умер волк',
      'author': 'Уинстон Черчилль',
    },
    {
      'quote': 'Если бы у меня был такой ИИ, я бы может и не женился. Понимаешь, что врёт, но как красиво и заботливо',
      'author': 'Денис Стяжкин 26 ноября 2025 н.э.',
    },
  ];

  Future<Map<String, String>> getRandomQuote() async {
    try {
      // Пробуем новый endpoint
      final response = await http.get(Uri.parse('$_apiUrl?limit=1'));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // API возвращает список, берем первый элемент
        if (data is List && data.isNotEmpty) {
          return {
            'quote': data[0]['content'] ?? 'No quote available',
            'author': data[0]['author'] ?? 'Unknown',
          };
        }
      }
      // Если что-то пошло не так, используем локальные
      throw Exception('API недоступен');
    } catch (e) {
      print('Используем локальную цитату: $e');
      final random = Random();
      return _localQuotes[random.nextInt(_localQuotes.length)];
    }
  }
}
