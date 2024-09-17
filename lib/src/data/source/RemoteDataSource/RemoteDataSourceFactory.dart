import 'package:remotestoragelite/src/data/source/RemoteDataSource/RemoteDataSource.dart';
import 'package:remotestoragelite/src/data/source/RemoteDataSource/SimpleSocketRemoteDataSource.dart';

class RemoteDataSourceFactory {
  static RemoteDataSource create() {
    return SimpleSocketRemoteDataSource();
  }
}
