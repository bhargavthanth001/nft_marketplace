import 'package:flutter/cupertino.dart';
import 'package:metamask/metamask.dart';

class MetaMaskProvider extends ChangeNotifier {
  int currentChain = -1;
  String currentAddress = "";
  static const operatingChain = 4;

  bool get isEnabled => ethereum != null;

  bool get inOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;
      currentChain = await ethereum!.getChainId();
      notifyListeners();
    }
  }

// init() {
//   if (isEnabled) {
//     ethereum!.onAccountChanged((accounts) {
//       clear();
//     });
//   }
// }
}
