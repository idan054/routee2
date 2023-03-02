/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsCoversGen {
  const $AssetsCoversGen();

  /// File path: assets/covers/bar_pub.png
  AssetGenImage get barPub => const AssetGenImage('assets/covers/bar_pub.png');

  /// File path: assets/covers/board_games.png
  AssetGenImage get boardGames =>
      const AssetGenImage('assets/covers/board_games.png');

  /// File path: assets/covers/lecture.png
  AssetGenImage get lecture => const AssetGenImage('assets/covers/lecture.png');

  /// File path: assets/covers/other_event.png
  AssetGenImage get otherEvent =>
      const AssetGenImage('assets/covers/other_event.png');

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
  List<AssetGenImage> get values => [
        barPub,
        boardGames,
        lecture,
        otherEvent,
        party,
        show,
        sport,
        trip,
        weekend
      ];
}

class Assets {
  Assets._();

  static const AssetGenImage gPSIconWhite =
      AssetGenImage('assets/GPS-icon-White.png');
  static const AssetGenImage addOnlyX = AssetGenImage('assets/add-Only-X.png');
  static const AssetGenImage addOnlyWhite =
      AssetGenImage('assets/add-Only-white.png');
  static const AssetGenImage addWithBg =
      AssetGenImage('assets/add-with-bg.png');
  static const AssetGenImage appIcon = AssetGenImage('assets/app_icon.png');
  static const $AssetsCoversGen covers = $AssetsCoversGen();
  static const AssetGenImage tagsAndIcon =
      AssetGenImage('assets/tagsAndIcon.png');
  static const AssetGenImage tagsAndIconWide =
      AssetGenImage('assets/tagsAndIconWide.png');
  static const AssetGenImage tagsX = AssetGenImage('assets/tagsX.png');
  static const AssetGenImage whatsappXxl =
      AssetGenImage('assets/whatsapp-xxl.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        gPSIconWhite,
        addOnlyX,
        addOnlyWhite,
        addWithBg,
        appIcon,
        tagsAndIcon,
        tagsAndIconWide,
        tagsX,
        whatsappXxl
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
