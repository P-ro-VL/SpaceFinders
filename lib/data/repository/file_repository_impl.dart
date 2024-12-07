import 'dart:typed_data';

import 'package:either_dart/src/either.dart';
import 'package:spacefinder/data/datasource/file_data_source.dart';

import 'package:spacefinder/network/failure_entity.dart';

import '../../domain/repository/file_repository.dart';

class FileRepositoryImpl extends FileRepository {
  final FileDataSource dataSource;

  FileRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureEntity, String>> uploadFile(
      Uint8List bytes, String fileName) async {
    final response = await dataSource.uploadFile(bytes, fileName);
    return Either.cond(response != null, FailureEntity(), response ?? '');
  }
}
