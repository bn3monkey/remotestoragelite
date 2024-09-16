import 'package:path_provider/path_provider.dart';
import 'package:remotestoragelite/src/data/source/PathSource/PathSource.dart';

class AndroidPathSource extends PathSource {
  @override
  Future<String> getSharedDocumentDirectory() async {
    return "";
  }
}
