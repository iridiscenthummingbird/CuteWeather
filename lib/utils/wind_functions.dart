import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String windDeg(double deg, BuildContext context) {
  if (deg >= 22.5 && deg < 67.5) {
    return AppLocalizations.of(context)!.sw;
  } else if (deg >= 67.5 && deg < 112.5) {
    return AppLocalizations.of(context)!.w;
  } else if (deg >= 112.5 && deg < 157.5) {
    return AppLocalizations.of(context)!.nw;
  } else if (deg >= 157.5 && deg < 202.5) {
    return AppLocalizations.of(context)!.n;
  } else if (deg >= 202.5 && deg < 247.5) {
    return AppLocalizations.of(context)!.ne;
  } else if (deg >= 247.5 && deg < 292.5) {
    return AppLocalizations.of(context)!.e;
  } else if (deg >= 292.5 && deg < 337.5) {
    return AppLocalizations.of(context)!.se;
  } else {
    return AppLocalizations.of(context)!.s;
  }
}

int getBeaufort(double speed) {
  if (speed < 0.5) {
    return 0;
  } else if (speed >= 0.5 && speed < 1.5) {
    return 1;
  } else if (speed >= 1.5 && speed < 3.3) {
    return 2;
  } else if (speed >= 3.3 && speed < 5.5) {
    return 3;
  } else if (speed >= 5.5 && speed < 7.9) {
    return 4;
  } else if (speed >= 7.9 && speed < 10.7) {
    return 5;
  } else if (speed >= 10.7 && speed < 13.8) {
    return 6;
  } else if (speed >= 13.9 && speed < 17.1) {
    return 7;
  } else if (speed >= 17.2 && speed < 20.7) {
    return 8;
  } else if (speed >= 20.7 && speed < 24.4) {
    return 9;
  } else if (speed >= 24.4 && speed < 28.4) {
    return 10;
  } else if (speed >= 28.4 && speed < 32.6) {
    return 11;
  } else {
    return 12;
  }
}
