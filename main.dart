import 'dart:math';

// The Music class represents a single piece of music.
class Music {
  String music_title;  // Title of the music
  String artist;       // Artist who performs the music
  int duration;        // Duration of the music in seconds

  // Constructor to initialize the Music object
  Music(this.music_title, this.artist, this.duration);

  // Method to display music details in a readable format
  String display_music() {
    int minutes = duration ~/ 60;  // Calculate minutes
    int seconds = duration % 60;  // Calculate seconds
    return '$music_title by $artist (${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')})';
  }
}

// The Playlist class represents a collection of Music.
class Playlist {
  String playlist_name;  // Name of the playlist
  List<Music> musics = [];  // List to hold Music objects

  // Constructor to initialize the Playlist object
  Playlist(this.playlist_name);

  // Method to add a Music item to the playlist
  void add_music(Music music) {
    musics.add(music);
  }

  // Method to display all musics in the playlist
  void display_playlist() {
    print('Playlist: $playlist_name');
    musics.forEach((music) => print(music.display_music()));
  }

  // Method to sort musics by artist's name
  void sort_musics_by_artist() {
    musics.sort((a, b) => a.artist.compareTo(b.artist));
  }
}

// The MusicFestival class represents a music festival with multiple playlists.
class MusicFestival {
  String festival_name;  // Name of the music festival
  List<Playlist> stages = [];  // List to hold Playlist objects

  // Constructor to initialize the MusicFestival object
  MusicFestival(this.festival_name);

  // Method to add a Playlist to the festival
  void add_stage(Playlist playlist) {
    stages.add(playlist);
  }

  // Method to display details of the music festival
  void display_festival() {
    print('Music Festival: $festival_name');
    stages.forEach((stage) {
      stage.display_playlist();  // Display each playlist
      print('---');
    });
  }

  // Method to calculate the total duration of all music in the festival
  int total_festival_duration() {
    return stages
        .expand((stage) => stage.musics)  // Combine all musics from all stages
        .fold(0, (total, music) => total + music.duration);  // Sum up durations
  }

  // Method to display a random music from each playlist
  void display_random_musics() {
    print('Random Musics:');
    stages.forEach((stage) {
      Music random_music = stage.musics[Random().nextInt(stage.musics.length)];
      print('${stage.playlist_name}: ${random_music.display_music()}');
    });
  }
}

void main() {
  print('Jose Marie Depositar\n');

  // Create Music objects
  Music music1 = Music('Smells Like Teen Spirit', 'Nirvana', 301);
  Music music2 = Music('In the End', 'Linkin Park', 216);
  Music music3 = Music('American Idiot', 'Green Day', 177);
  Music music4 = Music('Sugar, We\'re Goin Down', 'Fall Out Boy', 227);
  Music music5 = Music('What I\'ve Done', 'Linkin Park', 203);
  Music music6 = Music('Basket Case', 'Green Day', 184);
  Music music7 = Music('Teenagers', 'My Chemical Romance', 166);

  // Create Playlist objects and add Music to them
  Playlist main_stage = Playlist('Main Stage');
  main_stage.add_music(music1);
  main_stage.add_music(music2);
  main_stage.add_music(music3);
  main_stage.add_music(music4);
  main_stage.add_music(music5);

  Playlist indie_stage = Playlist('Indie Stage');
  indie_stage.add_music(music6);
  indie_stage.add_music(music4);
  indie_stage.add_music(music1);

  Playlist electronic_stage = Playlist('Electronic Stage');
  electronic_stage.add_music(music7);
  electronic_stage.add_music(music3);
  electronic_stage.add_music(music2);

  // Create MusicFestival object and add Playlists to it
  MusicFestival festival = MusicFestival('Rock Fest');
  festival.add_stage(main_stage);
  festival.add_stage(indie_stage);
  festival.add_stage(electronic_stage);

  // Print total duration of the festival
  print('Total Festival Duration: ${festival.total_festival_duration()} seconds\n');
  // Display random musics from each playlist
  festival.display_random_musics();

  // Sort and display the musics in the main stage by artist
  main_stage.sort_musics_by_artist();
  print('Main Stage playlist sorted by artist:\n');
  main_stage.display_playlist();
}
