import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import '../widgets/app_drawer.dart';

class wipScreen extends StatelessWidget {
  //const introScreen({ Key? key }) : super(key: key);
  static const routeName = '/wip-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coming Soon..."),
        backgroundColor: Colors.deepOrange,
      ),
      //drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/work.gif',
                //height: 400, width: double.infinity
                //fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/ip.gif',
                //height: 400, width: double.infinity
                //fit: BoxFit.cover,
              ),
              Image.asset(
                'assets/images/wip.gif',
                //height: 400, width: double.infinity
                //fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
