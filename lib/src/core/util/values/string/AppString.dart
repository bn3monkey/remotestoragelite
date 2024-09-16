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

  final String errorCannotFindIpAddress;

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
      required this.errorCannotFindIpAddress});

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
            errorCannotFindIpAddress: 'IP 주소를 찾을 수 없습니다.');
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
            errorCannotFindIpAddress: 'IP Address cannot be found');
    }
  }
}
