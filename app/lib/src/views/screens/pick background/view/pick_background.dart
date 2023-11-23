import 'package:app/resources/sizing/device_type.dart';
import 'package:app/resources/sizing/screen_size.dart';
import 'package:app/src/router/router.dart';
import 'package:app/src/views/shared/text/app_title.dart';
import 'package:app/src/views/shared/widgets/custom_appbar.dart';
import 'package:app/src/views/state/loading/loading_element.dart';
import 'package:app/src/views/screens/pick%20background/controller/pick_background_controller.dart';
import 'package:app/src/views/screens/pick%20background/presenter/language/intl_pick_background_lang_processor.dart';
import 'package:app/src/views/screens/pick%20background/presenter/pick_background_presenter.dart';
import 'package:app/src/views/screens/pick%20background/view%20model/pick_background_view_model.dart';
import 'package:app/src/views/screens/pick%20background/view/background_choice_display.dart';
import 'package:app/src/views/screens/pick%20background/view/ipick_background_view.dart';
import 'package:app/src/views/shared/buttons/gradient_button.dart';
import 'package:app/src/views/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../presenter/background_choice.dart';

class PickBackground extends StatefulWidget {
  const PickBackground({required this.navigator, super.key});
  final INavigation navigator;

  @override
  State<PickBackground> createState() => _PickBackgroundState();
}

class _PickBackgroundState extends State<PickBackground>
    implements IPickBackgroundView {
  PickBackgroundViewModel _viewModel = PickBackgroundViewModel.empty();
  PickBackgroundController? _controller;

  @override
  updateScreen(PickBackgroundViewModel viewModel) {
    setState(() {
      _viewModel = viewModel;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      var presenter = PickBackgroundPresenter(
          view: this,
          viewModel: _viewModel,
          navigator: widget.navigator,
          lang: IntlPickBackgroundLangProcessor(AppLocalizations.of(context)!));

      _controller = PickBackgroundController(presenter: presenter);
      _controller!.getBackgrounds();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel.bgChoices.isEmpty) {
      return const LoadingElement();
    }

    Size s = ScreenSize.getSize(context);
    final l = AppLocalizations.of(context)!;
    final d = DeviceType(s.width, s.height);
    var p = Palette();
    var p5 = SizedBox(height: s.height * 0.05);

    ///Title
    double titleSize = 50;
    var title = AppTitle(
      text: l.pickBg,
      titleSize: titleSize,
    );

    ///Backgrounds
    var bgHeight = d.getValueForScreen(
            onMobile: s.height * 0.2,
            onTablet: s.height * 0.225,
            onDesktop: s.height * 0.23) ??
        s.height * 0.2;

    var bgWidth = d.getValueForScreen(
            onMobile: s.width * 0.38,
            onTablet: bgHeight * 1.2,
            onDesktop: bgHeight * 1.2) ??
        s.width * 0.42;

    var spacing = d.getValueForScreen(
            onMobile: bgWidth * 0.1,
            onTablet: bgWidth * 0.21,
            onDesktop: bgWidth * 0.21) ??
        bgWidth * 0.1;

    var padding = d.getValueForScreen(
            onMobile: 5.0,
            onTablet: s.width * 0.08,
            onDesktop: (s.width - ((bgWidth * 3) + (spacing * 5))) / 2) ??
        s.width * 0.05;

    var backgroundsDisplay = Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Wrap(
          alignment: WrapAlignment.spaceAround,
          spacing: spacing,
          runSpacing: bgHeight * 0.1,
          children: _viewModel.bgChoices
              .map((bg) => getBakcgroundDisplay(
                  bg, _viewModel, _controller!, bgHeight, bgWidth))
              .toList()),
    );

    ///Content
    Widget content;

    content = SizedBox(
      height: s.height,
      width: s.width,
      child: SingleChildScrollView(
          child: Column(children: [title, p5, backgroundsDisplay, p5, p5, p5])),
    );

    //Button
    var goToGameBtn = _viewModel.selectedBgID == ""
        ? const SizedBox()
        : GradientButton.rounded(
            textColor: Colors.black,
            elevation: kElevationToShadow[8],
            onPressed: _controller!.goToGame,
            title: l.play.toUpperCase(),
            gradient: LinearGradient(
              colors: p.redButton,
            ));

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: p.bg,
      floatingActionButton: goToGameBtn,
      body: content,
    );
  }
}

Widget getBakcgroundDisplay(
    BackgroundChoice bg,
    PickBackgroundViewModel viewModel,
    PickBackgroundController controller,
    double bgHeight,
    double bgWidth) {
  bool backgroundIsSelected = bg.id == viewModel.selectedBgID;
  var displayHeight = backgroundIsSelected ? bgHeight * 1.02 : bgHeight;
  var displayWidth = backgroundIsSelected ? bgWidth * 1.02 : bgWidth;

  var onTap = backgroundIsSelected
      ? controller.unselectBackground
      : () => controller.selectBackground(bg.id);

  return BackgroundChoiceDisplay(
    bg,
    height: displayHeight,
    width: displayWidth,
    onTap: onTap,
    backgroundIsSelected: backgroundIsSelected,
  );
}
