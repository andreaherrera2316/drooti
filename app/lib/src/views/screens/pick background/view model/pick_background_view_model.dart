import '../presenter/background_choice.dart';

class PickBackgroundViewModel {
  PickBackgroundViewModel({
    required this.showGoToGameBtn,
    required this.selectedBgID,
    required this.bgChoices,
  });

  PickBackgroundViewModel.empty()
      : showGoToGameBtn = false,
        selectedBgID = "",
        bgChoices = [];

  bool showGoToGameBtn;
  String selectedBgID;
  List<BackgroundChoice> bgChoices;
}
