import 'package:flutter/material.dart';

import 'src/core/app_widget.dart';

void main() {
  String myurl = Uri.base.toString(); //get complete url
  String? qParam1 =
      Uri.base.queryParameters["p"]; //get parameter with attribute "para1"

  print(myurl);
  print(qParam1);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    AppWidget(
      queryParam: qParam1,
    ),
  );
}
