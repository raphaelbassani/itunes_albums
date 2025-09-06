import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/fade_navigation.dart';
import '../../../../core/ui/ui_app_bar.dart';
import '../../../../core/ui/ui_dimens.dart';
import '../../../../core/ui/ui_text.dart';
import '../../../../core/ui/ui_title.dart';
import '../../data/errors/failures.dart';
import '../../data/models/album_model.dart';
import '../../data/models/album_state.dart';
import '../../providers/providers.dart';
import '../widgets/album_banner_widget.dart';
import 'album_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late bool returnFromDetailPage = false;
  late ValueNotifier<bool> stateNotifier;

  @override
  void initState() {
    super.initState();
    _initAnimationController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  void _initAnimationController() {
    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        )..addListener(() {
          setState(() {});
        });

    stateNotifier = ValueNotifier(returnFromDetailPage)
      ..addListener(() {
        if (stateNotifier.value) {
          _animationController.reverse(from: 1.0);
          stateNotifier.value = false;
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    stateNotifier.dispose();
    super.dispose();
  }

  void onSelected(AlbumModel album, List<AlbumModel> albumList) async {
    _animationController.forward(from: 0.0);
    stateNotifier.value = await context.pushFade(
      AlbumPage(albumList: albumList, selectedIndex: albumList.indexOf(album)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(albumViewModelProvider);

    return Scaffold(
      appBar: const UIAppBar(title: 'Itunes albums'),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: CustomScrollView(
          slivers: [
            if (state.status.isLoading) const _LoadingWidget(),
            if (state.status.isFailure)
              _FailureWidget(failure: state.failure, onRetry: refresh),
            if (state.status.isSuccess)
              _AlbumsListWidget(onSelected: onSelected, state: state),
          ],
        ),
      ),
    );
  }

  Future<void> refresh() async {
    await ref.read(albumViewModelProvider.notifier).fetchTopAlbums();
  }
}

class _AlbumsListWidget extends StatelessWidget {
  final Function(AlbumModel, List<AlbumModel> albumList) onSelected;
  final AlbumState state;

  const _AlbumsListWidget({required this.onSelected, required this.state});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: UIPaddingHorizontal.df + UIPaddingVertical.sm,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final album = state.albums[index];
          return AlbumBannerWidget(
            album: album,
            onSelected: (selected) => onSelected(selected, state.albums),
          );
        }, childCount: state.albums.length),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 15,
        (context, index) => Padding(
          padding:
              UIPaddingHorizontal.lg +
              UIPaddingHorizontal.df +
              UIPaddingVertical.sm,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Container(width: 60, height: 60, color: Colors.white),
                UISpacingInLine.df,
                const Column(
                  children: [
                    _ShimmerTextContainerWidget(),
                    UISpacingStack.xxs,
                    _ShimmerTextContainerWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerTextContainerWidget extends StatelessWidget {
  const _ShimmerTextContainerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(width: context.width / 2, height: 14, color: Colors.white);
  }
}

class _FailureWidget extends StatelessWidget {
  final Failure? failure;
  final VoidCallback onRetry;

  const _FailureWidget({required this.failure, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: UIPadding.df,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UITitle(failure?.message ?? 'Unknown error', color: Colors.red),
              UISpacingStack.df,
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const UIText('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
