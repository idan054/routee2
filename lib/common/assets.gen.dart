/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/services.dart';
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class $AssetsCoversGen {
  const $AssetsCoversGen();

  /// File path: assets/covers/bar_pub.png
  AssetGenImage get barPub => const AssetGenImage('assets/covers/bar_pub.png');

  /// File path: assets/covers/board_games.png
  AssetGenImage get boardGames => const AssetGenImage('assets/covers/board_games.png');

  /// File path: assets/covers/lecture.png
  AssetGenImage get lecture => const AssetGenImage('assets/covers/lecture.png');

  /// File path: assets/covers/other_event.png
  AssetGenImage get otherEvent => const AssetGenImage('assets/covers/other_event.png');

  /// File path: assets/covers/party.png
  AssetGenImage get party => const AssetGenImage('assets/covers/party.png');

  /// File path: assets/covers/show.png
  AssetGenImage get show => const AssetGenImage('assets/covers/show.png');

  /// File path: assets/covers/sport.png
  AssetGenImage get sport => const AssetGenImage('assets/covers/sport.png');

  /// File path: assets/covers/trip.png
  AssetGenImage get trip => const AssetGenImage('assets/covers/trip.png');

  /// File path: assets/covers/weekend.png
  AssetGenImage get weekend => const AssetGenImage('assets/covers/weekend.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [barPub, boardGames, lecture, otherEvent, party, show, sport, trip, weekend];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/whatsapp-outline.svg
  SvgGenImage get whatsappOutline => const SvgGenImage('assets/svg/whatsapp-outline.svg');

  /// List of all assets
  List<SvgGenImage> get values => [whatsappOutline];
}

class Assets {
  Assets._();

  static const AssetGenImage gPSIconWhite = AssetGenImage('assets/GPS-icon-White.png');
  static const AssetGenImage addOnlyX = AssetGenImage('assets/add-Only-X.png');
  static const AssetGenImage addOnlyBlack = AssetGenImage('assets/add-Only-black.png');
  static const AssetGenImage addOnlyWhite = AssetGenImage('assets/add-Only-white.png');
  static const AssetGenImage addWithBg = AssetGenImage('assets/add-with-bg.png');
  static const AssetGenImage appIcon = AssetGenImage('assets/app_icon.png');
  static const $AssetsCoversGen covers = $AssetsCoversGen();
  static const AssetGenImage routeeAppIcon = AssetGenImage('assets/routee-app_icon.png');
  static const AssetGenImage routeeCircleAppIcon =
      AssetGenImage('assets/routee-circle-app_icon.png');
  static const AssetGenImage routee = AssetGenImage('assets/routee.png');
  static const $AssetsSvgGen svg = $AssetsSvgGen();
  static const AssetGenImage tagsAndIcon = AssetGenImage('assets/tagsAndIcon.png');
  static const AssetGenImage tagsAndIconWide =
      AssetGenImage('assets/tagsAndIconWide.png');
  static const AssetGenImage tagsX = AssetGenImage('assets/tagsX.png');
  static const AssetGenImage whatsappXxl = AssetGenImage('assets/whatsapp-xxl.png');
  static const AssetGenImage wtspAppIcon = AssetGenImage('assets/wtsp-app_icon.png');
  static const AssetGenImage wtspGreenAppIcon =
      AssetGenImage('assets/wtsp-green-app_icon.png');
  static const AssetGenImage wtspBgWithIconX =
      AssetGenImage('assets/wtspBgWithIconX.png');
  static const AssetGenImage wtspLocationGroupIconSolid =
      AssetGenImage('assets/wtspLocationGroup-icon-solid.png');
  static const AssetGenImage wtspLocationGroupIcon =
      AssetGenImage('assets/wtspLocationGroup-icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        gPSIconWhite,
        addOnlyX,
        addOnlyBlack,
        addOnlyWhite,
        addWithBg,
        appIcon,
        routeeAppIcon,
        routeeCircleAppIcon,
        routee,
        tagsAndIcon,
        tagsAndIconWide,
        tagsX,
        whatsappXxl,
        wtspAppIcon,
        wtspGreenAppIcon,
        wtspBgWithIconX,
        wtspLocationGroupIconSolid,
        wtspLocationGroupIcon
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated Clip? clipBehavior,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      // colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      // clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
