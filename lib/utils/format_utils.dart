String durationTransform(int second) {
  int m = (second / 60).truncate();
  int s = second - m * 60;
  if (s > 10) {
    return '$m:0$s';
  }
  return '$m:0$s';
}

String countFormat(int count) {
  String countStr = "";
  if (count > 9999) {
    countStr = "${(count / 10000).toStringAsFixed(2)}万";
  } else {
    countStr = count.toString();
  }
  return countStr;
}
