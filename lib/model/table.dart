// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import, depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class Barcode {
  final int id;
  final String code;
  final String data;

  Barcode({this.id, this.code, this.data});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'data': data,
    };
  }

  static Barcode fromMap(Map<String, dynamic> map) {
    return Barcode(
      id: map['id'],
      code: map['code'],
      data: map['data'],
    );
  }

  Future<void> saveBarcode() async {
    final Database db = await openDatabase(
        join(await getDatabasesPath(), 'barcode_database.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE barcodes(id INTEGER PRIMARY KEY, code TEXT, data TEXT)');
    }, version: 1);
    await db.insert('barcodes', toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

// ADICIONADO PARA MOSTRAR OS CÓDIGOS DE BARRAS JÁ SALVOS
  static Future<List<Barcode>> getAllBarcodes() async {
    final Database db = await openDatabase(
        join(await getDatabasesPath(), 'barcode_database.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE barcodes(id INTEGER PRIMARY KEY, code TEXT, data TEXT)');
    }, version: 1);
    final List<Map<String, dynamic>> maps = await db.query('barcodes');
    return List.generate(maps.length, (i) {
      return Barcode(
        id: maps[i]['id'],
        code: maps[i]['code'],
        data: maps[i]['data'],
      );
    });
  }

//ADICIONADO PARA CLEANAR A TABELA.
  static Future<void> deleteAllBarcodes() async {
    final Database db = await openDatabase(
        join(await getDatabasesPath(), 'barcode_database.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE barcodes(id INTEGER PRIMARY KEY, code TEXT, data TEXT)');
    }, version: 1);
    await db.delete('barcodes');
  }
}
