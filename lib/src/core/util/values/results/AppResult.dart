enum AppResult {
  success(0),

  fileCreate(10),
  fileWrite(20),
  fileClose(30),

  cannotAccessDirectory(-10),
  cannotCreateRemoteStorageDirectory(-20),

  errorSocketRead(-100);

  final int code;
  const AppResult(this.code);

  static AppResult parse(int code) {
    return AppResult.values.firstWhere((element) => element.code == code);
  }
}
