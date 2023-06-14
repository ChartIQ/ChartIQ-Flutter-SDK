class OptionItemModel {
  final String title;
  final String? prettyTitle;
  final bool isChecked;

  const OptionItemModel({
    required this.title,
    this.prettyTitle,
    required this.isChecked,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionItemModel &&
          runtimeType == other.runtimeType &&
          title.toLowerCase() == other.title.toLowerCase();

  @override
  int get hashCode => title.hashCode;

  OptionItemModel copyWith({
    String? title,
    bool? isChecked,
    String? prettyTitle,
  }) {
    return OptionItemModel(
      title: title ?? this.title,
      prettyTitle: prettyTitle ?? this.prettyTitle,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
