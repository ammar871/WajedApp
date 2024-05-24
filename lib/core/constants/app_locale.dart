import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  // Field
  Locale locale;

  // Constractor
  AppLocalizations(this.locale);

  // get locale
  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  // Load data
  late Map<String, dynamic> _translatedMap;

  // Load data from path
  Future loadLangs() async {
    try {
      String files = await rootBundle
          .loadString("assets/i18n/${locale.languageCode}.json");

      Map<String, dynamic> loadedData = jsonDecode(files);

      _translatedMap = loadedData.map(
        (key, value) => MapEntry(
          key,
          value.toString(),
        ),
      );

      return _translatedMap;
    } catch (error) {
      rethrow;
    }
  }

  String translate(String key) {
    try {
      return _translatedMap[key];
    } catch (error) {
      return key.replaceAll("_", " ").toUpperCase();
    }
  }

  String trArgs(String key, List<String> args) {
    try {
      var val = _translatedMap[key];
      if (args.isNotEmpty) {
        for (final arg in args) {
          val = val.replaceFirst(RegExp(r'%s'), arg.toString());
        }
      }
      return val;
    } catch (error) {
      return key.replaceAll("_", " ").toUpperCase();
    }
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _CustomAppLocalDelegate();
  // End
}

class _CustomAppLocalDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _CustomAppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    try {
      AppLocalizations appLocaleInternational = AppLocalizations(locale);

      await appLocaleInternational.loadLangs();

      // Load got data as delegate
      return appLocaleInternational;
    } catch (error) {
      rethrow;
    }
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<AppLocalizations> old,
  ) =>
      false;
}
