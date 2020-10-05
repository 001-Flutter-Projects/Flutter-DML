import 'package:flutter/material.dart';
import 'package:flutter_dml/services/auth.dart';
import 'package:flutter_dml/shared/constants.dart';
import 'package:flutter_dml/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // Initially password confirm
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //Text State
  String email;
  String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white,),
        ),
        title: Text('Flutter DML'),
        backgroundColor: Colors.pink[400],
        actions: <Widget> [
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Sign In', style: TextStyle(color: Colors.white),),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget> [
            Text('User Register', style: TextStyle(
                fontSize: 25.0, color: Colors.pink, fontWeight: FontWeight.bold,
              fontFamily: 'Schyler'
              ),
            ),
            SizedBox(height: 20.0,),

            TextFormField(
              decoration: inputTextDecoration.copyWith(
                  hintText: 'email@example.com',
                  icon: Icon(Icons.person)
              ),
              validator: (value) => value.contains('@gmail') ? null : 'Enter an email!',
              onChanged: (String value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(height: 20.0,),

            TextFormField(
              decoration: inputTextDecoration.copyWith(
                  labelText: 'Password',
                  hintText: 'Password',
                  icon: Icon(Icons.vpn_key),
                  suffixIcon: FlatButton(
                      onPressed: _toggle,
                      child:Icon(
                          Icons.remove_red_eye,
                          color: _obscureText ? Colors.black12 : Colors.black54
                      )
                  )
              ),
              obscureText: _obscureText,
              controller: _pass,
              validator: (value) => value.length < 6 ? 'Enter a password more than 6 character!' : null,
              onChanged: (String value) {
                setState(() {
                  password = value;
                });
              },
            ),
            SizedBox(height: 20.0,),

            TextFormField(
              decoration: inputTextDecoration.copyWith(
                  labelText: 'Re-Password',
                  hintText: 'Re-Password',
                  icon: Icon(Icons.vpn_key),
                  suffixIcon: FlatButton(
                      onPressed: _toggle,
                      child:Icon(
                          Icons.remove_red_eye,
                          color: _obscureText ? Colors.black12 : Colors.black54
                      )
                  )
              ),
              obscureText: _obscureText,
              controller: _confirmPass,
              validator: (value) => value != _pass.text ? 'not match!' : null,
              onChanged: (String value) {
                setState(() {
                  password = value;
                });
              },
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _authService.createUserWithEmailAndPassword(email, password);
                  if(result == null) {
                    setState(() {
                      loading = false;
                      error = 'could not sign in with this credential!';
                    });
                  }
                }
              },
            ),
            SizedBox(height: 20.0,),
            Text(error, style: TextStyle(color: Colors.red),),
          ],

        ),
      ),

    );
  }
}
