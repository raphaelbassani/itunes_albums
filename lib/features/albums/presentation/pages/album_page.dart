import 'package:flutter/material.dart';

import '../../../../core/enums/slide_direction_enum.dart';
import '../../../../core/ui/enums/ui_nav_button_state.dart';
import '../../../../core/ui/ui_app_bar.dart';
import '../../../../core/ui/ui_cached_network_image.dart';
import '../../../../core/ui/ui_dimens.dart';
import '../../../../core/ui/ui_nav_button.dart';
import '../../../../core/ui/ui_subtitle.dart';
import '../../../../core/ui/ui_text.dart';
import '../../../../core/ui/ui_title.dart';
import '../../data/models/album_model.dart';

class AlbumPage extends StatefulWidget {
  final List<AlbumModel> albumList;
  final int selectedIndex;

  const AlbumPage({
    required this.albumList,
    required this.selectedIndex,
    super.key,
  });

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> with TickerProviderStateMixin {
  int currentIndex = 0;
  int offstageIndex = 0;
  SlideDirectionEnum slideDirection = SlideDirectionEnum.none;
  late ValueNotifier<SlideDirectionEnum> slideNotifier;

  late AnimationController _slideLeftAnimation;
  late Animation<Offset> heroSlide;
  late Animation<Offset> offstageSlide;
  late double contentSpacing;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex;

    slideNotifier = ValueNotifier(slideDirection)
      ..addListener(() {
        setState(() {
          animate();
        });
      });

    _slideLeftAnimation =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 300),
          )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              updateContents();
            }
          });
  }

  @override
  void dispose() {
    _slideLeftAnimation.dispose();
    slideNotifier.dispose();
    super.dispose();
  }

  void animate() {
    switch (slideNotifier.value) {
      case SlideDirectionEnum.leftToRight:
        heroSlide =
            Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: Offset(contentSpacing, 0.0),
            ).animate(
              CurvedAnimation(
                parent: _slideLeftAnimation,
                curve: Curves.easeInOut,
              ),
            );

        offstageSlide =
            Tween<Offset>(
              begin: Offset(-contentSpacing, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(
              CurvedAnimation(
                parent: _slideLeftAnimation,
                curve: Curves.easeInOut,
              ),
            );

        _slideLeftAnimation.forward(from: 0.0);
        break;
      case SlideDirectionEnum.rightToLeft:
        heroSlide =
            Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: Offset(-contentSpacing, 0.0),
            ).animate(
              CurvedAnimation(
                parent: _slideLeftAnimation,
                curve: Curves.easeInOut,
              ),
            );

        offstageSlide =
            Tween<Offset>(
              begin: Offset(contentSpacing, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(
              CurvedAnimation(
                parent: _slideLeftAnimation,
                curve: Curves.easeInOut,
              ),
            );

        _slideLeftAnimation.forward(from: 0.0);
        break;
      default:
        break;
    }
  }

  void updateContents() {
    switch (slideNotifier.value) {
      case SlideDirectionEnum.leftToRight:
        currentIndex = (currentIndex - 1).clamp(0, widget.albumList.length - 1);
        slideNotifier.value = SlideDirectionEnum.none;
        break;
      case SlideDirectionEnum.rightToLeft:
        currentIndex = (currentIndex + 1).clamp(0, widget.albumList.length - 1);
        slideNotifier.value = SlideDirectionEnum.none;
        break;
      default:
        break;
    }
  }

  double dx({bool isHero = false}) {
    switch (slideNotifier.value) {
      case SlideDirectionEnum.leftToRight:
        return isHero ? heroSlide.value.dx : offstageSlide.value.dx;
      case SlideDirectionEnum.rightToLeft:
        return isHero ? heroSlide.value.dx : offstageSlide.value.dx;
      default:
        return isHero ? 0.0 : contentSpacing;
    }
  }

  void _onPrevPressed() {
    if (currentIndex == 0) {
      return;
    }
    offstageIndex = currentIndex - 1;
    slideNotifier.value = SlideDirectionEnum.leftToRight;
  }

  void _onNextPressed() {
    if (currentIndex == widget.albumList.length - 1) {
      return;
    }
    offstageIndex = currentIndex + 1;
    slideNotifier.value = SlideDirectionEnum.rightToLeft;
  }

  @override
  Widget build(BuildContext context) {
    contentSpacing = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const UIAppBar(hasLeading: true),
      body: Stack(
        children: <Widget>[
          _DetailContentWidget(
            album: widget.albumList[currentIndex],
            dx: dx(isHero: true),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                UINavButton(
                  onPressed: _onPrevPressed,
                  icon: Icons.arrow_back_ios,
                  state:
                      currentIndex < widget.albumList.length &&
                          currentIndex != 0
                      ? UINavButtonState.enabled
                      : UINavButtonState.disabled,
                ),
                UINavButton(
                  onPressed: _onNextPressed,
                  icon: Icons.arrow_forward_ios,
                  state:
                      currentIndex < widget.albumList.length &&
                          currentIndex != widget.albumList.length - 1
                      ? UINavButtonState.enabled
                      : UINavButtonState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailContentWidget extends StatelessWidget {
  final double dx;
  final AlbumModel album;

  const _DetailContentWidget({required this.album, this.dx = 0.0});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final Matrix4 transform = Matrix4.translationValues(dx * 1.2, 0.0, 0.0);

    return ListView(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 380.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                top: 50.0,
                left: dx * 1.5,
                child: Opacity(
                  opacity: 1.0 - (dx.abs() / width),
                  child: Hero(
                    tag: '${album.name}-img',
                    child: UICachedNetworkImage(
                      imageUrl: album.artUrl,
                      height: 300,
                      width: width * 0.9,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Transform(
          transform: transform,
          child: Padding(
            padding: UIPaddingHorizontal.df,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _AlbumModel(album: album),
                UISpacingStack.sm,
                _AlbumDetailWidget(album: album),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AlbumModel extends StatelessWidget {
  final AlbumModel album;

  const _AlbumModel({required this.album});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UITitle(album.name),
        UISpacingStack.xxs,
        UIText(album.artistName),
      ],
    );
  }
}

class _AlbumDetailWidget extends StatelessWidget {
  final AlbumModel album;

  const _AlbumDetailWidget({required this.album});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (album.formattedReleaseDate != null)
          UISubtitle('Release date: ${album.formattedReleaseDate}'),
        if (album.genre != null) UISubtitle('Genre: ${album.genre}'),
        if (album.formattedTrackCount != null)
          UISubtitle('Tracks: ${album.formattedTrackCount}'),
      ],
    );
  }
}
