import 'package:bhoomi/DataModels/crop_recommendation.dart';

class DataHelper{
  List<CropRecommendation> cropList;

  DataHelper({required this.cropList});
  

  calculateMean_K(){
    List<int> list=[];
    double avg =0.0;
    for(var data in cropList){
      list.add(data.potassium!);
    }
    double sum = list.fold(0, (p, c) => p+c);
    if(sum>0){
       avg = sum/list.length;
    }
    return avg;
  }

   calculateMean_P(){
    List<int> list=[];
    double avg =0.0;
    for(var data in cropList){
      list.add(data.phosphorus!);
    }
    double sum = list.fold(0, (p, c) => p+c);
    if(sum>0){
       avg = sum/list.length;
    }
    return avg;
  }

  calculateMean_N(){
    List<int> list=[];
    double avg =0.0;
    for(var data in cropList){
      list.add(data.nitrogen!);
    }
    double sum = list.fold(0, (p, c) => p+c);
    if(sum>0){
       avg = sum/list.length;
    }
    return avg;
  }
  
}