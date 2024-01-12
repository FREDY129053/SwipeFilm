import "package:swipe_film/features/choose_genre/choose_genre.dart";
import "package:swipe_film/features/create_room_screen/create_room.dart";
import "package:swipe_film/features/enter_room_screen/enter_room.dart";
import "package:swipe_film/features/first_screen/first_screen.dart";
import "package:swipe_film/features/main_menu_screen/main_menu.dart";
import "package:swipe_film/features/sign_in_screen/sign_in_screen.dart";
import "package:swipe_film/features/sign_up_screen/sign_up_screen.dart";
import "package:swipe_film/features/film_card/film_card.dart";
import "package:swipe_film/features/anime_card/anime_card.dart";
import "package:swipe_film/features/waiting_room/animation_room.dart";
import "package:swipe_film/features/waiting_room/waiting_room.dart";
import "package:swipe_film/features/easteregg/easteregg.dart";




final routes = {
  // '/': (context) => AnimationRoom(),
   '/': (context) => const FirstScreen(),
  // '/': (context) => const FilmCards(),
  // '/': (context) => const WaitingRoom(),
  //'/': (context) => const ChooseGenre(),
  '/sign_in': (context) => const SignIn(),
  '/sign_up': (context) => const SignUp(),
  '/main': (context) => const MainMenu(),
  '/create_room': (context) => const CreateRoom(),
  '/enter_room': (context) => const EnterRoom(),
  '/choose_genre': (context) => const ChooseGenre(),
  '/film_card': (context) => FilmCards(),
  '/anime_card': (context) => const AnimeCard(),
  // '/waiting_room': (context) => const WaitingRoom(),
  '/waiting_room': (context) => const AnimationRoom(),
  // '/animation_room': (context) => AnimationRoom(),
  '/easteregg': (context) => const EasterEgg(),
};
