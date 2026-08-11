import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_app/core/network/auth_local_data_source.dart';

@injectable
class ProfileCubit extends Cubit<String?> {
  final AuthLocalDataSource _authLocalDataSource;
  final ImagePicker _imagePicker = ImagePicker();

  ProfileCubit(this._authLocalDataSource) : super(null) {
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    final imagePath = await _authLocalDataSource.getProfileImage();
    emit(imagePath);
  }

  Future<void> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _authLocalDataSource.saveProfileImage(image.path);
      emit(image.path);
    }
  }
}
