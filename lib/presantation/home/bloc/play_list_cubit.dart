import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_play_list.dart';
import 'package:spotify/service_locator.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;
  PlayListLoaded({required this.songs});
}

class PlayListLoadFailure extends PlayListState {}

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await getIt<GetPlayListUseCase>().call();
    returnedSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      (r) {
        emit(PlayListLoaded(songs: r));
      }
    );
  }
}
