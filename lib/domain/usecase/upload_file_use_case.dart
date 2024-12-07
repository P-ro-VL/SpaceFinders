import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:spacefinder/network/failure_entity.dart';
import 'package:spacefinder/network/use_case.dart';

import '../repository/file_repository.dart';

class UploadFileUseCase
    extends UseCase<Either<FailureEntity, String>, UploadFileParams> {
  final FileRepository repository;

  UploadFileUseCase(this.repository);

  @override
  Future<Either<FailureEntity, String>> call(UploadFileParams params) async {
    return await repository.uploadFile(params.bytes!, params.fileName!);
  }
}

class UploadFileParams {
  final Uint8List? bytes;
  final String? fileName;

  UploadFileParams({
    this.bytes,
    this.fileName,
  });
}
