// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello!`
  String get hello {
    return Intl.message(
      'Hello!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Glad to see you`
  String get gladSeeYou {
    return Intl.message(
      'Glad to see you',
      name: 'gladSeeYou',
      desc: '',
      args: [],
    );
  }

  /// `Add your QR code`
  String get addYourQR {
    return Intl.message(
      'Add your QR code',
      name: 'addYourQR',
      desc: '',
      args: [],
    );
  }

  /// `Show QR code`
  String get showQR {
    return Intl.message(
      'Show QR code',
      name: 'showQR',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Add your QR code`
  String get addQR {
    return Intl.message(
      'Add your QR code',
      name: 'addQR',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Show when the application is launched`
  String get showWhenStarted {
    return Intl.message(
      'Show when the application is launched',
      name: 'showWhenStarted',
      desc: '',
      args: [],
    );
  }

  /// `Replace QR Code`
  String get replaceQR {
    return Intl.message(
      'Replace QR Code',
      name: 'replaceQR',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Add your QR code and get quick and convenient access to your COVID-19 vaccination certificate`
  String get accessYourCertificate {
    return Intl.message(
      'Add your QR code and get quick and convenient access to your COVID-19 vaccination certificate',
      name: 'accessYourCertificate',
      desc: '',
      args: [],
    );
  }

  /// `ОК`
  String get ok {
    return Intl.message(
      'ОК',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Perhaps the image does not contain a QR code about the vaccination from COVID-19`
  String get imageNotContainQR {
    return Intl.message(
      'Perhaps the image does not contain a QR code about the vaccination from COVID-19',
      name: 'imageNotContainQR',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message(
      'Repeat',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `The QR code is not a certificate of vaccination`
  String get QRCodeIsNotCertificate {
    return Intl.message(
      'The QR code is not a certificate of vaccination',
      name: 'QRCodeIsNotCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Scan the QR code`
  String get scanQR {
    return Intl.message(
      'Scan the QR code',
      name: 'scanQR',
      desc: '',
      args: [],
    );
  }

  /// `The code has not been read`
  String get codeNotRead {
    return Intl.message(
      'The code has not been read',
      name: 'codeNotRead',
      desc: '',
      args: [],
    );
  }

  /// `Your QR code is saved`
  String get QRCodeIsSaved {
    return Intl.message(
      'Your QR code is saved',
      name: 'QRCodeIsSaved',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `To the main screen`
  String get toMainScreen {
    return Intl.message(
      'To the main screen',
      name: 'toMainScreen',
      desc: '',
      args: [],
    );
  }

  /// `Great!`
  String get great {
    return Intl.message(
      'Great!',
      name: 'great',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
