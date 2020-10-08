import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dml/models/staff.dart';
import 'package:flutter_dml/screens/home/staff_update.dart';
import 'package:flutter_dml/shared/loading.dart';
import 'package:page_transition/page_transition.dart';

class BuildListView extends StatefulWidget {

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Container(
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
        return _buildItem(staff);
        }
    );
  }

  _buildItem(Staff staff) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          border: new Border(
              bottom: BorderSide(
                color: Colors.grey[400]
              )
          )
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28.0,
          backgroundImage:
          AssetImage('image/senghuy.jpg'),
          backgroundColor: Colors.transparent,
        ),
        title: Text(staff.fullName),
        subtitle: Text(staff.username),
        trailing: Icon(Icons.navigate_next),
        onTap: () {
          Navigator.push(context, PageTransition(
              type: PageTransitionType.rightToLeft,
              child: StaffUpdate(staff: staff),
          )
          );
        },
        onLongPress: () {
          _displayDeleteDialog(staff);
        },
      ),
    );
  }

  void _displayDeleteDialog(Staff staff) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Delete Confirmation!'),
        content: Text('Do you want to delete it?'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              FirebaseFirestore.instance.runTransaction((transaction) async {
                transaction.delete(staff.reference);
                  setState(() {
                    loading = false;
                  });
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
