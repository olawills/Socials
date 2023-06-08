import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class FirebaseUploadImage {
  final logger = Logger();
  String _errorResponse = 'Something went wrong please try again later';
  String get errorResponse => _errorResponse;
  Future<String> uploadPicture() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowCompression: false,
      );

      if (result != null) {
        final file = result.files.single.path;

        return file!;
      } else {
        _errorResponse = 'Something went wrong..';

        return _errorResponse;
      }
    } catch (e) {
      _errorResponse = e.toString();
      logger.d(_errorResponse);
    }
    return _errorResponse;
  }

  pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final XFile? photo = await imagePicker.pickImage(source: source);

    if (photo != null) {
      return await photo.readAsBytes();
    }
    logger.d('No image selected');
  }
}
