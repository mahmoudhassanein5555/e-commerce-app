import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MainTabCubit extends Cubit<int> {
  MainTabCubit() : super(0);
  void selectTab(int index) => emit(index);
}
