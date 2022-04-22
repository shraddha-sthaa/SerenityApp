import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readPrivacyPolicy();
  }

  String policy = "";
  readPrivacyPolicy() async {
    policy = await rootBundle.loadString("assets/privacypolicy.html");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        elevation: 0,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: policy,
        ),
        // child: Text("Hello world this is a note " * 1000),
      ),
    );
  }
}
