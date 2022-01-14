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

/// Экран вывода информации о сертификате и сгенерированного QR кода
class ShowQRCodeScreen extends StatefulWidget {
  final String? url;
  final bool? isShowButtonExit;

  const ShowQRCodeScreen({
    Key? key,
    required this.url,
    required this.isShowButtonExit,
  }) : super(key: key);

  @override
  _ShowQRCodeScreenState createState() => _ShowQRCodeScreenState();
}

class _ShowQRCodeScreenState extends State<ShowQRCodeScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late ShowCodeBloc _bloc;
  late String _urlFromSharedPreferences = '';

  @override
  void initState() {
    super.initState();
    _bloc = ShowCodeBloc();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (widget.url == null) _bloc.readURLSharedPreferences();
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
        if (snapshot.data is ReadURLState) {
          final _data = snapshot.data as ReadURLState;
          if (_data.url != null) {
            _urlFromSharedPreferences = _data.url!;
          } else {
            Navigator.of(context).pushNamed(MainNavigationRouteName.mainScreen);
          }
        }

        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
                MainNavigationRouteName.mainScreen, (route) => false);
            return false;
          },
          child: Scaffold(
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
                                initialUrl:
                                    widget.url ?? _urlFromSharedPreferences,
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                    ),
                                    Center(
                                      child: QrImage(
                                        data: widget.url != null
                                            ? widget.url as String
                                            : _urlFromSharedPreferences,
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
            bottomNavigationBar: widget.isShowButtonExit != null &&
                    widget.isShowButtonExit == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Platform.isAndroid
                          ? TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      MainNavigationRouteName.mainScreen,
                                      (route) => false),
                              child: const Text('Отмена'),
                            )
                          : CupertinoButton(
                              child: const Text('Отмена'),
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      MainNavigationRouteName.mainScreen,
                                      (route) => false),
                            ),
                      Platform.isAndroid
                          ? TextButton(
                              onPressed: () => _bloc.setURLSharedPreferences(
                                  widget.url as String),
                              child: const Text('Сохранить'),
                            )
                          : CupertinoButton(
                              child: const Text('Сохранить'),
                              onPressed: () => _bloc.setURLSharedPreferences(
                                  widget.url as String),
                            ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Platform.isAndroid
                          ? TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      MainNavigationRouteName.mainScreen,
                                      (route) => false),
                              child: const Text('На главный экран'),
                            )
                          : CupertinoButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      MainNavigationRouteName.mainScreen,
                                      (route) => false),
                              child: const Text('На главный экран'),
                            ),
                      Platform.isAndroid
                          ? TextButton(
                              onPressed: () => exit(0),
                              child: const Text('Выйти'),
                            )
                          : CupertinoButton(
                              child: const Text('Выйти'),
                              onPressed: () => exit(0),
                            ),
                    ],
                  ),
          ),
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
