import 'dart:convert';
import 'dart:io';

import '../logging/logger.dart';

class FileHelper {
  static String getBase64FormatedFile(String path) {
    File file = File(path);
    Log.d('File is = $file');
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }

  // static List<int> getBinaryFormateFile(String path) {
  //   File file = File(path);
  //   print('File is = ' + file.toString());
  //   List<int> fileInByte = file.readAsBytesSync();
  //   return fileInByte;
  // }

}