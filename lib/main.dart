import 'package:flutter/material.dart';
import './providers/milestone.dart';
// import './screens/milestone_screen.dart';
// import './screens/add_wishes_screen.dart';
import 'package:provider/provider.dart';

//import './screens/splash_screen.dart';
//import './screens/products_overview_screen.dart';
import './providers/auth.dart';
import './providers/guest.dart';
import './providers/products.dart';
import './providers/orders.dart';
// import './screens/auth_screen.dart';
// import './screens/kiaansh_party_screen.dart';
//import './screens/video_play_screen.dart';
// import './screens/orders_screen.dart';
// import './screens/ML_form_screen.dart';
// import './screens/create_party_screen.dart';
// import './screens/bp_screen.dart';
import './screens/first_page.dart';

// Future<void> _messageHandler(RemoteMessage message) async {
//       print('background message ${message.notification.body}');
//     }

void main() => runApp(MyApp());
// void main() async {
//       WidgetsFlutterBinding.ensureInitialized();
//       await Firebase.initializeApp();
//       FirebaseMessaging.onBackgroundMessage(_messageHandler);
//       runApp(MyApp());
//     }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Guest(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Milestone>(
          create: null,
          update: (ctx, auth, previousOrders) => Milestone(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.ml,
          ),
        ),
        // ChangeNotifierProvider.value(
        //   value: Cart(),
        // ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Party App',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            //secondaryHeaderColor: Colors.deepOrange,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: FirstPage(),
          // home: auth.isAuth
          //     ? ProductsOverviewScreen()
          //     : FutureBuilder(
          //         future: auth.tryAutoLogin(),
          //         builder: (ctx, authResultSnapshot) =>
          //             authResultSnapshot.connectionState ==
          //                     ConnectionState.waiting
          //                 ? SplashScreen()
          //                 : AuthScreen(),
          //       ),
          // routes: {
          //   KiaParty.routeName: (ctx) => KiaParty(),
          //   AddWishesScreen.routeName: (ctx) => AddWishesScreen(),
          //   OrdersScreen.routeName: (ctx) => OrdersScreen(),
          //   MLformScreen.routeName: (ctx) => MLformScreen(),
          //   MLScreen.routeName: (ctx) => MLScreen(),
          //   CreatePartyScreen.routeName: (ctx) => CreatePartyScreen(),
          //   BdayPartyScreen.routeName: (ctx) => BdayPartyScreen(),
          //   FirstPage.routeName: (ctx) => FirstPage(),

          //   //VideoPlayerScreen.routeName: (ctx) => VideoPlayerScreen(),
          // },
        ),
      ),
    );
  }
}
