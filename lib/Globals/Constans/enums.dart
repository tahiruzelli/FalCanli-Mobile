enum FortuneType {
  coffee,
  astrology,
  natalChart,
  tarot,
}

String getFortuneTypeString(FortuneType fortuneType) {
  switch (fortuneType) {
    case FortuneType.coffee:
      return "kahve";
    case FortuneType.astrology:
      return "astroloji";
    case FortuneType.natalChart:
      return "doğum haritası";
    case FortuneType.tarot:
      return "tarot";
  }
}

enum UserType {
  user,
  fortuner,
}
