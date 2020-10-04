import 'package:flutter/material.dart';
import 'package:flutter_dml/models/user.dart';
import 'package:flutter_dml/screens/authenticate/authenticate.dart';
import 'package:flutter_dml/screens/authenticate/sign_in.dart';
import 'package:flutter_dml/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    //return either home and authentication
    if(user == null) {
      return Authenticate();
    }else {
      return Home();
    }
  }
}
