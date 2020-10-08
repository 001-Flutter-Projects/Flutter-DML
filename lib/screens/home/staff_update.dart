import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dml/models/staff.dart';
import 'package:flutter_dml/shared/loading.dart';

class StaffUpdate extends StatefulWidget {

  final Staff staff;
  StaffUpdate({this.staff});

  @override
  _StaffUpdateState createState() => _StaffUpdateState();
}

class _StaffUpdateState extends State<StaffUpdate> {

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
        icon: Icon(Icons.keyboard_arrow_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.pink,
      title: Text('Edit Staff', style: TextStyle(color: Colors.white),),
      centerTitle: true,
    );
  }

  var _fullName = TextEditingController();
  var _username = TextEditingController();
  var _address = TextEditingController();
  var _createdDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullName.text = widget.staff.fullName;
    _username.text = widget.staff.username;
    _address.text = widget.staff.address;
    _createdDate.text = widget.staff.createDate;
  }

  _buildBody() {
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
            child: Text('Update New',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              FirebaseFirestore.instance.runTransaction((trx) async {
                //CollectionReference colRef = FirebaseFirestore.instance.collection('users');
                Staff staff = Staff(
                    fullName: _fullName.text,
                    //image: 'https://bl.thgim.com/news/sports/q40ow5/article31080376.ece/alternates/LANDSCAPE_435/cristiano-ronaldojpg',
                    username: _username.text,
                    address: _address.text,
                    createDate: widget.staff.createDate
                );
                dynamic result = trx.update(widget.staff.reference, staff.toMap());
                if(result == staff){
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
