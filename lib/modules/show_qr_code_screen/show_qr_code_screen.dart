import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_coder/modules/main_screen/widgets/show_dialog_widget.dart';
import 'package:qr_coder/utils/main_navigation/main_navigation.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'bloc/show_qr_code_bloc.dart';
import 'bloc/show_qr_code_state.dart';

/// Экран вывода информации и сгенерированого QR
class ShowQRCodeScreen extends StatefulWidget {
  final String? url;

  const ShowQRCodeScreen({Key? key, required this.url}) : super(key: key);

  @override
  _ShowQRCodeScreenState createState() => _ShowQRCodeScreenState();
}

class _ShowQRCodeScreenState extends State<ShowQRCodeScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late ShowCodeBloc _bloc;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    _bloc = ShowCodeBloc();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamBuilder(
      stream: _bloc.showQRCodeStreamController,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: WebView(
                              initialUrl: widget.url,
                              onWebViewCreated:
                                  (WebViewController webViewController) {
                                _controller.complete(webViewController);
                              },
                              javascriptMode: JavascriptMode.unrestricted,
                              onPageFinished: (_) => _bloc.showQRCode(),
                            ),
                          ),
                        ],
                      ),
                      snapshot.data is RecordedURLState ||
                              snapshot.data is ShowQRCodeState
                          ? Align(
                              heightFactor: 2.2,
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                  ),
                                  Center(
                                    child: QrImage(
                                      data: widget.url as String,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  snapshot.data is RecordedURLState
                      ? ShowDialogWidget(
                          title: 'Отлично!',
                          description: 'Ваш QR код сохранен.',
                          textLeftButton: 'ОК',
                          onTabLeftButton: () => Navigator.of(context)
                              .pushNamed(MainNavigationRouteName.mainScreen),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ],
          ),
          bottomNavigationBar: snapshot.data is RecordedURLState ||
                  snapshot.data is ShowQRCodeState
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Platform.isAndroid
                        ? TextButton(
                            onPressed: () => _bloc
                                .setURLSharedPreferences(widget.url as String),
                            child: const Text('Отмена'),
                          )
                        : CupertinoButton(
                            child: const Text('Отмена'),
                            onPressed: () => _bloc
                                .setURLSharedPreferences(widget.url as String),
                          ),
                    Platform.isAndroid
                        ? TextButton(
                            onPressed: () => _bloc
                                .setURLSharedPreferences(widget.url as String),
                            child: const Text('Сохранить'),
                          )
                        : CupertinoButton(
                            child: const Text('Сохранить'),
                            onPressed: () => _bloc
                                .setURLSharedPreferences(widget.url as String),
                          ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
