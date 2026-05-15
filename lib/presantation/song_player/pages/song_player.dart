import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presantation/song_player/bloc/song_player_cubit.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    required this.songEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now playing',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded
          )
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          'https://firebasestorage.googleapis.com/v0/b/spotify-app-1b702.firebasestorage.app/o/songs%2F${Uri.encodeComponent('${songEntity.artist} - ${songEntity.title}')}.mp3?alt=media'
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16
          ),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20,),
              _songDetail(),
              const SizedBox(height: 30,),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/spotify-app-1b702.firebasestorage.app/o/covers%2F${Uri.encodeComponent('${songEntity.artist} - ${songEntity.title}')}.jpg?alt=media'
          )
        )
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
            ),
          ],
        ),
        FavoriteButton(
          songEntity: songEntity
        )
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble() > 0 
                    ? context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble() 
                    : 1.0,
                onChanged: (value) {
                   context.read<SongPlayerCubit>().audioPlayer.seek(
                    Duration(seconds: value.toInt())
                   );
                },
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(
                      context.read<SongPlayerCubit>().songPosition
                    )
                  ),
                  Text(
                    _formatDuration(
                      context.read<SongPlayerCubit>().songDuration
                    )
                  )
                ],
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow
                  ),
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
