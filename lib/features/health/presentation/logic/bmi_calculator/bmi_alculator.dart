class BMICalculator {

  static late  double BMI;
  static late int minWeight;
  static late int maxWeight;

  BMICalculator.init(double height, double weight){
    print(height);
    print(weight);
    BMI = calcBMI(height, weight);
   initRecomenndedWeight(height);
  }


  double calcBMI(double height , double weight){
    double d = weight/height;
    return  (d * 100).round() / 100 ;
  }

  void initRecomenndedWeight(double height){
    if(height < heightList[0] || (height >= heightList[0] && height < heightList[1])){
      minWeight =minWeightsList[0];
      maxWeight =maxWeightsList[0];
    }
    if(height >= heightList[1] && height < heightList[2]){
      minWeight =minWeightsList[1];
      maxWeight =maxWeightsList[1];
    }
    if(height >= heightList[2] && height < heightList[3]){
      minWeight =minWeightsList[2];
      maxWeight =maxWeightsList[2];
    }
    if(height >= heightList[3] && height < heightList[4]){
      minWeight =minWeightsList[3];
      maxWeight =maxWeightsList[3];
    }
    if(height >= heightList[4] && height < heightList[5]){
      minWeight =minWeightsList[4];
      maxWeight =maxWeightsList[4];
    }if(height >= heightList[5] && height < heightList[6]){
      minWeight =minWeightsList[5];
      maxWeight =maxWeightsList[5];
    }
    if(height >= heightList[6] && height < heightList[7]){
      minWeight =minWeightsList[6];
      maxWeight =maxWeightsList[7];
    }
    if(height >= heightList[7] && height < heightList[8]){
      minWeight =minWeightsList[7];
      maxWeight =maxWeightsList[7];
    }if(height >= heightList[8] && height < heightList[9]){
      minWeight =minWeightsList[8];
      maxWeight =maxWeightsList[8];
    }if(height >= heightList[9] && height < heightList[10]){
      minWeight =minWeightsList[9];
      maxWeight =maxWeightsList[9];
    }if(height >= heightList[10] && height < heightList[11]){
      minWeight =minWeightsList[10];
      maxWeight =maxWeightsList[10];
    }if(height >= heightList[11] && height < heightList[12]){
      minWeight =minWeightsList[11];
      maxWeight =maxWeightsList[11];
    }
    if(height >= heightList[12] && height < heightList[13]){
      minWeight =minWeightsList[12];
      maxWeight =maxWeightsList[12];
    }
    if(height >= heightList[13] && height < heightList[14]){
      minWeight =minWeightsList[13];
      maxWeight =maxWeightsList[13];
    }
    if(height >= heightList[14] && height < heightList[15]){
      minWeight =minWeightsList[14];
      maxWeight =maxWeightsList[14];
    }
    if(height >= heightList[15] && height < heightList[16]){
      minWeight =minWeightsList[15];
      maxWeight =maxWeightsList[15];
    }
    if(height >= heightList[16] && height < heightList[17]){
      minWeight =minWeightsList[16];
      maxWeight =maxWeightsList[16];
    }
    if(height >= heightList[17] && height < heightList[18]){
      minWeight =minWeightsList[17];
      maxWeight =maxWeightsList[17];
    }
    if(height >= heightList[18] && height < heightList[19]){
      minWeight =minWeightsList[18];
      maxWeight =maxWeightsList[18];
    }
    if(height >= heightList[19] && height < heightList[20]){
      minWeight =minWeightsList[19];
      maxWeight =maxWeightsList[19];
    }
    if(height >= heightList[20] && height < heightList[21]){
      minWeight =minWeightsList[20];
      maxWeight =maxWeightsList[20];
    }
    if(height >= heightList[21] && height < heightList[22]){
      minWeight =minWeightsList[21];
      maxWeight =maxWeightsList[21];
    }
    if(height >= heightList[22] && height < heightList[23]){
      minWeight =minWeightsList[22];
      maxWeight =maxWeightsList[22];
    }
    if(height >= heightList[23] && height < heightList[24]){
      minWeight =minWeightsList[23];
      maxWeight =maxWeightsList[23];
    }
    if(height >= heightList[24] && height < heightList[25]){
      minWeight =minWeightsList[24];
      maxWeight =maxWeightsList[24];
    }
    if(height >= heightList[25] && height < heightList[26]){
      minWeight =minWeightsList[25];
      maxWeight =maxWeightsList[25];
    }
    if(height >= heightList[26] && height < heightList[27]){
      minWeight =minWeightsList[26];
      maxWeight =maxWeightsList[26];
    }
    if(height >= heightList[27] && height < heightList[28]){
      minWeight =minWeightsList[27];
      maxWeight =maxWeightsList[27];
    }
    if(height >= heightList[28] && height < heightList[29]){
      minWeight =minWeightsList[28];
      maxWeight =maxWeightsList[28];
    }
    if(height >= heightList[29] ){
      minWeight =minWeightsList[29];
      maxWeight =maxWeightsList[29];
    }


  }










   List<double> heightList = [
  1.4732,
  1.4986,
  1.524,
  1.5494,
  1.5748,
  1.6002,
  1.6256,
  1.651,
  1.6764,
  1.7018,
  1.7272,
  1.7526,
  1.778,
  1.8034,
  1.8288,
  1.8542,
  1.8796,
  1.905,
  1.9304,
  1.9558,
  1.9812,
  2.0066,
  2.032,
  2.0574,
  2.0828,
  2.1082,
  2.1336,
  2.159,
  2.1844,
  2.2098,
  ];

  List<int> minWeightsList = [
    42,
    43,
    44,
    46,
    48,
    49,
    50,
    52,
    54,
    55,
    57,
    59,
    60,
    62,
    64,
    66,
    68,
    69,
    71,
    73,
    75,
    77,
    78,
    80,
    82,
    83,
    84,
    86,
    88,
    89,
  ];

  List<int> maxWeightsList = [
    53,
    54,
    56,
    58,
    60,
    62,
    64,
    66,
    68,
    70,
    72,
    74,
    76,
    79,
    81,
    83,
    85,
    88,
    90,
    92,
    94,
    96,
    97,
    98,
    100,
    101,
    103,
    104,
    106,
    107,
  ];
}
