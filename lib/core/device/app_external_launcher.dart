import 'package:store_redirect/store_redirect.dart';

class AppExternalLauncher {
  Future<void> launchUrl(String url) => launchUrl(url);

  Future<void> launchStore() => StoreRedirect.redirect();
}
