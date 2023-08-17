enum DrawingToolSection {
  other("other"),
  main("main");

  final String value;

  const DrawingToolSection(this.value);

  String getPrettyTitle() {
    switch (this) {
      case DrawingToolSection.other:
        return 'Other tools';
      case DrawingToolSection.main:
        return 'Main tools';
    }
  }
}
