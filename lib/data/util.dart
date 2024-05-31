class Util {
  String addCommas(int number) {
    String numberStr = number.toString();
    int length = numberStr.length;

    if (length <= 3) {
      return numberStr;
    }

    int firstCommaIndex = length % 3;

    if (firstCommaIndex == 0) {
      firstCommaIndex = 3;
    }

    String result = numberStr.substring(0, firstCommaIndex);

    for (int i = firstCommaIndex; i < length; i += 3) {
      result += ',' + numberStr.substring(i, i + 3);
    }

    return result;
  }
}
