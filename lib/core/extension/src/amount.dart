extension Amount on String {
  String formatNumber() {
    final formatted = StringBuffer();
    var count = 0;

    for (var i = length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        formatted.write(' ');
      }
      formatted.write(this[i]);
      count++;
    }

    return formatted.toString().split('').reversed.join();
  }
}
