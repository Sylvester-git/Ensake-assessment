import 'package:flutter/widgets.dart';

import 'dependency_inj.dart';

class AppInit {
  static void preRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDependencyInj();
  }
}
