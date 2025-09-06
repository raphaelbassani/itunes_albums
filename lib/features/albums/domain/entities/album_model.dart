import 'package:equatable/equatable.dart';

class AlbumModel extends Equatable {
  final String artUrl;
  final String name;
  final String artistName;
  final DateTime releaseDate;
  final String genre;
  final int trackCount;
  final Duration totalDuration;

  const AlbumModel({
    required this.artUrl,
    required this.name,
    required this.artistName,
    required this.releaseDate,
    required this.genre,
    required this.trackCount,
    required this.totalDuration,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? imageList = json['im:image'];
    String artUrl = '';
    if (imageList != null && imageList.isNotEmpty) {
      artUrl = imageList.last['label'] as String;
    }

    final albumName = (json['im:name']?['label'] ?? '') as String;

    final artistName = (json['im:artist']?['label'] ?? '') as String;

    DateTime parsedRelease =
        DateTime.tryParse(
          (json['im:releaseDate']?['label'] as String?) ?? '',
        ) ??
        DateTime.fromMillisecondsSinceEpoch(0);

    final genre = (json['category']?['attributes']?['label'] ?? '') as String;

    int count = 0;
    final trackCountStr =
        (json['im:itemCount']?['label'] ?? json['im:trackCount']?['label'])
            as String?;
    if (trackCountStr != null) {
      count = int.tryParse(trackCountStr) ?? 0;
    }

    Duration totalDur = Duration.zero;
    final durationStr = json['link']?['attributes']?['duration'] as String?;
    if (durationStr != null) {
      final seconds = int.tryParse(durationStr) ?? 0;
      totalDur = Duration(seconds: seconds);
    }

    return AlbumModel(
      artUrl: artUrl,
      name: albumName,
      artistName: artistName,
      releaseDate: parsedRelease,
      genre: genre,
      trackCount: count,
      totalDuration: totalDur,
    );
  }

  @override
  List<Object?> get props => [
    artUrl,
    name,
    artistName,
    releaseDate,
    genre,
    trackCount,
    totalDuration,
  ];
}
