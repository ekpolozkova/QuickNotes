import 'package:flutter/material.dart';
import 'note_editor_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Список заметок (пока в памяти)
  final List<Map<String, String>> _notes = [
    {
      'id': '1',
      'title': 'Добро пожаловать!',
      'content': 'Это ваша первая заметка. Нажмите + чтобы добавить новую.',
    },
    {
      'id': '2',
      'title': 'Список покупок',
      'content': 'Молоко, хлеб, яйца, фрукты, овощи',
    },
    {
      'id': '3',
      'title': 'Идеи для проекта',
      'content': 'Добавить темную тему\nРеализовать синхронизацию\nЭкспорт заметок',
    },
  ];

  // Цитата дня
  String _quote = 'Программирование — это не о том, чтобы знать все ответы, а о том, чтобы задавать правильные вопросы.';
  String _author = 'Анонимный разработчик';

  // Обновить цитату (заглушка для ЛР5)
  void _refreshQuote() {
    setState(() {
      _quote = 'Успех — это движение от неудачи к неудаче без потери энтузиазма.';
      _author = 'Уинстон Черчилль';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Цитата обновлена!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Добавить новую заметку
  void _addNewNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteEditorScreen(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _notes.add({
          'id': (_notes.length + 1).toString(),
          'title': result['title']!,
          'content': result['content']!,
        });
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заметка добавлена!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Редактировать заметку
  void _editNote(int index) async {
    final note = _notes[index];
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(
          initialTitle: note['title'],
          initialContent: note['content'],
        ),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        _notes[index] = {
          'id': note['id']!,
          'title': result['title']!,
          'content': result['content']!,
        };
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заметка обновлена!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Удалить заметку
  void _deleteNote(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить заметку?'),
        content: Text('Вы уверены, что хотите удалить заметку "${_notes[index]['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notes.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Заметка удалена!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
            tooltip: 'О приложении',
          ),
        ],
      ),
      body: Column(
        children: [
          // Заголовок секции
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
          
          // Список заметок
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF64B5F6),
                      child: Text(
                        note['id']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      note['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      note['content']!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Color(0xFF1976D2)),
                      onPressed: () => _editNote(index),
                    ),
                    onTap: () => _editNote(index),
                    onLongPress: () => _deleteNote(index),
                  ),
                );
              },
            ),
          ),
          
          // Цитата дня
          Container(
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
                      onPressed: _refreshQuote,
                      iconSize: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _quote,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '— $_author',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        backgroundColor: const Color(0xFF64B5F6),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
        elevation: 4,
      ),
    );
  }
}