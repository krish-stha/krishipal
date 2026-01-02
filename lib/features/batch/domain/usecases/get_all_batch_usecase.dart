import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krishipal/core/error/failures.dart';
import 'package:krishipal/features/batch/data/repositories/batch_repository.dart';
import 'package:krishipal/core/usecases/app_usecase.dart';
import 'package:krishipal/features/batch/domain/entities/batch_entity.dart';

import 'package:krishipal/features/batch/domain/repositories/batch_repository.dart';

final getAllBatchUsecaseProvider = Provider<GetAllBatchUsecase>((ref) {
  return GetAllBatchUsecase(batchRepository: ref.read(batchRepositoryProvider));
});

class GetAllBatchUsecase implements UsecaseWithoutParams<List<BatchEntity>> {
  final IBatchRepository _batchRepository;

  GetAllBatchUsecase({required IBatchRepository batchRepository})
    : _batchRepository = batchRepository = batchRepository;

  @override
  Future<Either<Failure, List<BatchEntity>>> call() {
    return _batchRepository.getAllBatches();
  }
}
