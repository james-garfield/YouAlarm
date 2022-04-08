import 'package:youalarm/controller/db.dart';
import 'package:youalarm/utils/json_helper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

typedef Sounds = List<Sound>;

class Sound {
  /// The title of the sound.
  final String? title;

  /// The author
  final String? author;

  /// The youtube id
  final String? yId;

  /// Where is this sound located on the device?
  final String? location;

  /// How long is this sound.
  final Duration? duration;

  /// The thumbnail
  final String? thumbnail;

  /// The sounds id
  final int? id;

  /// The stream that handles downloading. This is only active when downloading.
  final AudioOnlyStreamInfo? streamInfo;

  Sound({
    this.title,
    this.yId,
    this.location,
    this.duration,
    this.thumbnail,
    this.id,
    this.streamInfo,
    this.author,
  });

  factory Sound.fromJson(Map<String, dynamic> json) {
    return Sound(
      title: parseString(json[YADB.soundTitle]),
      yId: parseString(json[YADB.soundYId]),
      location: parseString(json[YADB.soundLocation]),
      duration: parseDuration(json[YADB.soundDuration]),
      thumbnail: parseString(json[YADB.soundThumbnail]),
      id: parseInt(json[YADB.soundId]),
      author: parseString(json[YADB.soundAuthor]),
    );
  }

  Json toJson({bool withId = true}) {
    var map = {
      YADB.soundTitle: title,
      YADB.soundYId: yId,
      YADB.soundLocation: location,
      YADB.soundDuration: duration?.inMilliseconds,
      YADB.soundThumbnail: thumbnail,
      YADB.soundAuthor: author,
    };

    if (withId) {
      map[YADB.soundId] = id;
    }

    return map;
  }

  static Sounds fromJsonList(SQLs json) {
    return json.map((e) => Sound.fromJson(e!)).toList();
  }

  static Sound editLocation(Sound current, String location) {
    return Sound(
      title: current.title,
      duration: current.duration,
      id: current.id,
      location: location,
      streamInfo: current.streamInfo,
      thumbnail: current.thumbnail,
      yId: current.yId,
      author: current.author,
    );
  }
}
