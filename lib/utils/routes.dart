import 'package:get/get.dart';
import 'package:taranamoderator/views/signup.dart';
import '../views/login.dart';
import '../views/root.dart';
import '../views/song_lyrics.dart';
import 'bindings.dart';
import '../views/splash.dart';

class Routes {
  static List<GetPage> all = [
    GetPage(name: "/", page: () => const Splash(), binding: SplashBinding()),
    GetPage(name: "/login", page: () => const Login(), binding: LoginBinding()),
    GetPage(name: "/signup", page: () => const Signup(), binding: SignupBinding()),
    GetPage(name: "/root", page: () => const Root(), binding: RootBinding()),
    GetPage(name: "/song_lyrics", page: () => const SongLyrics(), binding: SongLyricsBinding()),
  ];
}
