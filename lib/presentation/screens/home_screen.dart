import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/note.dart';
import '../../data/services/quote_service.dart';
import '../providers/notes_provider.dart';
import 'note_editor_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuoteService _quoteService = QuoteService();
  String _quote = 'Загрузка цитаты...';
  String _author = '';
  bool _isLoadingQuote = false;

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  Future<void> _loadQuote() async {
    setState(() {
      _isLoadingQuote = true;
    });
    
    try {
      final quoteData = await _quoteService.getRandomQuote();
      setState(() {
        _quote = quoteData['quote']!;
        _author = quoteData['author']!;
      });
    } catch (e) {
      setState(() {
        _quote = 'Не удалось загрузить цитату. Проверьте подключение к интернету.';
        _author = 'Система';
      });
    } finally {
      setState(() {
        _isLoadingQuote = false;
      });
    }
  }

  void _refreshQuote() {
    _loadQuote();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Цитата обновлена!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _addNewNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteEditorScreen(),
      ),
    );

    if (result != null && result is Note) {
      final provider = Provider.of<NotesProvider>(context, listen: false);
      await provider.addNote(result);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заметка добавлена!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _editNote(Note note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note),
      ),
    );

    if (result != null && result is Note) {
      final provider = Provider.of<NotesProvider>(context, listen: false);
      await provider.updateNote(result);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заметка обновлена!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _deleteNote(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить заметку?'),
        content: const Text('Вы уверены, что хотите удалить эту заметку?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              final provider = Provider.of<NotesProvider>(context, listen: false);
              await provider.deleteNote(id);
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
    final notesProvider = Provider.of<NotesProvider>(context);

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
      body: notesProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                  child: notesProvider.notes.isEmpty
                      ? const Center(
                          child: Text(
                            'Нет заметок\nНажмите + чтобы добавить',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: notesProvider.notes.length,
                          itemBuilder: (context, index) {
                            final note = notesProvider.notes[index];
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
                                    (index + 1).toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  note.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  note.content,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit, color: Color(0xFF1976D2)),
                                  onPressed: () => _editNote(note),
                                ),
                                onTap: () => _editNote(note),
                                onLongPress: () => _deleteNote(note.id),
                              ),
                            );
                          },
                        ),
                ),
                
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
                            icon: _isLoadingQuote
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Icon(Icons.refresh, color: Color(0xFF1976D2)),
                            onPressed: _isLoadingQuote ? null : _refreshQuote,
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
