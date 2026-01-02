
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krishipal/core/error/failures.dart';
import 'package:krishipal/core/usecases/app_usecase.dart';
import 'package:krishipal/features/batch/data/repositories/batch_repository.dart';
import 'package:krishipal/features/batch/domain/entities/batch_entity.dart';
import 'package:krishipal/features/batch/domain/repositories/batch_repository.dart';

class UpdateBatchUsecaseParams extends Equatable{
  final String batchId;
  final String batchName;
  final String? status;

  UpdateBatchUsecaseParams({
    required this.batchId,
    required this.batchName,
     this.status,
  });
  @override
  List<Object?> get props =>[batchId, batchName, status];



}
//usecase
final  UpdateBatchUsecaseProvider = Provider<UpdateBatchUsecase>((ref){
  return UpdateBatchUsecase(batchRepository: ref.read(batchRepositoryProvider));
});



class UpdateBatchUsecase 
implements UsecaseWithParams<bool, UpdateBatchUsecaseParams>{
    final IBatchRepository _batchRepository;

  UpdateBatchUsecase({required IBatchRepository batchRepository})
  : _batchRepository=batchRepository;


  @override
  Future<Either<Failure, bool>> call(UpdateBatchUsecaseParams params) {
  BatchEntity batchEntity= BatchEntity(
    batchId: params.batchId,
    batchName: params.batchName,
    status: params.status,
    );
  return _batchRepository.updateBatch(batchEntity);


    
  }
}