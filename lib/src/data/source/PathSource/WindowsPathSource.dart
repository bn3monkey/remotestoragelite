import 'package:remotestoragelite/src/data/source/PathSource/PathSource.dart';

class WindowsPathSource extends PathSource {
  @override
  Future<String> getSharedDocumentDirectory() async {
    return "";
  }
}
