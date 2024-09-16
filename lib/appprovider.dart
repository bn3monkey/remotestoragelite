import 'package:provider/provider.dart';
import 'package:remotestoragelite/src/data/repositories/NetworkConnectionRepositoryImpl.dart';
import 'package:remotestoragelite/src/data/repositories/StorageRepositoryImpl.dart';
import 'package:remotestoragelite/src/data/repositories/ToastMessageRepositoryImpl.dart';
import 'package:remotestoragelite/src/domain/repositories/NetworkConnectionRepository.dart';
import 'package:remotestoragelite/src/domain/repositories/StorageRepository.dart';
import 'package:remotestoragelite/src/domain/repositories/ToastMessageRepository.dart';
import 'package:remotestoragelite/src/domain/usecases/AutoFindStoragePath.dart';
import 'package:remotestoragelite/src/domain/usecases/CloseNetworkConnection.dart';
import 'package:remotestoragelite/src/domain/usecases/FindIpAddress.dart';
import 'package:remotestoragelite/src/domain/usecases/FindStoragePath.dart';
import 'package:remotestoragelite/src/domain/usecases/LoadPort.dart';
import 'package:remotestoragelite/src/domain/usecases/OpenNetworkConnection.dart';
import 'package:remotestoragelite/src/domain/usecases/SavePort.dart';
import 'package:remotestoragelite/src/domain/usecases/ShowToastMessage.dart';
import 'package:remotestoragelite/src/domain/usecases/UpdateDirectory.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/DirectoryViewModel.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/NetworkConnectionViewModel.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/ToastMessageViewModel.dart';

class AppProvider extends MultiProvider {
  AppProvider({super.key, super.child})
      : super(providers: [
          // Repository
          Provider<StorageRepository>(create: (_) => StorageRepositoryImpl()),
          Provider<NetworkConnectionRepository>(
              create: (_) => NetworkConnectionRepositoryImpl()),
          Provider<ToastMessageRepository>(
              create: (_) => ToastMessageRepositoryImpl()),

          // UseCase
          Provider(
              create: (context) => ShowToastMessage(
                  toastMessageRepository: Provider.of<ToastMessageRepository>(
                      context,
                      listen: false))),
          Provider(
              create: (context) => SavePort(
                  networkConnectionRepository:
                      Provider.of<NetworkConnectionRepository>(context,
                          listen: false))),
          Provider(
              create: (context) => LoadPort(
                  networkConnectionRepository:
                      Provider.of<NetworkConnectionRepository>(context,
                          listen: false))),
          Provider(
              create: (context) => FindIpAddress(
                  networkConnectionRepository:
                      Provider.of<NetworkConnectionRepository>(context,
                          listen: false),
                  showToastMessage:
                      Provider.of<ShowToastMessage>(context, listen: false))),
          Provider(
            create: (context) => OpenNetworkConnection(
                networkConnectionRepository:
                    Provider.of<NetworkConnectionRepository>(context,
                        listen: false),
                showToastMessage:
                    Provider.of<ShowToastMessage>(context, listen: false)),
          ),
          Provider(
            create: (context) => CloseNetworkConnection(
                networkConnectionRepository:
                    Provider.of<NetworkConnectionRepository>(context,
                        listen: false),
                showToastMessage:
                    Provider.of<ShowToastMessage>(context, listen: false)),
          ),
          Provider(
              create: (context) => AutoFindStoragePath(
                  storageRepository:
                      Provider.of<StorageRepository>(context, listen: false),
                  showToastMessage: ShowToastMessage(
                      toastMessageRepository:
                          Provider.of<ToastMessageRepository>(context,
                              listen: false)))),
          Provider(
              create: (context) => FindStoragePath(
                  storageRepository:
                      Provider.of<StorageRepository>(context, listen: false),
                  showToastMessage: ShowToastMessage(
                      toastMessageRepository:
                          Provider.of<ToastMessageRepository>(context,
                              listen: false)))),
          Provider(
              create: (context) => UpdateDirectory(
                  storageRepository:
                      Provider.of<StorageRepository>(context, listen: false))),

          // ViewModel
          ChangeNotifierProvider(
              create: (context) => DirectoryViewModel(
                    autoFindStoragePath: Provider.of<AutoFindStoragePath>(
                        context,
                        listen: false),
                    findStoragePath:
                        Provider.of<FindStoragePath>(context, listen: false),
                    updateDirectory:
                        Provider.of<UpdateDirectory>(context, listen: false),
                  )),
          ChangeNotifierProvider(
              create: (context) => NetworkConnectionViewModel(
                  findIpAddress:
                      Provider.of<FindIpAddress>(context, listen: false),
                  savePort: Provider.of<SavePort>(context, listen: false),
                  loadPort: Provider.of<LoadPort>(context, listen: false),
                  openNetworkConnection: Provider.of<OpenNetworkConnection>(
                      context,
                      listen: false),
                  closeNetworkConnection: Provider.of<CloseNetworkConnection>(
                      context,
                      listen: false))),

          ChangeNotifierProvider(
              create: (context) => ToastMessageViewModel(
                  showToastMessage:
                      Provider.of<ShowToastMessage>(context, listen: false))),
        ]);
}
