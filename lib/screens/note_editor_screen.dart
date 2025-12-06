import 'package:flutter/material.dart';

class NoteEditorScreen extends StatelessWidget {
  final String? initialTitle;
  final String? initialContent;
  
  const NoteEditorScreen({
    super.key,
    this.initialTitle,
    this.initialContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          initialTitle == null ? 'Новая заметка' : 'Редактировать',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1976D2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {}, // Пока без логики
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () {}, // Пока без логики
            tooltip: 'Сохранить',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Поле для заголовка
            TextField(
              decoration: InputDecoration(
                labelText: 'Заголовок',
                labelStyle: const TextStyle(color: Color(0xFF1976D2)),
                hintText: 'Введите заголовок заметки',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF1976D2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF1976D2),
                    width: 2,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            
            const SizedBox(height: 20),
            
            // Поле для содержимого
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Содержимое',
                  labelStyle: const TextStyle(color: Color(0xFF1976D2)),
                  hintText: 'Введите текст заметки...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1976D2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF1976D2),
                      width: 2,
                    ),
                  ),
                ),
                style: const TextStyle(fontSize: 16),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Кнопки действий
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {}, // Пока без логики
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64B5F6),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {}, // Пока без логики
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1976D2)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Отмена',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1976D2),
                      ),
                    ),
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
