import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/common_widgets/app_drawer.dart';

part 'selected_screen_controller.g.dart';


@Riverpod(keepAlive: true)
class SelectedScreenController extends _$SelectedScreenController {
  DrawerScreens build() {
    return DrawerScreens.posts;
  } 

  void toggleSelectedScreen(DrawerScreens selectedScreen) {
    state = selectedScreen;
  }
}