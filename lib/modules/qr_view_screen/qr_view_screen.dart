import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_coder/generated/l10n.dart';
import 'package:qr_coder/modules/show_qr_code_screen/show_qr_code_screen.dart';
import 'package:qr_coder/utils/themes/my_light_theme.dart';
import 'bloc/qr_view_screen_bloc.dart';
import 'bloc/qr_view_screen_state.dart';
import '../main_screen/widgets/elevated_button_widget.dart';

/// Экран сканирования QR - кода
class QRViewScreen extends StatefulWidget {
  const QRViewScreen({Key? key}) : super(key: key);

  @override
  _QRViewScreenState createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  late QRViewBloc _bloc;
  late bool? _flashStatus = false;
  late URLIsTrueState _isURLTrue;

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    _bloc = QRViewBloc(controller);
  }

  /// Переопределение метода reassemble, т.к. для hot reload необходимо
  /// приостанавливать работу камеры
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.viewStreamController,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data is OnToggleFlashState) {
            final _flash = snapshot.data as OnToggleFlashState;
            _flashStatus = _flash.isOnFlash;
          }

          if (snapshot.data is URLIsTrueState) {
            _isURLTrue = snapshot.data as URLIsTrueState;
            if (_isURLTrue.url != null) {
              Future.delayed(
                Duration.zero,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ShowQRCodeScreen(
                        url: _isURLTrue.url,
                        isShowButtonExit: false,
                      ),
                    ),
                  );
                },
              );
            }
          }

          return Column(
            children: <Widget>[
              snapshot.data is URLIsTrueState && _isURLTrue.url != null
                  ? Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                          S.of(context).great,
                          style: const TextStyle(
                              fontSize: 80.0, color: Colors.green),
                        ),
                      ),
                    )
                  : Expanded(flex: 5, child: _buildQrView(context)),
              snapshot.data is URLIsTrueState && _isURLTrue.url != null
                  ? const SizedBox.shrink()
                  : Expanded(
                      flex: 1,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: snapshot.data is URLIsTrueState &&
                                      _isURLTrue.url == null
                                  ? Text(
                                      S.of(context).QRCodeIsNotCertificate,
                                      style: const TextStyle(color: Colors.red),
                                    )
                                  : Text(S.of(context).scanQR),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: ElevatedButtonWidget(
                                    backgroundColor:
                                        ColorsLightTheme.cardColor1,
                                    onPressed: () => _bloc.onToggleFlash(),
                                    child: _flashStatus == false
                                        ? const Icon(
                                            Icons.wb_sunny_outlined,
                                            color: Colors.black,
                                          )
                                        : const Icon(
                                            Icons.wb_sunny_outlined,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () => _bloc.flipCamera(),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        ColorsLightTheme.cardColor3,
                                      ),
                                    ),
                                    child: FutureBuilder(
                                      future: controller?.getCameraInfo(),
                                      builder: (context, snapshot) {
                                        return const Icon(
                                          Icons.wifi_protected_setup,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: ElevatedButtonWidget(
                                    backgroundColor:
                                        ColorsLightTheme.cardColor2,
                                    onPressed: () => _bloc.pauseCamera(),
                                    child: const Icon(Icons.pause),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: ElevatedButtonWidget(
                                    backgroundColor:
                                        ColorsLightTheme.cardColor4,
                                    onPressed: () => _bloc.resumeCamera(),
                                    child:
                                        const Icon(Icons.play_arrow_outlined),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }

  /// Виджет вывода камеры и области сканирования QR кода
  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _bloc.onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
