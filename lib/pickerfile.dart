import 'package:file_picker/file_picker.dart';

Future<String?> pickerfileDataSql() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowedExtensions: ['sql', 'db']);
  if (result != null) {
    return result.files.single.path!;
  } else {
    return null;
  }
}
