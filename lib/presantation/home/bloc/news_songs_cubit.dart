import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/service_locator.dart';

abstract class NewsSongsState {}

class NewsSongsLoading extends NewsSongsState {}

class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({required this.songs});
}

class NewsSongsLoadFailure extends NewsSongsState {}

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await getIt<GetNewsSongsUseCase>().call();
    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (r) {
        emit(NewsSongsLoaded(songs: r));
      }
    );
  }
}
