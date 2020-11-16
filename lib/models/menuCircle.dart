class MenuCircle {
  final String name;
  final String label;
  final String icon;
  final int backgroundColor;
  final double width;
  final double height;

  MenuCircle(
      {this.name,
      this.label,
      this.icon,
      this.backgroundColor,
      this.width,
      this.height});

  String get getName => name;
  String get getLabel => label;
  String get getIcon => icon;
  int get getBackgroundColor => backgroundColor;
  double get getWidth => width;
  double get getHeight => height;
}

List<MenuCircle> menuCircles = [
  MenuCircle(
      name: 'tomarAgua',
      label: 'Tomar Água',
      icon: 'assets/icons/garrafa.png',
      backgroundColor: 0xFF2885EB,
      width: 14.5,
      height: 35.74),
  MenuCircle(
      name: 'postura',
      label: 'Postura',
      icon: 'assets/icons/ajeitar_postura.png',
      backgroundColor: 0xFFF4CDA5,
      width: 30.21,
      height: 32.72),
  MenuCircle(
      name: 'alcoolgel',
      label: 'Álcool Gel',
      icon: 'assets/icons/lavar_mao.png',
      backgroundColor: 0xFFF57A82,
      width: 29.0,
      height: 24.75),
  MenuCircle(
      name: 'alongar',
      label: 'Alongar',
      icon: 'assets/icons/alongar.png',
      backgroundColor: 0xFF5DB5A4,
      width: 24.52,
      height: 25.01),
];
