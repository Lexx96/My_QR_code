import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'bloc/qr_view_screen_bloc.dart';
import 'bloc/qr_view_screen_state.dart';

/// Экран сканирования QR - кода
class QRViewScreen extends StatefulWidget {
  const QRViewScreen({Key? key}) : super(key: key);

  @override
  _QRViewScreenState createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  late QRViewBloc _bloc;
  late bool? _flashStatus = false;

  Barcode? result;
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
          if (snapshot.data is LoadingViewState) {
            final _viewData = snapshot.data as LoadingViewState;
            result = _viewData.result;
          }

          if (snapshot.data is OnToggleFlashState) {
            final _flash = snapshot.data as OnToggleFlashState;
            _flashStatus = _flash.onFlash;
          }

          return Column(
            children: <Widget>[
              Expanded(flex: 5, child: _buildQrView(context)),
              Expanded(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: result != null
                            ? Text('Ссылка: ${result!.code}')
                            : const Text('Отсканируйте QR код'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: ElevatedButton(
                                onPressed: () => _bloc.onToggleFlash(),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(242, 76, 78, 1),
                                  ),
                                ),
                                child: _flashStatus == false
                                    ? const Icon(
                                        Icons.wb_sunny_outlined,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.wb_sunny_outlined,
                                        color: Colors.white,
                                      )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: ElevatedButton(
                              onPressed: () => _bloc.flipCamera(),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(255, 199, 89, 1),
                                ),
                              ),
                              child: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  return const Icon(
                                    Icons.refresh,
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
                            child: ElevatedButton(
                              onPressed: () => _bloc.pauseCamera(),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(150, 33, 75, 1),
                                ),
                              ),
                              child: const Icon(Icons.pause),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: ElevatedButton(
                              onPressed: () => _bloc.resumeCamera(),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(79, 199, 254, 1),
                                ),
                              ),
                              child: const Icon(Icons.play_arrow_outlined),
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

  /// Виджет вывода области сканирования QR кода
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
