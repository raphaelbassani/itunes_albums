import 'package:equatable/equatable.dart';

import '../../../../core/enums/view_model_status.dart';
import '../errors/failures.dart';
import 'album_model.dart';

class AlbumState extends Equatable {
  final ViewModelStatus status;
  final List<AlbumModel> albums;
  final Failure? failure;

  const AlbumState({
    this.status = ViewModelStatus.idle,
    this.albums = const [],
    this.failure,
  });

  AlbumState copyWith({
    ViewModelStatus? status,
    List<AlbumModel>? albums,
    Failure? failure,
  }) {
    return AlbumState(
      status: status ?? this.status,
      albums: albums ?? this.albums,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, albums, failure];
}
