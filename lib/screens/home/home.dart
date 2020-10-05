import 'package:flutter/material.dart';
import 'package:flutter_dml/screens/authenticate/sign_in.dart';
import 'package:flutter_dml/screens/home/list_view.dart';
import 'package:flutter_dml/services/auth.dart';
import 'package:flutter_dml/shared/loading.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('Staffs List'),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                dynamic result = await _auth.signOut();
                if(result == null) {
                  loading = false;
                }
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Sign Out', style: TextStyle( color: Colors.white))
          )
        ],
      ),
      drawer: _buildDrawer(),
      body: BuildListView(),
    );
  }

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
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
          ),
        ],
      ),
    );

  }
}
