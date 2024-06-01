const _year = 31556952000;
const _month = 2629746000;
const _week = 604800000;
const _day = 86400000;
const _hour = 3600000;
const _minute = 60000;

extension DateTimeExtension on DateTime {
  String timeAgo() {
    int milDifference = DateTime.now().difference(this).inMilliseconds;
    if (milDifference >= _year) return '${milDifference ~/ _year} years ago';
    if (milDifference >= _month) return '${milDifference ~/ _month} months ago';
    if (milDifference >= _week) return '${milDifference ~/ _week} weeks ago';
    if (milDifference >= _day) return '${milDifference ~/ _day} days ago';
    if (milDifference >= _hour) return '${milDifference ~/ _hour} days ago';
    if (milDifference >= _minute)
      return '${milDifference ~/ _minute} minutes ago';
    return '${milDifference / 1000} seconds ago';
  }
}
