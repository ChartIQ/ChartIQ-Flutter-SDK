class SymbolModel {
  final String symbol;

  SymbolModel({required this.symbol});

  @override
  int get hashCode => symbol.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SymbolModel &&
            runtimeType == other.runtimeType &&
            symbol == other.symbol;
  }
}
