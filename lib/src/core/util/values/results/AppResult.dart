enum AppResult {
  success(0),

  cannotAccessDirectory(-10),
  cannotCreateRemoteStorageDirectory(-20);

  final int code;
  const AppResult(this.code);

  static AppResult parse(int code) {
    return AppResult.values.firstWhere((element) => element.code == code);
  }
}
