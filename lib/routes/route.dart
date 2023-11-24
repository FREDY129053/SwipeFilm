import "package:swipe_film/features/create_room_screen/create_room.dart";
import "package:swipe_film/features/enter_room_screen/enter_room.dart";
import "package:swipe_film/features/first_screen/first_screen.dart";
import "package:swipe_film/features/main_menu_screen/main_menu.dart";
import "package:swipe_film/features/sign_in_screen/sign_in_screen.dart";
import "package:swipe_film/features/sign_up_screen/sign_up_screen.dart";


final routes = {
  '/': (context) => const FirstScreen(),
  '/sign_in': (context) => const SignIn(),
  '/sign_up': (context) => const SignUp(),
  '/main': (context) => const MainMenu(),
  '/create_room': (context) => const CreateRoom(),
  '/enter_room': (context) => const EnterRoom(),
};