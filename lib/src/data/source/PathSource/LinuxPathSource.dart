import 'package:remotestoragelite/src/data/source/PathSource/PathSource.dart';

class LinuxPathSource extends PathSource {
  @override
  Future<String> getSharedDocumentDirectory() {
    return "";
  }
}
