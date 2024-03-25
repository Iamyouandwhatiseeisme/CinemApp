enum Genre {
  action("Action"),
  adventure("Adventure"),
  animation("Animation"),
  comedy("Comedy"),
  crime("Crime"),
  drama("Drama"),
  fantasy("Fantasy"),
  horror("Horror"),
  mystery("Mystery"),
  romance("Romance"),
  scifi("Sci-fi"),
  thriller("Thriller"),
  filmnoir("Film-noir"),
  history("History"),
  documentary("Documentary"),
  music("Music"),
  musical("Musical"),
  short("Short"),
  sport("Sport"),
  biography("Biography"),
  family("Family"),
  tvshow("TV-Show"),
  war("war"),
  western("Western");

  const Genre(this.value);
  final String value;
}
