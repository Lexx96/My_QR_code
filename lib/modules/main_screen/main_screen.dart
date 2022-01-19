import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_coder/generated/l10n.dart';
import 'package:qr_coder/modules/main_screen/widgets/card_widget.dart';
import 'package:qr_coder/modules/main_screen/widgets/show_dialog_widget.dart';
import 'package:qr_coder/modules/show_qr_code_screen/show_qr_code_screen.dart';
import 'package:qr_coder/utils/main_navigation/main_navigation.dart';
import 'package:qr_coder/utils/themes/my_light_theme.dart';
import 'bloc/main_screen_bloc.dart';
import 'bloc/main_screen_state.dart';
import 'service/main_screen_service.dart';

/// Главный экран приложения
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenBloc _bloc;
  late bool? _isShowQRCodeScreen = false;
  late ReadURLFromGalleryState _data;
  String? _url = null;
  bool _isFirstExit = false;

  @override
  void initState() {
    super.initState();
    _bloc = MainScreenBloc();
    _bloc.isFirstExitFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.getURLFromSharedPreferences();

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        backgroundColor: ColorsLightTheme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            StreamBuilder(
              stream: _bloc.mainScreenStreamController,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data is ReadURLFromSharedPreferencesState) {
                  final _data =
                      snapshot.data as ReadURLFromSharedPreferencesState;
                  _url = _data.url;
                }

                if (snapshot.data is ReadURLFromGalleryState) {
                  _data = snapshot.data as ReadURLFromGalleryState;
                  if (_data.urlFromImage != null) {
                    Future.delayed(
                      Duration.zero,
                      () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ShowQRCodeScreen(
                              url: _data.urlFromImage,
                              isShowButtonExit: false,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.data is ReadURLFromGalleryState &&
                      _data.urlFromImage == null) {
                    Future.delayed(Duration.zero).whenComplete(
                      () => _showMessage(),
                    );
                  }
                }

                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 35.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).hello,
                                style: const TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsLightTheme.mainTextColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            _url != null
                                ? S.of(context).gladSeeYou
                                : S.of(context).addYourQR,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: ColorsLightTheme.textColor,
                            ),
                            maxLines: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    _url != null
                                        ? InkWell(
                                            onTap: () =>
                                                Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ShowQRCodeScreen(
                                                  url: _url,
                                                  isShowButtonExit: true,
                                                ),
                                              ),
                                            ),
                                            child: CardWidget(
                                              title: S.of(context).showQR,
                                              description: '',
                                              color:
                                                  ColorsLightTheme.cardColor1,
                                              height: 0.35,
                                              context: context,
                                              icon: Icons.qr_code,
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () => _showActions(
                                              topButtonText:
                                                  S.of(context).camera,
                                              centerButtonText:
                                                  S.of(context).gallery,
                                              topButtonIcon: const Icon(
                                                  Icons.camera_alt_outlined),
                                              centerButtonIcon:
                                                  const Icon(Icons.slideshow),
                                              functionTopButton: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pushNamed(
                                                    MainNavigationRouteName
                                                        .viewScreen);
                                              },
                                              functionCenterBottom: () {
                                                Navigator.of(context).pop();
                                                _bloc.choicePickImage();
                                              },
                                            ),
                                            child: CardWidget(
                                              title: S.of(context).addQR,
                                              description: '',
                                              color:
                                                  ColorsLightTheme.cardColor1,
                                              height: 0.35,
                                              context: context,
                                              icon: Icons.add,
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    InkWell(
                                      onTap: _url != null
                                          ? () async {
                                              _isShowQRCodeScreen =
                                                  await MainScreenService()
                                                      .readeIsShowQRCodeScreenService();
                                              _showActions(
                                                topButtonText: S.of(context).no,
                                                centerButtonText:
                                                    S.of(context).yes,
                                                topButtonIcon:
                                                    _isShowQRCodeScreen == true
                                                        ? const Icon(
                                                            Icons
                                                                .visibility_rounded,
                                                            color: Colors.green,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .visibility_rounded,
                                                          ),
                                                centerButtonIcon:
                                                    _isShowQRCodeScreen == false
                                                        ? const Icon(
                                                            Icons
                                                                .visibility_off,
                                                            color: Colors.green,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .visibility_off,
                                                          ),
                                                functionTopButton: () async {
                                                  await MainScreenService()
                                                      .setIsShowQRCodeScreenService(
                                                          true);
                                                  Navigator.of(context).pop();
                                                },
                                                functionCenterBottom: () async {
                                                  await MainScreenService()
                                                      .setIsShowQRCodeScreenService(
                                                          false);
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                            }
                                          : () {},
                                      child: CardWidget(
                                        title: S.of(context).showWhenStarted,
                                        description: '',
                                        color: ColorsLightTheme.cardColor2,
                                        height: 0.4,
                                        context: context,
                                        icon: Icons.slideshow,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: _url != null
                                          ? () => _showActions(
                                                topButtonText:
                                                    S.of(context).camera,
                                                centerButtonText:
                                                    S.of(context).gallery,
                                                topButtonIcon: const Icon(
                                                    Icons.camera_alt_outlined),
                                                centerButtonIcon:
                                                    const Icon(Icons.slideshow),
                                                functionTopButton: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          MainNavigationRouteName
                                                              .viewScreen);
                                                },
                                                functionCenterBottom: () {
                                                  Navigator.of(context).pop();
                                                  _bloc.choicePickImage();
                                                },
                                              )
                                          : () {},
                                      child: CardWidget(
                                        title: S.of(context).replaceQR,
                                        description: '',
                                        color: ColorsLightTheme.cardColor3,
                                        height: 0.4,
                                        context: context,
                                        icon: Icons.wifi_protected_setup,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    InkWell(
                                      onTap: _url != null
                                          ? () => _showActions(
                                                topButtonText:
                                                    S.of(context).delete,
                                                centerButtonText:
                                                    S.of(context).cancel,
                                                topButtonIcon:
                                                    const Icon(Icons.delete),
                                                centerButtonIcon:
                                                    const Icon(Icons.cancel),
                                                functionTopButton: () {
                                                  _bloc
                                                      .deleteURLFromSharedPreferences();
                                                  Navigator.of(context).pop();
                                                },
                                                functionCenterBottom: () =>
                                                    Navigator.of(context).pop(),
                                              )
                                          : () {},
                                      child: CardWidget(
                                        title: S.of(context).delete,
                                        description: '',
                                        color: ColorsLightTheme.cardColor4,
                                        height: 0.35,
                                        context: context,
                                        icon: Icons.delete,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            StreamBuilder(
              stream: _bloc.mainScreenIsFirstExitStreamController,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data is IsFirstExitFromSharedPreferencesState) {
                  final _data =
                      snapshot.data as IsFirstExitFromSharedPreferencesState;
                  _isFirstExit = _data.isFirstExit;

                  if (_isFirstExit) {
                    Future.delayed(Duration.zero).whenComplete(
                      () => _showMessage(),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Вывод оповещения для пользователя на экран
  void _showMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return _isFirstExit
            ? ShowDialogWidget(
                title: S.of(context).welcome,
                description: S.of(context).accessYourCertificate,
                onTabLeftButton: () async {
                  await MainScreenService().setIsFirstExitService();
                  Navigator.of(context).pop();
                },
                textLeftButton: S.of(context).ok,
              )
            : ShowDialogWidget(
                title: S.of(context).codeNotRead,
                description: S.of(context).imageNotContainQR,
                onTabLeftButton: () => _bloc.choicePickImage(),
                onTabRightButton: () => Navigator.of(context).pop(),
                textLeftButton: S.of(context).repeat,
                textRightButton: S.of(context).cancel,
              );
      },
    );
  }

  /// Показывает варианты дейсвий,
  /// принимает название верхней кнопки String [topButtonText],
  /// название центральной кнопки String [centerButtonText],
  /// название нижней кнопки String [bottomButtonText],
  /// иконку верхней кнопки IconData [topButtonIcon],
  /// иконку центральной кнопки IconData [centerButtonIcon],
  /// иконку нижней кнопки IconData [bottomButtonIcon],
  /// функцию верхней кнопки Function [functionTopButton],
  /// функцию центральной кнопки Function [functionCenterBottom],
  /// функцию нижней кнопки Function [functionBottomBottom]
  dynamic _showActions({
    required String topButtonText,
    String? centerButtonText,
    String? bottomButtonText,
    required Icon topButtonIcon,
    Icon? centerButtonIcon,
    Icon? bottomButtonIcon,
    required Function() functionTopButton,
    Function()? functionCenterBottom,
    Function()? functionBottomBottom,
  }) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => functionTopButton(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(topButtonText),
                  topButtonIcon,
                ],
              ),
            ),
            centerButtonText != null &&
                    centerButtonIcon != null &&
                    functionCenterBottom != null
                ? CupertinoActionSheetAction(
                    onPressed: () => functionCenterBottom(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(centerButtonText),
                        centerButtonIcon,
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            bottomButtonText != null &&
                    bottomButtonIcon != null &&
                    functionBottomBottom != null
                ? CupertinoActionSheetAction(
                    onPressed: () => functionBottomBottom(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(bottomButtonText),
                        bottomButtonIcon,
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    } else {
      return showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(topButtonText),
                leading: topButtonIcon,
                onTap: () => functionTopButton(),
              ),
              centerButtonText != null && functionCenterBottom != null
                  ? ListTile(
                      title: Text(centerButtonText),
                      leading: centerButtonIcon,
                      onTap: () => functionCenterBottom(),
                    )
                  : const SizedBox.shrink(),
              bottomButtonText != null &&
                      bottomButtonIcon != null &&
                      functionBottomBottom != null
                  ? ListTile(
                      title: Text(bottomButtonText),
                      leading: bottomButtonIcon,
                      onTap: () => functionBottomBottom(),
                    )
                  : const SizedBox.shrink()
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
