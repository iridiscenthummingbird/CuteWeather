import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String windDeg(double deg, BuildContext context) {
  if (deg >= 22.5 && deg < 67.5) {
    return 'sw'.tr();
  } else if (deg >= 67.5 && deg < 112.5) {
    return 'w'.tr();
  } else if (deg >= 112.5 && deg < 157.5) {
    return 'nw'.tr();
  } else if (deg >= 157.5 && deg < 202.5) {
    return 'n'.tr();
  } else if (deg >= 202.5 && deg < 247.5) {
    return 'ne'.tr();
  } else if (deg >= 247.5 && deg < 292.5) {
    return 'e'.tr();
  } else if (deg >= 292.5 && deg < 337.5) {
    return 'se'.tr();
  } else {
    return 's'.tr();
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
