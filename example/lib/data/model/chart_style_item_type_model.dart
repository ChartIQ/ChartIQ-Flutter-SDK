class ChartTypeItemModel {
  final String title;
  final String icon;
  final String name;

  ChartTypeItemModel({
    required this.title,
    required this.name,
    required this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartTypeItemModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          name == other.name &&
          icon == other.icon;

  @override
  int get hashCode => title.hashCode ^ name.hashCode ^ icon.hashCode;
}
