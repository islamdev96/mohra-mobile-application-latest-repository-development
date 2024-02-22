// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class MobileAdBanner{
//   late AdManagerBannerAd bannerAd;
//   bool isLoaded = false;
//   Function(Ad) onAddLoaded;
//   Function(Ad , LoadAdError)? onAddError;
//   String adUnitId ;
//
//   MobileAdBanner({
//     required this.onAddLoaded,
//     required this.isLoaded,
//     required this.onAddError,
//     this.adUnitId = '/6499/example/banner',
// }){
//     bannerAd = AdManagerBannerAd(
//       adUnitId: adUnitId,
//       request: const AdManagerAdRequest(),
//       sizes: [AdSize.banner],
//       listener: AdManagerBannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: onAddLoaded,
//         // Called when an ad request failed.
//         onAdFailedToLoad: onAddError,
//       ),
//     )..load();
//   }
//
//   /// Loads a banner ad.
//    getBanner() {
//     return bannerAd;
//   }
//
// }