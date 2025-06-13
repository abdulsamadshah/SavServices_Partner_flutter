/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/English.png
  AssetGenImage get english => const AssetGenImage('assets/images/English.png');

  /// File path: assets/images/India.png
  AssetGenImage get india => const AssetGenImage('assets/images/India.png');

  /// File path: assets/images/Support.png
  AssetGenImage get support => const AssetGenImage('assets/images/Support.png');

  /// File path: assets/images/appicon.jpg
  AssetGenImage get appicon => const AssetGenImage('assets/images/appicon.jpg');

  /// File path: assets/images/doc2.png
  AssetGenImage get doc2 => const AssetGenImage('assets/images/doc2.png');

  /// File path: assets/images/doc3.png
  AssetGenImage get doc3 => const AssetGenImage('assets/images/doc3.png');

  /// File path: assets/images/doc4.png
  AssetGenImage get doc4 => const AssetGenImage('assets/images/doc4.png');

  /// File path: assets/images/docc1.png
  AssetGenImage get docc1 => const AssetGenImage('assets/images/docc1.png');

  /// File path: assets/images/enternetlost.jpg
  AssetGenImage get enternetlost =>
      const AssetGenImage('assets/images/enternetlost.jpg');

  /// File path: assets/images/introuductionicon.png
  AssetGenImage get introuductionicon =>
      const AssetGenImage('assets/images/introuductionicon.png');

  /// File path: assets/images/lost_internets.png
  AssetGenImage get lostInternets =>
      const AssetGenImage('assets/images/lost_internets.png');

  /// File path: assets/images/profileui.png
  AssetGenImage get profileui =>
      const AssetGenImage('assets/images/profileui.png');

  /// File path: assets/images/server_error.png
  AssetGenImage get serverError =>
      const AssetGenImage('assets/images/server_error.png');

  /// File path: assets/images/steptwoillustrator.png
  AssetGenImage get steptwoillustrator =>
      const AssetGenImage('assets/images/steptwoillustrator.png');

  /// File path: assets/images/whatsapp.png
  AssetGenImage get whatsapp =>
      const AssetGenImage('assets/images/whatsapp.png');

  /// File path: assets/images/youtube.png
  AssetGenImage get youtube => const AssetGenImage('assets/images/youtube.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    english,
    india,
    support,
    appicon,
    doc2,
    doc3,
    doc4,
    docc1,
    enternetlost,
    introuductionicon,
    lostInternets,
    profileui,
    serverError,
    steptwoillustrator,
    whatsapp,
    youtube,
  ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/profileback.svg
  String get profileback => 'assets/svg/profileback.svg';

  /// List of all assets
  List<String> get values => [profileback];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
