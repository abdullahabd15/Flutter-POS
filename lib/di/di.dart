import 'package:core/di/di.dart';
import 'package:pos/di/di.dart';

class DependencyInjection {
  void init() {
    CoreModule();
    PosModule();
  }
}