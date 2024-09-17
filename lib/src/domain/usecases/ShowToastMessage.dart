import 'package:logger/logger.dart';
import 'package:remotestoragelite/src/domain/repositories/ToastMessageRepository.dart';

class ShowToastMessage {
  final ToastMessageRepository toastMessageRepository;
  ShowToastMessage({required this.toastMessageRepository});

  Stream<String> link() {
    return toastMessageRepository.message.stream.map((event) {
      Logger().d("New Toast Message : $event");
      return event;
    });
  }

  void call(String newMessage) {
    toastMessageRepository.message.sink.add(newMessage);
  }
}
