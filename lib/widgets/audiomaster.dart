import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

final AudioPlayer _player = AudioPlayer();
double _volume = 0.5;
bool _isMuted = false;
int _currentindex = 0;
List<String> _activesongs = _menusongs;

final List<String> _menusongs = [
  'audio/C418 - Minecraft1.mp3',
  'audio/C418 - Minecraft2.mp3',
  'audio/C418 - Minecraft3.mp3',
  'audio/C418 - Minecraft4.mp3',
];

final List<String> _gamesongs = [
  'audio/Naruto Main Theme.mp3',
  'audio/One Piece OST Overtaken.mp3',
];

final List<String> _sounds = [
  'audio/LOSS SOUND.mp3',
  'audio/Victory Sound.mp3',
  'audio/Bruh sound.mp3',
];

Future<void> setupPlayer() async {
  await _player.setPlayerMode(PlayerMode.mediaPlayer);
  await _player.setReleaseMode(ReleaseMode.stop);

  _player.onPlayerComplete.listen((event) {
    _playNextSong();
  });

  _playcurrentsong();
}

Future<void> _playcurrentsong() async {
  await _player.setVolume(_isMuted ? 0 : _volume);
  await _player.setSource(AssetSource(_activesongs[_currentindex]));
  await _player.resume();
}

void _playNextSong() {
  if (_activesongs == _sounds) return;
  
  _currentindex = (_currentindex + 1) % _activesongs.length;

  _playcurrentsong();
}

Future<void> switchPlaylist(List<String> newPlaylist, [int? songindex]) async {

  _activesongs = newPlaylist;
  _currentindex = songindex ?? 0;

  await _player.stop();
  await _playcurrentsong();
}

Future<void> playGameMusic() async {
  await switchPlaylist(_gamesongs);
}

Future<void> playMenuMusic() async {
  await switchPlaylist(_menusongs);
}

Future<void> playsound(int songindex) async {
  await switchPlaylist(_sounds , songindex);
}

class Audiomaster extends StatefulWidget {
  const Audiomaster({super.key});

  @override
  State<Audiomaster> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Audiomaster> {
  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _player.setVolume(_isMuted ? 0 : _volume);
  }

  void _onVolumeChanged(double newVolume) {
    setState(() {
      _volume = newVolume;
      _isMuted = newVolume == 0;
    });
    _player.setVolume(newVolume);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF90CDF4),
        border: Border.all(color: const Color(0xFF111921), width: 3),
        boxShadow: const [
          BoxShadow(color: Color(0xFF111921), offset: Offset(4, 4)),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isMuted ? Icons.volume_off : Icons.volume_up,
              color: const Color(0xFF111921),
              size: 28,
            ),
            onPressed: _toggleMute,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xFF111921),
                inactiveTrackColor: Color(0xFF111921).withValues(alpha: 0.3),
                thumbColor: const Color(0xFF111921),
                trackHeight: 6.0,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 10.0,
                ),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 20.0,
                ),
              ),
              child: Slider(
                value: _isMuted ? 0 : _volume,
                min: 0,
                max: 1,
                onChanged: _onVolumeChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
