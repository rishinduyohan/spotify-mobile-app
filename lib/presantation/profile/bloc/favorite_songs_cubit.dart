import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify/service_locator.dart';

abstract class FavoriteSongsState {}

class FavoriteSongsLoading extends FavoriteSongsState {}

class FavoriteSongsLoaded extends FavoriteSongsState {
  final List<SongEntity> songs;
  FavoriteSongsLoaded({required this.songs});
}

class FavoriteSongsFailure extends FavoriteSongsState {}

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  Future<void> getFavoriteSongs() async {
    var result = await getIt<GetUserFavoriteSongsUseCase>().call();
    result.fold(
      (l) {
        emit(FavoriteSongsFailure());
      },
      (r) {
        emit(FavoriteSongsLoaded(songs: r));
      }
    );
  }

  void removeSong(int index) {
    if (state is FavoriteSongsLoaded) {
      final songs = (state as FavoriteSongsLoaded).songs;
      songs.removeAt(index);
      emit(FavoriteSongsLoaded(songs: songs));
    }
  }
}
