import 'package:flutter/material.dart';
import 'package:flutter_dml/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Staffs List'),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Sign Out', style: TextStyle( color: Colors.white))
          )
        ],
      ),
    );
  }
}
