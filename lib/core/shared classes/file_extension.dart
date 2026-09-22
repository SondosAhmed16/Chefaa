import 'dart:io';

import 'package:dio/dio.dart';

extension FileToMultipart on File {
  Future<MultipartFile> toMultipart() async {
    return await MultipartFile.fromFile(path, filename: path.split('/').last);
  }
}
