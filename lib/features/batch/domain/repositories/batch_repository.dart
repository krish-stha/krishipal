

import 'package:dartz/dartz.dart';
import 'package:krishipal/core/error/failures.dart';
import 'package:krishipal/features/batch/domain/entities/batch_entity.dart';

abstract interface class IBatchRepository {

  Future<Either<Failure,List<BatchEntity>>> getAllBatches();// parameterless
  Future<Either<Failure,BatchEntity>> getBatchById(String batchId);// parameterized
  Future<Either<Failure,bool>> createBatch(BatchEntity entity);
  Future<Either<Failure, bool>> updateBatch(BatchEntity entity);
  Future<Either<Failure, bool>> deleteBatch(String batchId);

  


}


//Return type : J pani huna sakyo
//parameter jpani huna sakyo
//int add(int a, int b)
// double add(double b)
//generic class
//T add(y)
// successType add(params)