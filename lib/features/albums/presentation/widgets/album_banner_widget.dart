import 'package:flutter/material.dart';

import '../../../../core/ui/ui_dimens.dart';
import '../../../../core/ui/ui_text.dart';
import '../../../../core/ui/ui_title.dart';
import '../../domain/entities/album_model.dart';

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
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Hero(
                  tag: '${album.name}-img',
                  child: Image.asset(
                    album.artUrl,
                    fit: BoxFit.cover,
                    height: 60.0,
                    width: 60.0,
                  ),
                ),
              ),
              UISpacingInLine.df,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [UITitle(album.name), UIText(album.artistName)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
