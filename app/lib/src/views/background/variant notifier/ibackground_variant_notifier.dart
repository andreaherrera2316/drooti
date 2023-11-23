import 'package:app/src/views/background/variant%20notifier/ibackground_variant_subscriber.dart';

abstract class IBackgroundVariantNotifier {
  void addVariantSub(IBackgroundVariantSubscriber subscriber);
  void removeVariantSub(IBackgroundVariantSubscriber subscriber);
  void notifyVariantChanged(String newVariant, int color);
}
