import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:spacefinder/network/failure_entity.dart';

abstract class FileRepository {
  Future<Either<FailureEntity, String>> uploadFile(
      Uint8List bytes, String fileName);
}
