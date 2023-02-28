import 'package:habr_rss/constants/endpoints.dart';

enum Categories {
  all(title: 'Все потоки', url: Endpoints.all),
  develop(title: 'Разработка', url: Endpoints.develop),
  admin(title: 'Администрирование', url: Endpoints.admin),
  design(title: 'Дизайн', url: Endpoints.design),
  management(title: 'Менеджмент', url: Endpoints.management),
  marketing(title: 'Маркетинг', url: Endpoints.marketing),
  popSci(title: 'Научпоп', url: Endpoints.popSci);

  const Categories({
    required this.title,
    required this.url,
  });

  final String title;
  final String url;
}
