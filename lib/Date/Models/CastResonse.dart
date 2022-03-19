import 'package:movies/Date/Models/Cast.dart';

class CastResponse{
  List<Cast> casts;
  String error;
  CastResponse(this.casts, this.error);
  CastResponse.fromJson(Map<String,dynamic> json)
  {
    casts=  json['cast'] != null && (json['cast'] as List).length > 0
      ? List.from(json['cast']).map((element) => Cast.fromJson(element))
      .toSet().toList()
      : [];
 error=json["error"]!=null?json["error"]:"";
  }

}