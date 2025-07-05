import '../screen_spec_core.dart';

/// helper for typed-segment <=> string-segment conversion
extension UrlParsEx on UrlParams {
  UrlParams setInt(String name, int? value) => _set<int>(name, value);
  UrlParams setString(String name, String? value) => _set<String>(name, value);
  UrlParams setBool(String name, bool? value) => _set<bool>(name, value);
  UrlParams setDouble(String name, double? value) => _set<double>(name, value);

  String getString(String name) => _get<String>(name, (v) => v);
  int getInt(String name) => _get<int>(name, (v) => int.parse(v));
  bool getBool(String name) => _get<bool>(name, (v) => v == 'true');
  double getDouble(String name) => _get<double>(name, (v) => double.parse(v));

  String? getStringNull(String name) => _getNull<String>(name, (v) => v);
  int? getIntNull(String name) => _getNull<int>(name, (v) => int.parse(v));
  bool? getBoolNull(String name) => _getNull<bool>(name, (v) => v == 'true');
  double? getDoubleNull(String name) =>
      _getNull<double>(name, (v) => double.parse(v));

  UrlParams _set<T>(String name, T? value) {
    if (value != null) this[name] = value.toString();
    return this;
  }

  T _get<T>(String name, T Function(String value) parse) {
    final value = this[name];
    if (value == null) throw Exception('value != null expected');
    return parse(value);
  }

  T? _getNull<T>(String name, T Function(String value) parse) {
    final value = this[name];
    return value == null ? null : parse(value);
  }
}
