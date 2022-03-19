

import 'package:movies/Date/Models/Video.dart';

class VideoResponse{
  List<Video> videos;
  String error;
  VideoResponse(this.videos, this.error);
  VideoResponse.fromJson(Map<String,dynamic> json)
  {
    videos=  json['results'] != null && (json['results'] as List).length > 0
      ? List.from(json['results']).map((element) => Video.fromJson(element))
      .toSet().toList()
      : [];
 error=json["error"]!=null?json["error"]:"";
  }

}