import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class NoteRepository {
  static const String _notesKey = 'notes';

  Future<List<Note>> getAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getStringList(_notesKey) ?? [];
    
    return notesJson
        .map((json) => Note.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getAllNotes();
    
    final existingIndex = notes.indexWhere((n) => n.id == note.id);
    
    if (existingIndex >= 0) {
      notes[existingIndex] = note;
    } else {
      notes.add(note);
    }
    
    await _saveAllNotes(notes);
  }

  Future<void> deleteNote(String id) async {
    final notes = await getAllNotes();
    notes.removeWhere((note) => note.id == id);
    await _saveAllNotes(notes);
  }

  Future<void> _saveAllNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = notes
        .map((note) => jsonEncode(note.toJson()))
        .toList()
        .cast<String>();
    
    await prefs.setStringList(_notesKey, notesJson);
  }
}
