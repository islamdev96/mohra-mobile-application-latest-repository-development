import 'package:injectable/injectable.dart';
import '../datasource/../../domain/repository/imobile_ads_repository.dart';
import '../datasource/imobile_ads_remote.dart';

@Singleton(as: IMobileAdsRepository)
class MobileAdsRepository extends IMobileAdsRepository {
  final IMobileAdsRemoteSource iMobileAdsRemoteSource;

  MobileAdsRepository(this.iMobileAdsRemoteSource);
  
}
