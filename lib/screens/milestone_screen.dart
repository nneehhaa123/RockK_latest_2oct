import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../providers/orders.dart' show Orders;
import '../providers/milestone.dart';
import '../widgets/ml_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/kiaansh_party_screen.dart';

class MLScreen extends StatelessWidget {
  static const routeName = '/mls';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kiaansh's Milstones"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.of(context)
              .popUntil(ModalRoute.withName(KiaParty.routeName));
          //Navigator.of(context).pushNamed(KiaParty.routeName);
        },
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          FutureBuilder(
            future:
                Provider.of<Milestone>(context, listen: false).fetchAndSetMls(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapshot.error != null) {
                  // ...
                  // Do error handling stuff
                  print(dataSnapshot.error);
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  return Consumer<Milestone>(
                    builder: (ctx, MlData, child) => ListView.builder(
                      itemCount: MlData.ml.length,
                      itemBuilder: (ctx, i) => MlItem(MlData.ml[i]),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
