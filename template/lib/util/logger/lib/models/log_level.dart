enum LogLevel {
  trace(0),
  debug(1),
  info(2),
  warning(3),
  error(4),
  fatal(5);

  const LogLevel(this.value);

  final int value;

  bool operator >=(LogLevel other) => value >= other.value;
}
