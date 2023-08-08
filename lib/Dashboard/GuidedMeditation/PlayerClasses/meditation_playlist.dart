import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

List<AudioSource> meditationPlayList = [
  AudioSource.uri(
    Uri.parse('asset:///assets/sounds/happy.mp3'),
    tag: MediaItem(
      id: "0",
      title: "Happiness",
      // artUri: Uri.tryParse('asset:///assets/images/logo.png'),
      artUri: Uri.tryParse('assets/images/yoga/cat.png'),
    ),
  ),
  AudioSource.uri(
    Uri.parse('asset:///assets/sounds/sleep.mp3'),
    tag: MediaItem(
      id: "1",
      title: "Focus",
      // artUri: Uri.tryParse('asset:///assets/images/logo.png'),
      artUri: Uri.tryParse('assets/images/yoga/cow.png'),
    ),
  ),
  AudioSource.uri(
    Uri.parse('asset:///assets/sounds/sleep.mp3'),
    tag: MediaItem(
      id: "2",
      title: "Sleep",
      // artUri: Uri.tryParse('asset:///assets/images/logo.png'),
      artUri: Uri.tryParse('assets/images/yoga/thunderbolt.png'),
    ),
  ),
  AudioSource.uri(
    Uri.parse('asset:///assets/sounds/happy.mp3'),
    tag: MediaItem(
      id: "3",
      title: "Relax",
      // artUri: Uri.tryParse('asset:///assets/images/logo.png'),
      artUri: Uri.tryParse('assets/images/yoga/cobra.png'),
    ),
  ),
];
