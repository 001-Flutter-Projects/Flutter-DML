import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dml/models/staff.dart';

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"),);
          }else if(snapshot.hasData){

            List<Staff> staffList = staffListFromSnapshot(snapshot);
            return _buildListView(staffList);
          }else {
            return CircularProgressIndicator();
          }
        },
      )
    );
  }

  _buildListView(List<Staff> staffList) {
    return ListView.builder(
      itemCount: staffList.length,
        itemBuilder: (context, index){

        Staff staff = staffList[index];

        return Container(
          color: Colors.pink[100],
          child: ListTile(
            title: Text(staff.fullName),
            subtitle: Text(staff.username),
            trailing: Icon(Icons.navigate_next),
          ),
        );

        }
    );
  }
}
