import 'package:equatable/equatable.dart';

class AlbumModel extends Equatable {
  final String artUrl;
  final String name;
  final String artistName;
  final DateTime? releaseDate;
  final String? genre;
  final int? trackCount;

  const AlbumModel({
    required this.artUrl,
    required this.name,
    required this.artistName,
    required this.releaseDate,
    required this.genre,
    required this.trackCount,
  });

  String? get formattedReleaseDate => releaseDate != null
      ? '${releaseDate!.day.toString().padLeft(2, '0')}/'
            '${releaseDate!.month.toString().padLeft(2, '0')}/'
            '${releaseDate!.year}'
      : null;

  String? get formattedTrackCount =>
      trackCount != null && trackCount! > 0 ? trackCount.toString() : null;

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    final images = json['im:image'] as List;
    final artUrl = (images.isNotEmpty ? images.last['label'] as String : '');

    final albumName = (json['im:name']?['label'] ?? '') as String;

    final artistName = (json['im:artist']?['label'] ?? '') as String;

    DateTime? releaseDate = DateTime.tryParse(
      (json['im:releaseDate']?['label'] as String?) ?? '',
    );

    final genre = (json['category']?['attributes']?['label'] ?? '') as String?;

    int trackCount = 0;
    final count =
        (json['im:itemCount']?['label'] ?? json['im:trackCount']?['label'])
            as String?;
    if (count != null) {
      trackCount = int.tryParse(count) ?? 0;
    }

    return AlbumModel(
      artUrl: artUrl,
      name: albumName,
      artistName: artistName,
      releaseDate: releaseDate,
      genre: genre,
      trackCount: count != null ? trackCount : null,
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
  ];
}
