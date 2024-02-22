import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

const APP_NAME = '';
const APP_NAME_TAG_LINE = '';
var defaultPrimaryColor = Color(0xffFF5921);

const DOMAIN_URL = 'https://service-providers.mohraapp.com'; // Don't add slash at the end of the url
const BASE_URL = '$DOMAIN_URL/api/';

const DEFAULT_LANGUAGE = 'en';

/// You can change this to your Provider App package name
/// This will be used in Registered As Partner in Sign In Screen where your users can redirect to the Play/App Store for Provider App
/// You can specify in Admin Panel, These will be used if you don't specify in Admin Panel
const PROVIDER_PACKAGE_NAME = 'com.iqonic.provider';
const IOS_LINK_FOR_PARTNER = "https://apps.apple.com/us/app/mohra-services-provider/id6471838389";

const IOS_LINK_FOR_USER = 'https://apps.apple.com/us/app/mohra-services-provider/id6471838389';

const DASHBOARD_AUTO_SLIDER_SECOND = 5;

const TERMS_CONDITION_URL = 'https://mohraapp.com/terms-conditions';
const PRIVACY_POLICY_URL = 'https://mohraapp.com/ar/privacy-policy';
const INQUIRY_SUPPORT_EMAIL = 'info@mohraapps.com';

/// You can add help line number here for contact. It's demo number
const HELP_LINE_NUMBER = '+966504622249';

/// STRIPE PAYMENT DETAIL
const STRIPE_MERCHANT_COUNTRY_CODE = 'IN';
const STRIPE_CURRENCY_CODE = 'INR';

/// RAZORPAY PAYMENT DETAIL
const RAZORPAY_CURRENCY_CODE = 'INR';

/// PAYPAL PAYMENT DETAIL
const PAYPAL_CURRENCY_CODE = 'USD';

/// SADAD PAYMENT DETAIL
const SADAD_API_URL = 'https://api-s.sadad.qa';
const SADAD_PAY_URL = "https://d.sadad.qa";

DateTime todayDate = DateTime.now();

Country defaultCountry() {
  return Country(
    phoneCode: '966',
    countryCode: 'SA',
    e164Sc: 966,
    geographic: true,
    level: 1,
    name: 'Saudi Arabia',
    example: '9123456789',
    displayName: 'Saudi Arabia (SA) [+966]',
    displayNameNoCountryCode: 'Saudi Arabia (SA)',
    e164Key: '91-IN-0',
    fullExampleWithPlusSign: '+966',
  );
}
