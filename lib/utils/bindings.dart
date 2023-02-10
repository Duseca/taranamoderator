import 'package:get/get.dart';
import 'package:taranamoderator/controllers/root_controller.dart';
import 'package:taranamoderator/controllers/signup_controller.dart';
import 'package:taranamoderator/controllers/songlyrics_controller.dart';
import '../controllers/splash_controller.dart';
import '../controllers/login_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>LoginController());
  }
}

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>SignupController());
  }
}

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>RootController());
  }
}

class SongLyricsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>SongLyricsController());
  }
}