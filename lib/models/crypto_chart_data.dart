class CryptoChartData {
  CryptoChartData(DateTime time, this.yValue) {
    this.time = time.toLocal();
  }

  late final DateTime time;
  final double yValue;
}
