import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/models/game/types.dart';
import 'package:shinro_int2/screens/game/game_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/type_play_card.dart';
import 'components/info_user_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinro_int2/constant/shared_preferences.dart'
    as SHARED_PREFERNCES;

class GameHomePage extends StatefulWidget {
  @override
  _GameHomePageState createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  SwiperController swiperController = SwiperController();
  bool logined;
  String displayName;
  List<Types> types = [
    Types(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Competition',
      'assets/background.png',
    ),
    Types(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Practice',
      'assets/background.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    logined = false;
    checkLogin();
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey(SHARED_PREFERNCES.first_launch);
    if (checkValue) {
      logined = prefs.getBool(SHARED_PREFERNCES.logined);
    }

    if (logined) {
      setState(() {
        displayName = prefs.getString(SHARED_PREFERNCES.displayName);
        print(displayName);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Widget checkOutButton = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => GameRoomPage())),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Start Game",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InfoUserItem(displayName),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Play Type',
                style: TextStyle(
                    fontSize: 20, color: darkGrey, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              child: Swiper(
                itemCount: types.length,
                itemBuilder: (_, index) {
                  return TypePlayCard(types[index]);
                },
                scale: 0.8,
                controller: swiperController,
                viewportFraction: 0.6,
                loop: false,
                fade: 0.7,
              ),
            ),
            SizedBox(height: 24),
            Center(
                child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom == 0
                      ? 20
                      : MediaQuery.of(context).padding.bottom),
              child: checkOutButton,
            ))
          ],
        ),
      ),
    );
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    LinearGradient grT = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
