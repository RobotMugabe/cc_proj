import 'dart:convert';
import 'dart:io';

import 'package:cc_assessment/models/base_class.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseRepo<T extends BaseClass> {
  String fileName;

  BaseRepo(this.fileName);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get loadFile async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<bool> writeJson(dynamic json) async {
    final file = await loadFile;
    try {
      await file.writeAsString(
        jsonEncode(json),
        mode: FileMode.write
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<dynamic>> readData() async {
    try {
      final File file = await loadFile;
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      return jsonDecode(contents) as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  Future<bool> addClass(T addClass);

  Future<void> deleteClass(T removeClass);

  Future<void> loadClasses();
}
