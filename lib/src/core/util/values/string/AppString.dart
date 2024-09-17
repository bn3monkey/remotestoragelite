class AppString {
  // Final variables for the text
  final String storagePathName;
  final String autoFind;
  final String find;

  final String ipAddress;
  final String port;
  final String findIpAddress;
  final String openConnection;
  final String closeConnection;

  final String infoCreateFile;
  final String infoWriteFile;
  final String infoCloseFile;

  final String infoClientConnectionOver;

  final String errorCannotFindIpAddress;
  final String errorCannotAccessDirectory;
  final String errorCannotCreateRemoteStorageDirectory;
  final String errorCannotOpenServer;
  final String errorPortIsInvalid;

  final String errorStreamError;

  // 생성자를 통해 모든 값을 외부에서 받도록 수정
  const AppString(
      {required this.storagePathName,
      required this.autoFind,
      required this.find,
      required this.ipAddress,
      required this.port,
      required this.findIpAddress,
      required this.openConnection,
      required this.closeConnection,
      required this.infoCreateFile,
      required this.infoWriteFile,
      required this.infoCloseFile,
      required this.infoClientConnectionOver,
      required this.errorCannotFindIpAddress,
      required this.errorCannotAccessDirectory,
      required this.errorCannotCreateRemoteStorageDirectory,
      required this.errorCannotOpenServer,
      required this.errorPortIsInvalid,
      required this.errorStreamError});

  // 언어에 따라 인스턴스를 생성하는 팩토리 메서드
  static AppString of(String localization) {
    switch (localization) {
      case "ko-kr":
        return const AppString(
            storagePathName: "알림장 데이터 저장 경로",
            autoFind: "경로 자동 지정",
            find: "경로 사용자 지정",
            ipAddress: "IP 주소",
            port: "포트 번호 (변경 가능)",
            findIpAddress: "IP 주소 찾기",
            openConnection: "서버 열기",
            closeConnection: "서버 닫기",
            infoCreateFile: "파일을 받기 시작합니다...",
            infoWriteFile: "파일을 받는 중입니다...",
            infoCloseFile: "파일 받기가 완료되었습니다...",
            infoClientConnectionOver: "클라이언트와 연결이 종료되었습니다.",
            errorCannotFindIpAddress: 'IP 주소를 찾을 수 없습니다.',
            errorCannotAccessDirectory: '지정한 디렉토리에 접근할 수 없습니다.',
            errorCannotCreateRemoteStorageDirectory:
                '원격 저장소로 사용할 디렉토리를 생성할 수 없습니다.',
            errorCannotOpenServer: "서버를 열 수 없습니다.",
            errorPortIsInvalid: "포트가 유효하지 않습니다. 정수로 입력해주세요!",
            errorStreamError: "데이터 송수진 중 에러가 발생했습니다.");
      default:
        return const AppString(
            storagePathName: "School Notifier Data Storage Path",
            autoFind: "Find Path Automatically",
            find: "Find Path Manually",
            ipAddress: "IP Address",
            port: "Port Number (Changable)",
            findIpAddress: "Find IP Address",
            openConnection: "Open Connection",
            closeConnection: "Close Connection",
            infoCreateFile: "Receiving File...",
            infoWriteFile: "Receiving File Data... ",
            infoCloseFile: "Complete to receive File Data...",
            infoClientConnectionOver: "Connection with Client is over.",
            errorCannotFindIpAddress: 'IP Address cannot be found',
            errorCannotAccessDirectory: 'Directory cannot be accessed',
            errorCannotCreateRemoteStorageDirectory:
                'Cannot create remote storage directory.',
            errorCannotOpenServer: "Cannot open the server",
            errorPortIsInvalid:
                "Port number is not valid. Please enter as integer!",
            errorStreamError: "Stream Error");
    }
  }
}
