import 'package:app/src/views/background/variant%20notifier/ibackground_variant_notifier.dart';
import 'package:app/src/views/background/variant%20notifier/ibackground_variant_subscriber.dart';

class BackgroundVariantNotifier implements IBackgroundVariantNotifier {
  List<IBackgroundVariantSubscriber> variantSubs = [];

  @override
  void addVariantSub(IBackgroundVariantSubscriber subscriber) {
    variantSubs.add(subscriber);
  }

  @override
  void removeVariantSub(IBackgroundVariantSubscriber subscriber) {
    variantSubs.remove(subscriber);
  }

  @override
  void notifyVariantChanged(String newVariant, int color) {
    for (var subscriber in variantSubs) {
      subscriber.onVariantChanged(newVariant);
    }
  }
}
