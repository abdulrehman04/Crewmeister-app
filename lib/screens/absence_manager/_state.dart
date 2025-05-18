part of './absence_manager.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  int page = 1;

  void incrementPage() {
    page++;
    notifyListeners();
  }
}
