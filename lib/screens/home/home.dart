import 'package:flutter/material.dart';
import 'package:flutter_dml/screens/authenticate/authenticate.dart';
import 'package:flutter_dml/screens/authenticate/sign_in.dart';
import 'package:flutter_dml/screens/home/staff_add.dart';
import 'package:flutter_dml/screens/home/build_listview.dart';
import 'package:flutter_dml/services/auth.dart';
import 'package:flutter_dml/shared/loading.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loading = false;

  //the service method that created from auth file
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Staffs List'),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            icon: Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: StaffAdd()
                )
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: BuildListView(),
    );
  }

  //final AuthService _authService = AuthService();
  _buildDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 20.0),),
            decoration: BoxDecoration(
              color: Colors.pink[400],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Sign Out', style: TextStyle(fontSize: 16.0),),
            onTap: () async {
              // Update the state of the app.
              setState(() {
                loading = true;
              });
              dynamic result = await _auth.signOut();
              if(result == null) {
                  loading = false;
              }
            },
          ),
        ],
      ),
    );

  }
}
