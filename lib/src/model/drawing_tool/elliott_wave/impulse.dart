/// An enumeration of available impulses
enum WaveImpulse {
  romanCapital("I II III IV V"),
  romanNormal("i ii iii iv v"),
  arabicNormal("1 2 3 4 5"),
  abcdeCapital("A B C D E"),
  abcdeNormal("a b c d e"),
  wxyxzCapital("W X Y X Z"),
  wxyxzNormal("w x y x z"),
  none("- - -");

  final String value;

  const WaveImpulse(this.value);
}
