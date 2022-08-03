import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class ExternalGameIcon extends CachedNetworkImage {
  ExternalGameIcon({Key? key, required String? iconUrl})
      : super(
            key: key,
            imageUrl: iconUrl ?? "",
            width: 32,
            height: 32,
            progressIndicatorBuilder: (_, __, ___) =>
                const CircularProgressIndicator(),
            errorWidget: (_, __, ___) => const Icon(FluentIcons.photo_error));
}
