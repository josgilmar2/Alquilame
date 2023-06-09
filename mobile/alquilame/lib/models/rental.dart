class RentalResponse {
  int? id;
  double? totalPrice;
  String? userEmail;
  String? dwelling;
  String? stripePaymentIntentId;
  String? startDate;
  String? endDate;

  RentalResponse(
      {this.id,
      this.totalPrice,
      this.userEmail,
      this.dwelling,
      this.stripePaymentIntentId,
      this.startDate,
      this.endDate});

  RentalResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    userEmail = json['userEmail'];
    dwelling = json['dwelling'];
    stripePaymentIntentId = json['stripePaymentIntentId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalPrice'] = this.totalPrice;
    data['userEmail'] = this.userEmail;
    data['dwelling'] = this.dwelling;
    data['stripePaymentIntentId'] = this.stripePaymentIntentId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}

class RentalRequest {
  String? startDate;
  String? endDate;

  RentalRequest({this.startDate, this.endDate});

  RentalRequest.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
