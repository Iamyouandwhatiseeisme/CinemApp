enum Awards {
  winner('Academy awards winner'),
  nominee('Academy awards nominee'),
  any('N/A');

  const Awards(this.value);
  final String value;
}
