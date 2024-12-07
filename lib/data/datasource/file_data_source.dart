import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FileDataSource {
  Future<String?> uploadFile(Uint8List bytes, String fileName);
}

class FileDataSourceImpl extends FileDataSource {
  final client = Supabase.instance.client;

  @override
  Future<String?> uploadFile(Uint8List bytes, String fileName) async {
    final response = await client.storage
        .from('spacefinder-cdn')
        .uploadBinary(fileName, bytes);
    return response;
  }
}
