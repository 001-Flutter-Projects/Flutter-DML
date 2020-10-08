import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dml/models/staff.dart';
import 'package:flutter_dml/shared/loading.dart';

class StaffAdd extends StatefulWidget {
  @override
  _StaffAddState createState() => _StaffAddState();
}

class _StaffAddState extends State<StaffAdd> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_down),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.pink,
      title: Text('Add new staff', style: TextStyle(color: Colors.white),),
      centerTitle: true,
    );
  }

  _buildBody() {

    var _fullName = TextEditingController();
    var _username = TextEditingController();
    var _address = TextEditingController();
    var _createdDate = TextEditingController();

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget> [
          TextField(
            controller: _fullName,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
                hintText: 'Full Name'
            ),
          ),
          TextField(
            controller: _username,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
                hintText: 'Username'
            ),
          ),
          TextField(
            controller: _address,
            decoration: InputDecoration(
                icon: Icon(Icons.add_location),
                hintText: 'Address'
            ),
          ),
          TextField(
            controller: _createdDate,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'CreatedDate'
            ),
          ),
          SizedBox(height: 20.0,),
          RaisedButton(
            color: Colors.pink[400],
            child: Text('Add New',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              FirebaseFirestore.instance.runTransaction((trx) async {
                CollectionReference colRef = FirebaseFirestore.instance.collection('users');
                Staff staff = Staff(
                  fullName: _fullName.text,
                  //image: 'https://bl.thgim.com/news/sports/q40ow5/article31080376.ece/alternates/LANDSCAPE_435/cristiano-ronaldojpg',
                  username: _username.text,
                  address: _address.text,
                  createDate: DateTime.now().toIso8601String()
                );
                dynamic reult = await colRef.add(staff.toMap());
                if(reult == staff) {
                  setState(() {
                    loading = false;
                  });
                }
              }).then((value) {
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      ),
    );
  }
}
