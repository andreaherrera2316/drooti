import 'package:app/src/core/entities/background/igame_background.dart';
import 'package:app/src/router/router.dart';
import 'package:app/src/views/screens/pick%20background/presenter/ipick_background_presenter.dart';
import 'package:app/src/views/screens/pick%20background/view%20model/pick_background_view_model.dart';
import '../../pick background/view/ipick_background_view.dart';
import 'background_choice.dart';
import 'language/ipick_background_lang_processor.dart';

class PickBackgroundPresenter implements IPickBackgroundPresenter {
  PickBackgroundPresenter(
      {required this.view,
      required this.viewModel,
      required this.lang,
      required this.navigator});

  IPickBackgroundView view;
  PickBackgroundViewModel viewModel;
  IPickBackgroundLangProcessor lang;
  INavigation navigator;

  @override
  void recieveBackgrounds(List<IGameBackground> backgrounds) {
    viewModel.bgChoices = backgrounds
        .map((bg) => BackgroundChoice(
            id: bg.id,
            name: lang.getBackgroundName(bg.id),
            displayImg: bg.mainDisplayImg))
        .toList();
    view.updateScreen(viewModel);
  }

  @override
  void goToGame() {
    if (viewModel.selectedBgID != "") {
      navigator.goToGame(viewModel.selectedBgID);
    }
  }

  @override
  void selectBackground(String backgroundID) {
    viewModel.selectedBgID = backgroundID;
    view.updateScreen(viewModel);
  }

  @override
  void unselectBackground() {
    viewModel.selectedBgID = "";
    view.updateScreen(viewModel);
  }
}
