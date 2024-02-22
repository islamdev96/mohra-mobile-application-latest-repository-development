import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';

class HealthProfileStaticModel {
  static int GENDER = 0;
  static int ID = 0;
  static int HEALTH_SITUATION = 0;
  static int DIFFICULTY = 0;
  static String BIRTH_DAY = '';
  static double WEIGHT_GOAL = 0.0;
  static double WEIGHT = 0.0;
  static int MIN_WEIGHT = 0;
  static int MAX_WEIGHT = 0;
  static double LENGTH = 0.0;
  static double BMI = 0.0;

  static saveProfile(
    int gender,
    int healthSituation,
    int difficulty,
    String birthDay,
    double weightGoal,
    double weight,
    double length,
    double bmi,
      int minWeight,
      int maxWeight,
      int id,
  ) {
    GENDER = gender;
    ID = id;
    DIFFICULTY = difficulty;
    HEALTH_SITUATION = healthSituation;
    LENGTH = length;
    BIRTH_DAY = birthDay;
    WEIGHT = weight;
    WEIGHT_GOAL = weightGoal;
    BMI = bmi;
    MIN_WEIGHT = minWeight;
    MAX_WEIGHT = maxWeight;
    _saveInSP();
  }

  static _saveInSP() async {
    var sp = await SpUtil.getInstance();
    sp.putString('health_birth_day', BIRTH_DAY);
    sp.putInt('health_gender', GENDER);
    sp.putInt('health_situation', HEALTH_SITUATION);
    sp.putInt('difficulty', DIFFICULTY);
    sp.putInt('health_id', ID);
    sp.putDouble('bmi', BMI);
    sp.putDouble('length', LENGTH);
    sp.putDouble('weight', WEIGHT);
    sp.putInt('min_weight', MIN_WEIGHT);
    sp.putInt('max_weight', MAX_WEIGHT);
    sp.putDouble('weight_goal', WEIGHT_GOAL);
    sp.putBool(AppConstants.HEALTH_PROFILE_DONE, true);
  }

  static getFromSP() async {
    var sp = await SpUtil.getInstance();
    BIRTH_DAY = sp.get('health_birth_day');
    GENDER = sp.get('health_gender');
    HEALTH_SITUATION = sp.get('health_situation');
    DIFFICULTY = sp.get('difficulty');
    BMI = sp.get('bmi');
    LENGTH = sp.get('length');
    WEIGHT = sp.get('weight');
    MAX_WEIGHT = sp.get('max_weight');
    MIN_WEIGHT= sp.get('min_weight');
    WEIGHT_GOAL = sp.get('weight_goal');
    ID = sp.get('user_Id');

  }

  static updateGoalWeight(double newGoal) async {
    WEIGHT_GOAL = newGoal;
    var sp = await SpUtil.getInstance();

    sp.remove('weight_goal');
    sp.putDouble('weight_goal', WEIGHT_GOAL);
  }
}
