import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import 'core/extensions/fade_navigation.dart';
import 'core/ui/ui_app_bar_title.dart';
import 'core/ui/ui_dimens.dart';
import 'features/albums/data/errors/failures.dart';
import 'features/albums/domain/entities/album_model.dart';
import 'features/albums/presentation/pages/album_page.dart';
import 'features/albums/presentation/widgets/album_banner_widget.dart';
import 'features/albums/providers/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Itunes albums',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const UIAppBarTitle('Itunes albums'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Column(
          children: [
            if (state.status.isLoading) const _LoadingWidget(),
            if (state.status.isFailure)
              _FailureWidget(failure: state.failure, onRetry: refresh),
            if (state.status.isSuccess)
              ListView(
                children: <Widget>[
                  UISpacingStack.sm,
                  Column(
                    children: state.albums.map((album) {
                      return AlbumBannerWidget(
                        album: album,
                        onSelected: (selected) =>
                            onSelected(selected, state.albums),
                      );
                    }).toList(),
                  ),
                  UISpacingStack.lg,
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> refresh() async {
    await ref.read(albumViewModelProvider.notifier).fetchTopAlbums();
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}

class _FailureWidget extends StatelessWidget {
  final Failure? failure;
  final VoidCallback onRetry;

  const _FailureWidget({required this.failure, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            failure?.message ?? 'Unknown error',
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
