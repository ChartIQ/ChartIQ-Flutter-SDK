/// An enumeration of available signal joiners
enum SignalJoiner {
  /// Signal or
  or("OR"),

  /// Signal and
  and("AND");

  final String value;

  const SignalJoiner(this.value);
}
