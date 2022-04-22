// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel singlePaymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String singlePaymentModelToJson(PaymentModel data) =>
    json.encode(data.toJson());

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(
    json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  PaymentModel({
    required this.paymentId,
    required this.paymentDate,
    required this.khaltiNum,
    required this.profileId,
    required this.totalAmount,
    required this.remarks,
  });

  String paymentId;
  DateTime paymentDate;
  String khaltiNum;
  String profileId;
  String totalAmount;
  String remarks;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        paymentId: json["payment_id"],
        paymentDate: DateTime.parse(json["payment_date"]),
        khaltiNum: json["khalti_num"],
        profileId: json["profile_id"],
        totalAmount: json["total_amount"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "payment_date":
            "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "khalti_num": khaltiNum,
        "profile_id": profileId,
        "total_amount": totalAmount,
        "remarks": remarks,
      };
}
