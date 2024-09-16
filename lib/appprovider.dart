import 'package:provider/provider.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/DirectoryViewModel.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/NetworkConnectionViewModel.dart';
import 'package:remotestoragelite/src/presentation/viewmodel/ToastMessageViewModel.dart';

class AppProvider extends MultiProvider {
  AppProvider({super.key, super.child})
      : super(providers: [
          // ViewModel
          ChangeNotifierProvider(create: (context) => DirectoryViewModel()),
          ChangeNotifierProvider(
              create: (context) => NetworkConnectionViewModel()),

          ChangeNotifierProvider(create: (context) => ToastMessageViewModel()),
        ]);
}
