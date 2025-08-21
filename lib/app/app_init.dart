import 'package:ensake/utils/storage.dart';
import 'package:flutter/widgets.dart';

import 'dependency_inj.dart';

class AppInit {
  static Future<void> preRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDependencyInj();
    await instance<Storage>().initStorage();
  }
}
