import 'dart:io';

import 'package:remotestoragelite/src/data/source/PathSource/AndroidPathSource.dart';
import 'package:remotestoragelite/src/data/source/PathSource/LinuxPathSource.dart';
import 'package:remotestoragelite/src/data/source/PathSource/PathSource.dart';
import 'package:remotestoragelite/src/data/source/PathSource/WindowsPathSource.dart';

class PathSourceFactory {
  static PathSource create() {
    if (Platform.isWindows) {
      return WindowsPathSource();
    } else if (Platform.isAndroid) {
      return AndroidPathSource();
    } else if (Platform.isLinux) {
      return LinuxPathSource();
    }

    throw UnimplementedError();
  }
}
