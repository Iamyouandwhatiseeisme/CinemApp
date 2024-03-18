enum Awards {
  winner('is An Academy awards winner'),
  nominee('is An Academy awards nominee'),
  any('doesn\' matter if has won any academy awards');

  const Awards(
    this.value,
  );
  final String value;
}
