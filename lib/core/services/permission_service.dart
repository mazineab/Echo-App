import 'package:permission_handler/permission_handler.dart';

class PermissionService{



  Future<bool> requestCamera()async{
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    if (status.isPermanentlyDenied) {
      return false;
    }

    if (status.isGranted) {
      return true;
    }
    return false;
  }

  Future<bool> requestGallery()async{
    var status=await Permission.storage.status;
    if(status.isDenied){
      status=await Permission.storage.request();
      if(status.isGranted){
        return true;
      }else{
        return false;
      }
    }
    if(status.isPermanentlyDenied){
      return false;
    }
    if(status.isGranted){
      return true;
    }
    return false;
  }
}