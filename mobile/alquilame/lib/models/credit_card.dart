import 'package:flutter/material.dart';

class CreditCardResponse {
  int? id;
  String? number;
  String? holder;
  String? expiredDate;
  bool? active;
  String? type;
  Color? cardColor;

  CreditCardResponse(
      {this.id,
      this.number,
      this.holder,
      this.expiredDate,
      this.active,
      this.type,
      this.cardColor});

  CreditCardResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    holder = json['holder'];
    expiredDate = json['expiredDate'];
    active = json['active'];
    type = json['type'];
    cardColor = json['cardColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['holder'] = this.holder;
    data['expiredDate'] = this.expiredDate;
    data['active'] = this.active;
    data['type'] = this.type;
    data['cardColor'] = this.cardColor;
    return data;
  }
}

class CreditCardRequest {
  String? number;
  String? holder;
  String? expiredDate;
  String? cvv;

  CreditCardRequest({this.number, this.holder, this.expiredDate, this.cvv});

  CreditCardRequest.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    holder = json['holder'];
    expiredDate = json['expiredDate'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['holder'] = this.holder;
    data['expiredDate'] = this.expiredDate;
    data['cvv'] = this.cvv;
    return data;
  }
}
