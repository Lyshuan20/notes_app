import 'dart:io';
import 'package:notes_app/model/model_notes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  static late Database _db;

  static Future<void> initialiseDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();

    String databasePath = appDirectory.path + "notes.db";

    _db = await openDatabase(databasePath, version: 1,
        onCreate: (db, version) async {
      // - Tabla Notas
      await db.execute(
          'CREATE TABLE Notes(id INTEGER PRIMARY KEY, titulo TEXT, descripcion TEXT, fecha TEXT)');
    });
  }

  //----- METODOS PARA NOTAS -----
  static Future<List<NotesModel>> getDataFromDatabase() async {
    final result = await _db.query("Notes");

    List<NotesModel> notesModel =
        result.map((e) => NotesModel.fromJson(e)).toList();

    return notesModel;
  }

  //---
  static Future<void> insertData(NotesModel model) async {
    // ignore: unused_local_variable
    final result = await _db.insert("Notes", model.toJson());
  }

  //---
  static Future<void> deleteDataFromDatabase(String fecha) async {
    // ignore: unused_local_variable
    final result = await _db.delete("Notes", where: "fecha = ?", whereArgs: [fecha]);
  }

  //---
  static Future<void> updateDataInDatabase(
      NotesModel model, String fecha) async {
        // ignore: unused_local_variable
    final result = await _db.update("Notes", model.toJson(),
        where: "fecha = ?", whereArgs: [fecha]);
  }
}
