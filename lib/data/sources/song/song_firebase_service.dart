import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {

  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await getIt<IsFavoriteSongUseCase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);

    } catch (e) {
      print(e);
      return const Left('An error occurred, please try again.');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await getIt<IsFavoriteSongUseCase>().call(
            params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);

    } catch (e) {
      print(e);
      return const Left('An error occurred, please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? user = auth.currentUser;

      if (user == null) {
        return const Left('User not logged in');
      }

      String uId = user.uid;

      QuerySnapshot favoriteSong = await firestore.collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        await favoriteSong.docs.first.reference.delete();
        return const Right(false);
      } else {
        await firestore.collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now()
        });
        return const Right(true);
      }
    } catch (e) {
      print(e);
      return const Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? user = auth.currentUser;

      if (user == null) return false;

      String uId = user.uid;

      QuerySnapshot favoriteSong = await firestore.collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSong.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? user = auth.currentUser;

      if (user == null) {
        return const Left('User not logged in');
      }

      String uId = user.uid;

      QuerySnapshot favoritesSnapshot = await firestore.collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();

      List<SongEntity> favoriteSongs = [];

      for (var element in favoritesSnapshot.docs) {
        final data = element.data() as Map<String, dynamic>;
        if (data.containsKey('songId')) {
          String songId = data['songId'];
          var songSnapshot = await firestore.collection('Songs').doc(songId).get();
          if (songSnapshot.exists && songSnapshot.data() != null) {
            var songModel = SongModel.fromJson(songSnapshot.data()!);
            songModel.isFavorite = true;
            songModel.songId = songId;
            favoriteSongs.add(songModel.toEntity());
          }
        }
      }

      return Right(favoriteSongs);
    } catch (e) {
      print(e);
      return const Left('An error occurred');
    }
  }
}
