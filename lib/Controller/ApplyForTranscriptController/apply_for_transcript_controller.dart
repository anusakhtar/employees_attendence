
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ApplyForTranscriptController extends GetxController{

 RxBool isCheckedTranscript = false.obs;
  onChangedTranscript (newValue) {

  isCheckedTranscript.value = newValue!;
  }


 RxBool isCheckedDegree = false.obs;
 onChangedDegree (newValue) {

  isCheckedDegree.value = newValue!;
 }

}