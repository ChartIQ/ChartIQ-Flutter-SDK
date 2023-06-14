class SymbolFullModel {
  final String symbol;
  final String fullName;
  final String fund;

  const SymbolFullModel({
    required this.symbol,
    required this.fullName,
    required this.fund,
  });

  factory SymbolFullModel.fromString(String string) {
    final list = string.split('|');
    return SymbolFullModel(
      symbol: list[0],
      fullName: list[1],
      fund: list[2],
    );
  }

  SymbolFullModel.fromSymbolOnly(this.symbol)
      : fullName = '',
        fund = '';
}