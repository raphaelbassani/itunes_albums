import 'package:flutter/material.dart';

import '../../../../core/ui/ui_cached_network_image.dart';
import '../../../../core/ui/ui_dimens.dart';
import '../../../../core/ui/ui_text.dart';
import '../../../../core/ui/ui_title.dart';
import '../../data/models/album_model.dart';

class AlbumBannerWidget extends StatelessWidget {
  final AlbumModel album;
  final Function(AlbumModel) onSelected;

  const AlbumBannerWidget({
    required this.album,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIPaddingHorizontal.lg + UIPaddingVertical.sm,
      child: GestureDetector(
        onTap: () => onSelected(album),
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Hero(
                tag: '${album.name}-img',
                child: UICachedNetworkImage(imageUrl: album.artUrl),
              ),
              UISpacingInLine.df,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [UITitle(album.name), UIText(album.artistName)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
