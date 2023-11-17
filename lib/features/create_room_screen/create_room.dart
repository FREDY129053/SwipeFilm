import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<CreateRoom> {
  int numberOfPeople = 1;
  bool _obscureText = true;
  String title = 'Фильм';
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF5F0E1),
        body: Transform.translate(
          offset: Offset(0, -180),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, -60),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        child: SvgPicture.asset('assets/svg/mainmenu_star1.svg'),
                      ),
                      Transform.translate(
                        offset: Offset(0, 65),
                        child: Text(
                          "Создать\nкомнату",
                          style: GoogleFonts.raleway(
                            color: Color(0xFF873B31),
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 22.0), // Значение отступа можно изменить под свои нужды
                            child: Text(
                              "Сколько человек?",
                              style: GoogleFonts.raleway(
                                color: Color(0xFF873B31),
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            5,
                                (index) {
                              int i = index + 1;
                              return Expanded(
                                child: Row(
                                  children: [
                                    Radio<int>(
                                      value: i,
                                      groupValue: numberOfPeople,
                                      onChanged: (value) {
                                        setState(() {
                                          numberOfPeople = value!;
                                        });
                                      },
                                    ),
                                    Text(i == 5 ? '5' : i.toString())
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Что будете смотреть",
                            style: GoogleFonts.raleway(
                              color: Color(0xFF873B31),
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        for (var t in ['Фильм', 'Сериал', 'Аниме'])
                          RadioListTile<String>(
                            title: Text(t),
                            value: t,
                            groupValue: title,
                            onChanged: (String? value) {
                              setState(() {
                                title = value!;
                              });
                            },
                          ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 22.0), // Значение отступа можно изменить под свои нужды
                            child: Text(
                              "Придумайте пароль",
                              style: GoogleFonts.raleway(
                                color: Color(0xFF873B31),
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF8F6),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(184, 9, 72, 0.15),
                                blurRadius: 19,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            obscureText: true,
                            obscuringCharacter: "*",
                            style: TextStyle(
                                color: Color.fromRGBO(186, 151, 161, 1)),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.remove_red_eye),
                                suffixIconColor: Color.fromRGBO(186, 151, 161, 1),
                                fillColor: Color.fromRGBO(255, 248, 246, 1),
                                filled: true,
                                hintText: 'Введите пароль',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(186, 151, 161, 1)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                          },
                          child: Text(
                            "СОЗДАТЬ КОМНАТУ",
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(12), // Здесь указывается отступ
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7AA6FF)),
                            elevation: MaterialStateProperty.all<double>(0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
