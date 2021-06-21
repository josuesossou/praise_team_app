import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  EventModel({
    @required this.name,
    @required this.date,
    @required this.songIds,
    @required this.id,
    @required this.bgCover,
    this.createdAt
  });
  
  String name, date, id, bgCover;
  Timestamp createdAt;
  List<dynamic> songIds;

  factory EventModel.fromMap(Map data) {
    return EventModel(
      name: data['name'],
      date: data['date'],
      createdAt: data['createdAt'],
      songIds: data['songIds'],
      id: data['id'],
      bgCover: data['bgCover']
    );
  }
}