import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

List<Staff> staffListFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<DocumentSnapshot> documents = snapshot.data.docs;
  return documents.map((data) => Staff.fromSnapshot(data)).toList();
}

class Staff{

  String fullName, image, username, address, createDate;
  DocumentReference reference;
  Staff({this.fullName, this.image, this.username, this.address, this.createDate, this.reference});

  Staff.fromMap(Map map, {this.reference}) {
    fullName = map['fullName'];
    image = map['image'];
    username = map['username'];
    address = map['address'];
    createDate = map['createDate'];
  }

  Staff.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data(), reference: snapshot.reference);

  Map<String, dynamic> toMap() => {
    'fullName' : fullName,
    'image' : image,
    'username' : username,
    'address' : address,
    'createDate' : createDate
  };

}

