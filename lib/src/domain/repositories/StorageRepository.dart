import 'package:remotestoragelite/src/core/util/values/results/AppResult.dart';

abstract class StorageRepository {
  String get storagePath;

  Future<AppResult> findDirectory();
  Future<AppResult> autoFindDirectory();
}
