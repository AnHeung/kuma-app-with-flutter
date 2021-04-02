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


}
