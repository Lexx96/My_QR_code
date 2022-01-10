import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'bloc/show_qr_code_bloc.dart';

class ShowQRCodeScreen extends StatefulWidget {
  final String? url;

  const ShowQRCodeScreen({Key? key, required this.url}) : super(key: key);

  @override
  _ShowQRCodeScreenState createState() => _ShowQRCodeScreenState();
}

class _ShowQRCodeScreenState extends State<ShowQRCodeScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: WebView(
                      initialUrl: widget.url,
                      onWebViewCreated: (controller) {
                        _controller = controller;
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (_) {},
                    ),
                  ),
                ],
              ),
              Align(
                heightFactor: 2.2,
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Platform.isAndroid
              ? TextButton(
                  onPressed: () {},
                  child: const Text('Отмена'),
                )
              : CupertinoButton(
                  child: const Text('Отмена'),
                  onPressed: () {},
                ),
          Platform.isAndroid
              ? TextButton(
                  onPressed: () {},
                  child: const Text('Сохранить'),
                )
              : CupertinoButton(
                  child: const Text('Сохранить'),
                  onPressed: () {},
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
