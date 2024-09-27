import 'dart:io';

import 'package:flutter/foundation.dart';

const bool isWebPlatform = kIsWeb;

bool get isInTest =>
    !isWebPlatform && Platform.environment.containsKey('FLUTTER_TEST');

bool get isAndroidPlatform => !isWebPlatform && Platform.isAndroid;

bool get isIosPlatform => !isWebPlatform && Platform.isIOS;

bool get isMacOSPlatform => !isWebPlatform && Platform.isMacOS;

bool get isLinuxPlatform => !isWebPlatform && Platform.isLinux;

bool get isWindowsPlatform => !isWebPlatform && Platform.isWindows;

bool get isMobilePlatform =>
    !isWebPlatform && (isAndroidPlatform || isIosPlatform);

bool get isDesktopPlatform =>
    !isWebPlatform &&
    (Platform.isMacOS || Platform.isLinux || Platform.isWindows);
