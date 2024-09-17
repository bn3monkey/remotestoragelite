import 'package:remotestoragelite/src/data/source/LocalDataSource/FileLocalDataSourceFactory.dart';
import 'package:remotestoragelite/src/data/source/LocalDataSource/LocalDataSource.dart';

class LocalDataSourceFactory {
  static LocalDataSource create() {
    return FileLocalDataSourceFactory();
  }
}
