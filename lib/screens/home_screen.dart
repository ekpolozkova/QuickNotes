import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QuickNotes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1976D2),
        elevation: 4,
        actions: const [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: null, // Пока без логики
            tooltip: 'О приложении',
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Мои заметки',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
          ),
          
          Expanded(
            child: ListView(
              children: const [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF64B5F6),
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      'Добро пожаловать!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Это ваша первая заметка. Нажмите + чтобы добавить новую.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.edit, color: Color(0xFF1976D2)),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF64B5F6),
                      child: Text(
                        '2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      'Список покупок',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Молоко, хлеб, яйца, фрукты, овощи',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.edit, color: Color(0xFF1976D2)),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF64B5F6),
                      child: Text(
                        '3',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      'Идеи для проекта',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Добавить темную тему\nРеализовать синхронизацию\nЭкспорт заметок',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.edit, color: Color(0xFF1976D2)),
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0xFF64B5F6), width: 1),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                SizedBox(height: 8),
                Text(
                  'Программирование — это не о том, чтобы знать все ответы, а о том, чтобы задавать правильные вопросы.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '— Анонимный разработчик',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null, // Пока без логики
        backgroundColor: Color(0xFF64B5F6),
        child: Icon(Icons.add, color: Colors.white, size: 28),
        elevation: 4,
      ),
    );
  }
}