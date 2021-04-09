import 'package:kuma_flutter_app/util/date_util.dart';

class GenreData {

  String type;
  String q;
  String page;
  String status;
  String rated;
  String genre;
  String startDate;
  String endDate;
  String genreExclude;
  String limit;
  String sort;

  GenreData({type, q, page, status, rated, genre, startDate, endDate, genreExclude, limit, sort}) : this.type = type ?? "" , this.q = q ?? ""  , this.page = page ?? "1" , this.rated = rated ?? "" , this.genre = genre ?? "" , this.startDate = startDate ?? "",
  this.endDate = endDate ?? "",  this.limit = limit ?? "",  this.sort = sort ?? "" , this.genreExclude = genreExclude ?? "" , this.status = status ?? "";

  GenreData copyWith({type, q, page, status, rated, genre, startDate, endDate, genreExclude, limit, sort}){
    return GenreData(type: type??this.type , q: q ?? this.q , page: page ?? this.page , status: status ?? this.status , rated: rated ?? this.rated ,genre: genre ?? this.genre , startDate: startDate ??  this.startDate , endDate: endDate ?? this.endDate
      ,sort: sort ?? this.sort , limit: limit ?? this.limit , genreExclude:  genreExclude ?? this.genreExclude);
  }

}