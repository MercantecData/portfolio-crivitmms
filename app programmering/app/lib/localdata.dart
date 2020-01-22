import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';


class LocalStorage{

  final String fileName;

  LocalStorage(this.fileName);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  void test() async {
    print(await _localFile);
  }

  Future<String> read() async {
    String str;
    File file = await _localFile;
    try {
       str = await file.readAsString();
    } catch (e) {
      return "";
    }
    return str;
  }

  Future<File> write(String str) async {
    File file = await _localFile;
    return file.writeAsString(str);
  }




}




















