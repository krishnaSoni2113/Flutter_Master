
import 'MasterConstant.dart';

/*
 https://pub.dartlang.org/packages/path_provider
 */

class MIDocumentsDirectory{

   static final MIDocumentsDirectory shared = new MIDocumentsDirectory._init();


   factory MIDocumentsDirectory() {
     return shared;
   }


   MIDocumentsDirectory._init();


   Future<String> _getDirectoryPath() async {
     final directory = await getApplicationDocumentsDirectory();
     print("Directory Path ===== ${directory.path}");
     return directory.path;
   }


   Future<File> _getDocumentDirectoryFile(String fileName) async {
     final path = await _getDirectoryPath();
     return File('$path/$fileName');
   }


   Future<File> writeDataToDocumentDirectory(String fileName) async {
     final file = await _getDocumentDirectoryFile(fileName);
     return file;
   }


   Future<File> readDataFromDocumentDirectory(String fileName) async {
     try {
       final file = await _getDocumentDirectoryFile(fileName);
       return file;

     } catch (e) {
       // If we encounter an error, return 0
       return null;
     }
   }

   Future<File> deleteFileFromDocumentDirectory(String fileName) async {
     try {
       final file = await _getDocumentDirectoryFile(fileName);
       file.deleteSync();
       return file;

     } catch (e) {
       // If we encounter an error, return 0
       return null;
     }
   }
}