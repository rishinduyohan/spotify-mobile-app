import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presantation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify/presantation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/presantation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        backgroundColor: Color(0xff2C2B2B),
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'FAVORITE SONGS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(child: _favoriteSongs())
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff2C2B2B),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50)
          )
        ),
        child: BlocBuilder<ProfileInfoCubit,ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userModel.imageURL ?? 'https://cdn-icons-png.flaticon.com/512/10542/10542486.png')
                      )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(state.userModel.email ?? 'Unknown'),
                  const SizedBox(height: 10,),
                  Text(
                    state.userModel.fullName ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return const Center(child: Text('An error occurred, please try again.'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (_) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: BlocBuilder<FavoriteSongsCubit,FavoriteSongsState>(
        builder: (context, state) {
          if (state is FavoriteSongsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteSongsLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongPlayerPage(songEntity: state.songs[index])
                      )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/spotify-app-1b702.firebasestorage.app/o/covers%2F${Uri.encodeComponent('${state.songs[index].artist} - ${state.songs[index].title}')}.jpg?alt=media'
                                )
                              )
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.songs[index].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                state.songs[index].artist,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            state.songs[index].duration.toString().replaceAll('.', ':')
                          ),
                          const SizedBox(width: 20,),
                          FavoriteButton(
                            songEntity: state.songs[index],
                            key: UniqueKey(),
                            function: () {
                              context.read<FavoriteSongsCubit>().removeSong(index);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20,),
              itemCount: state.songs.length
            );
          }
          if (state is FavoriteSongsFailure) {
            return const Center(child: Text('An error occurred, please try again.'));
          }
          return Container();
        },
      ),
    );
  }
}
