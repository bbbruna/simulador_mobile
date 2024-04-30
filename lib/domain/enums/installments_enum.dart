enum InstallmentsEnum {
  empty(0),
  thirtySix(36),
  fortyEight(48),
  sixty(60),
  seventyTwo(72),
  eightyFour(84);

  final int value;

  const InstallmentsEnum(this.value);

  String get intToString {
    switch (this) {
      case InstallmentsEnum.empty:
        return "";
      case InstallmentsEnum.thirtySix:
        return "36";
      case InstallmentsEnum.fortyEight:
        return "48";
      case InstallmentsEnum.sixty:
        return "60";
      case InstallmentsEnum.seventyTwo:
        return "72";
      case InstallmentsEnum.eightyFour:
        return "84";
    }
  }

  factory InstallmentsEnum.fromTitle(String title) {
    return InstallmentsEnum.values
        .firstWhere((item) => item.intToString == title);
  }
}
