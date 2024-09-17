import 'package:remotestoragelite/src/data/source/PathSource/PathSource.dart';

class AndroidPathSource extends PathSource {
  @override
  Future<String> getSharedDocumentDirectory() async {
    return "";
  }
}
