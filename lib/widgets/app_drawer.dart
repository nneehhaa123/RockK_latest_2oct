import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/kiaansh_party_screen.dart';

//import '../screens/ML_form_screen.dart';
//import 'package:flutter_app_test/screens/first_page.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/add_wishes_screen.dart';
import '../screens/intro_screen.dart';
import '../providers/auth.dart';
import '../screens/milestone_screen.dart';
import '../screens/fav_screen.dart';
import '../screens/dislike_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  //var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello! I am Kiaansh'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.deepOrange,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Kiaansh's Home",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(KiaParty.routeName);
            },
            //     trailing: IconButton(
            //       icon: Icon(_expanded
            //           ? Icons.expand_less_outlined
            //           : Icons.expand_more_outlined),
            //       onPressed: () {
            //         setState(() {
            //           _expanded = !_expanded;
            //         });
            //       }),
          ),
          // if (_expanded)
          Container(
            padding: EdgeInsets.only(left: 40),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.toys),
                  title: Text(
                    'My Intro',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(introScreen.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.thumb_up),
                  title: Text(
                    'My Favourites',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(favScreen.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.thumb_down),
                  title: Text(
                    'My Dislikes',
                    style: TextStyle(fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(unfavScreen.routeName);
                  },
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text(
              'My Milestones',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(MLScreen.routeName);
              //Navigator.of(context).pushNamed(MLScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_post_office),
            title: Text(
              'Send wishes to me',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AddWishesScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.video_collection),
            title: Text(
              "See other's wishes",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/');

              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
