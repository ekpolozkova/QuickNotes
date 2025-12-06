class Note {
  final String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // Конструктор для новой заметки
  Note.newNote({
    required this.title,
    required this.content,
  })  : id = DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  // Конструктор для демо-заметок
  Note.demo(int index)
      : id = index.toString(),
        title = 'Заметка $index',
        content = 'Это демонстрационная заметка номер $index. '
                  'Вы можете редактировать её содержимое.',
        createdAt = DateTime.now().subtract(Duration(days: index)),
        updatedAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}