import 'package:krishipal/features/batch/data/models/batch_hive_model.dart';

abstract interface class IBatchDatasource {
  Future<List<BatchHiveModel>> getAllBatches();
  Future<BatchHiveModel?> getBatchById(String batchId);
  Future<bool> createBatch(BatchHiveModel model);
  Future<bool> updateBatch(BatchHiveModel model);
  Future<bool> deleteBatch(String batchId);
}
