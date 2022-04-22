import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:serenity/controller/paymentreadingcontroller.dart';
import 'package:serenity/model/paymentreading_model.dart';

class AdminPaymentView extends StatelessWidget {
  const AdminPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GetBuilder<PaymentReadingController>(
          init: PaymentReadingController(),
          builder: (controller) {
            return Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                          "assets/bg1.jpg",
                        ),
                        fit: BoxFit.fitHeight,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.lighten,
                        ),
                      ),
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      "Payment Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    actions: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 12, 15, 12),
                              child: Text("Total: Rs ${controller.total}"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: controller.loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.paymentreading.isEmpty
                          ? const Center(
                              child: Text("No Payment data found"),
                            )
                          : ListView.builder(
                              itemCount: controller.paymentreading.length,
                              itemBuilder: (context, index) {
                                PaymentReadingModel model =
                                    controller.paymentreading[index];
                                return paymentDetailsCard(
                                  model.username,
                                  model.date,
                                  model.email,
                                  model.totalAmount,
                                );
                              },
                            ),
                ),
              ],
            );
          }),
    );
  }

  Card paymentDetailsCard(
      String username, DateTime date, String email, String amount) {
    return Card(
      color: Colors.blueGrey[800],
      child: ListTile(
        title: Text(
          username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          "$email\n${DateFormat('dd MM yyyy').format(date)}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Text(
          "Rs. $amount",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
