enum Tabs { popular, topRated, upcoming }

extension TabsExtension on Tabs {
  String get value {
    switch (this) {
      case Tabs.popular:
        return "Popular";
      case Tabs.upcoming:
        return "Upcoming";
      case Tabs.topRated:
        return "Top Rated";
    }
  }
}
