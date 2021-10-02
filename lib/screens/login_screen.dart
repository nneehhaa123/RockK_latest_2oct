import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'dart:io';
import 'dart:math';
import '../screens/splash_screen.dart';
import '../screens/products_overview_screen.dart';
import '../providers/auth.dart';
import '../providers/guest.dart';
//import '../providers/products.dart';
import '../screens/auth_screen.dart';
import '../screens/kiaansh_party_screen.dart';
//import './screens/video_play_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/ML_form_screen.dart';
import '../screens/create_party_screen.dart';
import '../screens/bp_screen.dart';
import '../screens/intro_screen.dart';
import '../screens/milestone_screen.dart';
import '../screens/add_wishes_screen.dart';
import '../screens/how_use_screen.dart';
import '../screens/fav_screen.dart';
import '../screens/dislike_screen.dart';
import '../screens/wip_screen.dart';
import '../screens/first_page.dart';
import '../screens/guest_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget build(BuildContext context) {
    //timeDilation = 5.0; // 1.0 means normal animation speed.
    final deviceSize = MediaQuery.of(context).size;
    var allRoute = {
      //'/': (ctx) => KiaParty(),
      //ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
      KiaParty.routeName: (ctx) => KiaParty(),
      AddWishesScreen.routeName: (ctx) => AddWishesScreen(),
      OrdersScreen.routeName: (ctx) => OrdersScreen(),
      MLformScreen.routeName: (ctx) => MLformScreen(),
      MLScreen.routeName: (ctx) => MLScreen(),
      CreatePartyScreen.routeName: (ctx) => CreatePartyScreen(),
      BdayPartyScreen.routeName: (ctx) => BdayPartyScreen(),
      FirstPage.routeName: (ctx) => FirstPage(),
      UseScreen.routeName: (ctx) => UseScreen(),
      introScreen.routeName: (ctx) => introScreen(),
      favScreen.routeName: (ctx) => favScreen(),
      unfavScreen.routeName: (ctx) => unfavScreen(),
      wipScreen.routeName: (ctx) => wipScreen(),

      //VideoPlayerScreen.routeName: (ctx) => VideoPlayerScreen(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Are you Ready?',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          textAlign: TextAlign.left,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/front.jpg"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: deviceSize.height * 0.20,
                  ),
                  Container(
                    width: deviceSize.width,
                    height: deviceSize.height * 0.55,
                    //margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Container(
                            height: 70,
                            margin: EdgeInsets.only(bottom: 20.0),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 50.0),
                            transform: Matrix4.rotationZ(-8 * pi / 180)
                              ..translate(-10.0),
                            // ..translate(-10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepOrange,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.white,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              "Let's RockK & Roll...",
                              style: TextStyle(
                                //color: Theme.of(context).accentTextTheme.title.color,
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Anton',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Consumer<Auth>(
                                  builder: (ctx, auth, _) => MaterialApp(
                                        debugShowCheckedModeBanner: false,
                                        home: auth.isAuth
                                            ? ProductsOverviewScreen(
                                                uname: auth.uname,
                                              )
                                            // Navigator.of(context).pushNamed(
                                            //     ProductsOverviewScreen
                                            //         .routeName,
                                            //     arguments: auth.uname)

                                            : FutureBuilder(
                                                future: auth.tryAutoLogin(),
                                                builder: (ctx,
                                                        authResultSnapshot) =>
                                                    authResultSnapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting
                                                        ? SplashScreen()
                                                        : AuthScreen(),
                                              ),
                                        //initialRoute: '/',
                                        routes: allRoute,
                                        //         onGenerateRoute: (settings) {
                                        //           if (settings.name ==
                                        //               ProductsOverviewScreen
                                        //                   .routeName) {
                                        //             final args =
                                        //                 settings.arguments as String;
                                        //                 return MaterialPageRoute(
                                        // builder: (ctx) => builder (ctx));
                                        //           }
                                        //         },
                                      ));
                            }));
                          },
                          child: Text('Signup /Login via Email',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Consumer<Guest>(
                                  builder: (ctx, guest, _) => MaterialApp(
                                      debugShowCheckedModeBanner: false,

                                      //GuestScreen(allRoute: allRoute);
                                      home: guest.isGuest
                                          ? ProductsOverviewScreen(
                                              uname: guest.device_name,
                                            )
                                          : FutureBuilder(
                                              future: guest.tryGuestLogin(),
                                              builder: (ctx,
                                                      guestResultSnapshot) =>
                                                  guestResultSnapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting
                                                      ? SplashScreen()
                                                      : GuestScreen(),
                                            ),
                                      routes: allRoute));
                            }));
                          },
                          child: Text('Login as a Guest',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
