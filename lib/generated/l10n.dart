// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Translation {
  Translation();

  static Translation? _current;

  static Translation get current {
    assert(_current != null,
        'No instance of Translation was loaded. Try to initialize the Translation delegate before accessing Translation.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Translation> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Translation();
      Translation._current = instance;

      return instance;
    });
  }

  static Translation of(BuildContext context) {
    final instance = Translation.maybeOf(context);
    assert(instance != null,
        'No instance of Translation present in the widget tree. Did you add Translation.delegate in localizationsDelegates?');
    return instance!;
  }

  static Translation? maybeOf(BuildContext context) {
    return Localizations.of<Translation>(context, Translation);
  }

  /// `Couldn't find path`
  String get mapPathError {
    return Intl.message(
      'Couldn\'t find path',
      name: 'mapPathError',
      desc: '',
      args: [],
    );
  }

  /// `Could not fetch distance`
  String get errorFetchDistance {
    return Intl.message(
      'Could not fetch distance',
      name: 'errorFetchDistance',
      desc: '',
      args: [],
    );
  }

  /// `Error Occured 😢`
  String get errorOccurred {
    return Intl.message(
      'Error Occured 😢',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `An error has been occurred, please click send to help us fixing the problem`
  String get reportError {
    return Intl.message(
      'An error has been occurred, please click send to help us fixing the problem',
      name: 'reportError',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized`
  String get unauthorized {
    return Intl.message(
      'Unauthorized',
      name: 'unauthorized',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred. Please try again later`
  String get generalErrorMessage {
    return Intl.message(
      'An error has occurred. Please try again later',
      name: 'generalErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Bad Request`
  String get badRequest {
    return Intl.message(
      'Bad Request',
      name: 'badRequest',
      desc: '',
      args: [],
    );
  }

  /// `Forbidden`
  String get forbidden {
    return Intl.message(
      'Forbidden',
      name: 'forbidden',
      desc: '',
      args: [],
    );
  }

  /// `{url} not Found`
  String notFound(Object url) {
    return Intl.message(
      '$url not Found',
      name: 'notFound',
      desc: '',
      args: [url],
    );
  }

  /// `Conflict Error`
  String get conflictError {
    return Intl.message(
      'Conflict Error',
      name: 'conflictError',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get Services {
    return Intl.message(
      'Services',
      name: 'Services',
      desc: '',
      args: [],
    );
  }

  /// `The allowed number is 5 tickets`
  String get allowed5 {
    return Intl.message(
      'The allowed number is 5 tickets',
      name: 'allowed5',
      desc: '',
      args: [],
    );
  }

  /// `Login Required`
  String get login_required {
    return Intl.message(
      'Login Required',
      name: 'login_required',
      desc: '',
      args: [],
    );
  }

  /// `Please log in to see more`
  String get Please_log_in {
    return Intl.message(
      'Please log in to see more',
      name: 'Please_log_in',
      desc: '',
      args: [],
    );
  }

  /// `Connection time out`
  String get connectionTimeOut {
    return Intl.message(
      'Connection time out',
      name: 'connectionTimeOut',
      desc: '',
      args: [],
    );
  }

  /// `Please login again`
  String get please_login_again {
    return Intl.message(
      'Please login again',
      name: 'please_login_again',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error occurred, please try again`
  String get unknownError {
    return Intl.message(
      'Unknown error occurred, please try again',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `The server encountered an internal error or misconfigurtion and was unable to complete your request.`
  String get internalServerErrorMessage {
    return Intl.message(
      'The server encountered an internal error or misconfigurtion and was unable to complete your request.',
      name: 'internalServerErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get connectionErrorMessage {
    return Intl.message(
      'Internal server error',
      name: 'connectionErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successfully`
  String get paymentSuccessfully {
    return Intl.message(
      'Payment Successfully',
      name: 'paymentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `OOPS !`
  String get oopsErrorMessage {
    return Intl.message(
      'OOPS !',
      name: 'oopsErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `You have to select at least 1 friend`
  String get groupValidation {
    return Intl.message(
      'You have to select at least 1 friend',
      name: 'groupValidation',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get data`
  String get failedRefresher {
    return Intl.message(
      'Failed to get data',
      name: 'failedRefresher',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noDataRefresher {
    return Intl.message(
      'No data',
      name: 'noDataRefresher',
      desc: '',
      args: [],
    );
  }

  /// `This field can't be empty`
  String get errorTxt {
    return Intl.message(
      'This field can\'t be empty',
      name: 'errorTxt',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logOut {
    return Intl.message(
      'Logout',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Select a language, the application will restart`
  String get changeLangMessage {
    return Intl.message(
      'Select a language, the application will restart',
      name: 'changeLangMessage',
      desc: '',
      args: [],
    );
  }

  /// `Learn more about mohra`
  String get learn_about_mohra {
    return Intl.message(
      'Learn more about mohra',
      name: 'learn_about_mohra',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get FAQ {
    return Intl.message(
      'FAQ',
      name: 'FAQ',
      desc: '',
      args: [],
    );
  }

  /// `Browse most frequently asked question about using mohra`
  String get faq_des {
    return Intl.message(
      'Browse most frequently asked question about using mohra',
      name: 'faq_des',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Press twice to exit`
  String get pressTwiceToExit {
    return Intl.message(
      'Press twice to exit',
      name: 'pressTwiceToExit',
      desc: '',
      args: [],
    );
  }

  /// `Mohra ID (username)`
  String get userName {
    return Intl.message(
      'Mohra ID (username)',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number ex: 09xx-xxx-xxx`
  String get invalidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number ex: 09xx-xxx-xxx',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 5 characters long`
  String get invalidPassword {
    return Intl.message(
      'Must be at least 5 characters long',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Close App`
  String get closeApp {
    return Intl.message(
      'Close App',
      name: 'closeApp',
      desc: '',
      args: [],
    );
  }

  /// `Update Required`
  String get updateTitle {
    return Intl.message(
      'Update Required',
      name: 'updateTitle',
      desc: '',
      args: [],
    );
  }

  /// `For the best experience, update to the latest version to get new features and improvements.`
  String get updateMessage {
    return Intl.message(
      'For the best experience, update to the latest version to get new features and improvements.',
      name: 'updateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty {
    return Intl.message(
      'Empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `The page has no content ..`
  String get pageEmpty {
    return Intl.message(
      'The page has no content ..',
      name: 'pageEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `An error happened while connecting to server, please try again later`
  String get responseError {
    return Intl.message(
      'An error happened while connecting to server, please try again later',
      name: 'responseError',
      desc: '',
      args: [],
    );
  }

  /// `The connection has been interrupted`
  String get errorCancelToken {
    return Intl.message(
      'The connection has been interrupted',
      name: 'errorCancelToken',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message(
      'Register',
      name: 'Register',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password and confirm password doesn't match`
  String get invalidConfirmPassword {
    return Intl.message(
      'Password and confirm password doesn\'t match',
      name: 'invalidConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `This field mustn't be empty`
  String get errorEmptyField {
    return Intl.message(
      'This field mustn\'t be empty',
      name: 'errorEmptyField',
      desc: '',
      args: [],
    );
  }

  /// `Switch theme`
  String get switchTheme {
    return Intl.message(
      'Switch theme',
      name: 'switchTheme',
      desc: '',
      args: [],
    );
  }

  /// `Account Not Verified`
  String get accountNotVerifiedErrorMessage {
    return Intl.message(
      'Account Not Verified',
      name: 'accountNotVerifiedErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Operation has been cancelled`
  String get cancelErrorMessage {
    return Intl.message(
      'Operation has been cancelled',
      name: 'cancelErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `login Error Required`
  String get loginErrorRequired {
    return Intl.message(
      'login Error Required',
      name: 'loginErrorRequired',
      desc: '',
      args: [],
    );
  }

  /// `This page is empty`
  String get emptyScreen {
    return Intl.message(
      'This page is empty',
      name: 'emptyScreen',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Search Event`
  String get search_event {
    return Intl.message(
      'Search Event',
      name: 'search_event',
      desc: '',
      args: [],
    );
  }

  /// `Popular Events`
  String get popular_events {
    return Intl.message(
      'Popular Events',
      name: 'popular_events',
      desc: '',
      args: [],
    );
  }

  /// `Other events you might like`
  String get other_events_might_like {
    return Intl.message(
      'Other events you might like',
      name: 'other_events_might_like',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get view_details {
    return Intl.message(
      'View Details',
      name: 'view_details',
      desc: '',
      args: [],
    );
  }

  /// `Buy ticket now`
  String get buy_ticket_now {
    return Intl.message(
      'Buy ticket now',
      name: 'buy_ticket_now',
      desc: '',
      args: [],
    );
  }

  /// `Buy Ticket On Official Website`
  String get buy_ticket_on_website {
    return Intl.message(
      'Buy Ticket On Official Website',
      name: 'buy_ticket_on_website',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get see_more {
    return Intl.message(
      'See more',
      name: 'see_more',
      desc: '',
      args: [],
    );
  }

  /// `See less`
  String get see_less {
    return Intl.message(
      'See less',
      name: 'see_less',
      desc: '',
      args: [],
    );
  }

  /// `Event organizer`
  String get event_organizer {
    return Intl.message(
      'Event organizer',
      name: 'event_organizer',
      desc: '',
      args: [],
    );
  }

  /// `Seat`
  String get seat {
    return Intl.message(
      'Seat',
      name: 'seat',
      desc: '',
      args: [],
    );
  }

  /// `Available Seat`
  String get available_seat {
    return Intl.message(
      'Available Seat',
      name: 'available_seat',
      desc: '',
      args: [],
    );
  }

  /// `ticket can be purchased on apps`
  String get ticket_purchased_on_apps {
    return Intl.message(
      'ticket can be purchased on apps',
      name: 'ticket_purchased_on_apps',
      desc: '',
      args: [],
    );
  }

  /// `View map`
  String get view_map {
    return Intl.message(
      'View map',
      name: 'view_map',
      desc: '',
      args: [],
    );
  }

  /// `Event gallery`
  String get event_gallery {
    return Intl.message(
      'Event gallery',
      name: 'event_gallery',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `About this event`
  String get about_this_event {
    return Intl.message(
      'About this event',
      name: 'about_this_event',
      desc: '',
      args: [],
    );
  }

  /// `Ticketing`
  String get ticketing {
    return Intl.message(
      'Ticketing',
      name: 'ticketing',
      desc: '',
      args: [],
    );
  }

  /// `People going to this event`
  String get people_going_to_event {
    return Intl.message(
      'People going to this event',
      name: 'people_going_to_event',
      desc: '',
      args: [],
    );
  }

  /// `Who is going`
  String get who_is_going {
    return Intl.message(
      'Who is going',
      name: 'who_is_going',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Buy ticket`
  String get buy_ticket {
    return Intl.message(
      'Buy ticket',
      name: 'buy_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Pick a day`
  String get pick_day {
    return Intl.message(
      'Pick a day',
      name: 'pick_day',
      desc: '',
      args: [],
    );
  }

  /// `When will you come at the event?`
  String get when_you_come_at_event {
    return Intl.message(
      'When will you come at the event?',
      name: 'when_you_come_at_event',
      desc: '',
      args: [],
    );
  }

  /// `Select ticket`
  String get select_ticket {
    return Intl.message(
      'Select ticket',
      name: 'select_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Silver ticket`
  String get silver_ticket {
    return Intl.message(
      'Silver ticket',
      name: 'silver_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Gold ticket`
  String get gold_ticket {
    return Intl.message(
      'Gold ticket',
      name: 'gold_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Platinum ticket`
  String get platinum_ticket {
    return Intl.message(
      'Platinum ticket',
      name: 'platinum_ticket',
      desc: '',
      args: [],
    );
  }

  /// `VIP ticket`
  String get vip_ticket {
    return Intl.message(
      'VIP ticket',
      name: 'vip_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Free ticket`
  String get free_ticket {
    return Intl.message(
      'Free ticket',
      name: 'free_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Event time`
  String get event_time {
    return Intl.message(
      'Event time',
      name: 'event_time',
      desc: '',
      args: [],
    );
  }

  /// `Refund policy`
  String get refund_policy {
    return Intl.message(
      'Refund policy',
      name: 'refund_policy',
      desc: '',
      args: [],
    );
  }

  /// `not refundable`
  String get not_refundable {
    return Intl.message(
      'not refundable',
      name: 'not_refundable',
      desc: '',
      args: [],
    );
  }

  /// `refundable`
  String get refundable {
    return Intl.message(
      'refundable',
      name: 'refundable',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Select seat`
  String get select_seat {
    return Intl.message(
      'Select seat',
      name: 'select_seat',
      desc: '',
      args: [],
    );
  }

  /// `Select from available seats below`
  String get select_available_seats {
    return Intl.message(
      'Select from available seats below',
      name: 'select_available_seats',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get booked {
    return Intl.message(
      'Booked',
      name: 'booked',
      desc: '',
      args: [],
    );
  }

  /// `Your selection`
  String get your_selection {
    return Intl.message(
      'Your selection',
      name: 'your_selection',
      desc: '',
      args: [],
    );
  }

  /// `Row`
  String get row {
    return Intl.message(
      'Row',
      name: 'row',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_information {
    return Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `I've already read and agree with`
  String get read_and_agree {
    return Intl.message(
      'I\'ve already read and agree with',
      name: 'read_and_agree',
      desc: '',
      args: [],
    );
  }

  /// `terms and conditions`
  String get term_conditions {
    return Intl.message(
      'terms and conditions',
      name: 'term_conditions',
      desc: '',
      args: [],
    );
  }

  /// `of this event`
  String get of_this_event {
    return Intl.message(
      'of this event',
      name: 'of_this_event',
      desc: '',
      args: [],
    );
  }

  /// `Total payment`
  String get total_payment {
    return Intl.message(
      'Total payment',
      name: 'total_payment',
      desc: '',
      args: [],
    );
  }

  /// `Processing your order`
  String get processing_your_order {
    return Intl.message(
      'Processing your order',
      name: 'processing_your_order',
      desc: '',
      args: [],
    );
  }

  /// `Please wait we are processing your order now`
  String get wait_processing_your_order_now {
    return Intl.message(
      'Please wait we are processing your order now',
      name: 'wait_processing_your_order_now',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been successfully placed`
  String get your_order_placed {
    return Intl.message(
      'Your order has been successfully placed',
      name: 'your_order_placed',
      desc: '',
      args: [],
    );
  }

  /// `View My Ticket`
  String get view_my_ticket {
    return Intl.message(
      'View My Ticket',
      name: 'view_my_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Ticket details`
  String get ticket_details {
    return Intl.message(
      'Ticket details',
      name: 'ticket_details',
      desc: '',
      args: [],
    );
  }

  /// `Download PDF`
  String get download_pdf {
    return Intl.message(
      'Download PDF',
      name: 'download_pdf',
      desc: '',
      args: [],
    );
  }

  /// `Share Ticket`
  String get share_ticket {
    return Intl.message(
      'Share Ticket',
      name: 'share_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Events & Coupons`
  String get event {
    return Intl.message(
      'Events & Coupons',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Type & Seat`
  String get type_seat {
    return Intl.message(
      'Type & Seat',
      name: 'type_seat',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `View on Map`
  String get view_on_map {
    return Intl.message(
      'View on Map',
      name: 'view_on_map',
      desc: '',
      args: [],
    );
  }

  /// `My ticket`
  String get my_ticket {
    return Intl.message(
      'My ticket',
      name: 'my_ticket',
      desc: '',
      args: [],
    );
  }

  /// `View Ticket`
  String get view_ticket {
    return Intl.message(
      'View Ticket',
      name: 'view_ticket',
      desc: '',
      args: [],
    );
  }

  /// `No Image`
  String get no_image {
    return Intl.message(
      'No Image',
      name: 'no_image',
      desc: '',
      args: [],
    );
  }

  /// `Event Details`
  String get event_details {
    return Intl.message(
      'Event Details',
      name: 'event_details',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Hide all`
  String get hide_all {
    return Intl.message(
      'Hide all',
      name: 'hide_all',
      desc: '',
      args: [],
    );
  }

  /// `Write your comment`
  String get write_comment {
    return Intl.message(
      'Write your comment',
      name: 'write_comment',
      desc: '',
      args: [],
    );
  }

  /// `View previous comments`
  String get view_previous_comments {
    return Intl.message(
      'View previous comments',
      name: 'view_previous_comments',
      desc: '',
      args: [],
    );
  }

  /// `comment added successfully`
  String get comment_success {
    return Intl.message(
      'comment added successfully',
      name: 'comment_success',
      desc: '',
      args: [],
    );
  }

  /// `no more comments`
  String get no_more_comments {
    return Intl.message(
      'no more comments',
      name: 'no_more_comments',
      desc: '',
      args: [],
    );
  }

  /// `insert a comment`
  String get insert_comment {
    return Intl.message(
      'insert a comment',
      name: 'insert_comment',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `view all`
  String get view_all {
    return Intl.message(
      'view all',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Top Categories`
  String get Top_Categories {
    return Intl.message(
      'Top Categories',
      name: 'Top_Categories',
      desc: '',
      args: [],
    );
  }

  /// `Top Stores`
  String get Top_Stores {
    return Intl.message(
      'Top Stores',
      name: 'Top_Stores',
      desc: '',
      args: [],
    );
  }

  /// `Top Seller Products`
  String get Top_Seller_Products {
    return Intl.message(
      'Top Seller Products',
      name: 'Top_Seller_Products',
      desc: '',
      args: [],
    );
  }

  /// `Store Category`
  String get Store_Category {
    return Intl.message(
      'Store Category',
      name: 'Store_Category',
      desc: '',
      args: [],
    );
  }

  /// `Blazer / Suite`
  String get Blazer_Suite {
    return Intl.message(
      'Blazer / Suite',
      name: 'Blazer_Suite',
      desc: '',
      args: [],
    );
  }

  /// `Search product`
  String get search_product {
    return Intl.message(
      'Search product',
      name: 'search_product',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get Filter {
    return Intl.message(
      'Filter',
      name: 'Filter',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get Sort {
    return Intl.message(
      'Sort',
      name: 'Sort',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get Followers {
    return Intl.message(
      'Followers',
      name: 'Followers',
      desc: '',
      args: [],
    );
  }

  /// `Follow Store`
  String get Follow_Store {
    return Intl.message(
      'Follow Store',
      name: 'Follow_Store',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get Product {
    return Intl.message(
      'Product',
      name: 'Product',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review {
    return Intl.message(
      'Review',
      name: 'Review',
      desc: '',
      args: [],
    );
  }

  /// `Review Store`
  String get Review_Store {
    return Intl.message(
      'Review Store',
      name: 'Review_Store',
      desc: '',
      args: [],
    );
  }

  /// `Overall Review`
  String get Overall_Review {
    return Intl.message(
      'Overall Review',
      name: 'Overall_Review',
      desc: '',
      args: [],
    );
  }

  /// `Professionalism`
  String get Professionalism {
    return Intl.message(
      'Professionalism',
      name: 'Professionalism',
      desc: '',
      args: [],
    );
  }

  /// `Wait Time`
  String get Wait_Time {
    return Intl.message(
      'Wait Time',
      name: 'Wait_Time',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get Experience {
    return Intl.message(
      'Experience',
      name: 'Experience',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get Value {
    return Intl.message(
      'Value',
      name: 'Value',
      desc: '',
      args: [],
    );
  }

  /// `Stores`
  String get stores {
    return Intl.message(
      'Stores',
      name: 'stores',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message(
      'All',
      name: 'All',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get Customer {
    return Intl.message(
      'Customer',
      name: 'Customer',
      desc: '',
      args: [],
    );
  }

  /// `sold`
  String get sold {
    return Intl.message(
      'sold',
      name: 'sold',
      desc: '',
      args: [],
    );
  }

  /// `Choose Color`
  String get Choose_Color {
    return Intl.message(
      'Choose Color',
      name: 'Choose_Color',
      desc: '',
      args: [],
    );
  }

  /// `Product Descriptions`
  String get Product_Descriptions {
    return Intl.message(
      'Product Descriptions',
      name: 'Product_Descriptions',
      desc: '',
      args: [],
    );
  }

  /// `Choose Size`
  String get Choose_Size {
    return Intl.message(
      'Choose Size',
      name: 'Choose_Size',
      desc: '',
      args: [],
    );
  }

  /// `Product Information`
  String get Product_Information {
    return Intl.message(
      'Product Information',
      name: 'Product_Information',
      desc: '',
      args: [],
    );
  }

  /// `minimum order`
  String get minimum_order {
    return Intl.message(
      'minimum order',
      name: 'minimum_order',
      desc: '',
      args: [],
    );
  }

  /// `conditions`
  String get conditions {
    return Intl.message(
      'conditions',
      name: 'conditions',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get New {
    return Intl.message(
      'New',
      name: 'New',
      desc: '',
      args: [],
    );
  }

  /// `Product Reviews`
  String get Product_Reviews {
    return Intl.message(
      'Product Reviews',
      name: 'Product_Reviews',
      desc: '',
      args: [],
    );
  }

  /// `Review Product`
  String get Review_Product {
    return Intl.message(
      'Review Product',
      name: 'Review_Product',
      desc: '',
      args: [],
    );
  }

  /// `Related Product`
  String get Related_Product {
    return Intl.message(
      'Related Product',
      name: 'Related_Product',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get Add_To_Cart {
    return Intl.message(
      'Add To Cart',
      name: 'Add_To_Cart',
      desc: '',
      args: [],
    );
  }

  /// `Write your review`
  String get Write_your_review {
    return Intl.message(
      'Write your review',
      name: 'Write_your_review',
      desc: '',
      args: [],
    );
  }

  /// `Upload Images`
  String get Upload_Images {
    return Intl.message(
      'Upload Images',
      name: 'Upload_Images',
      desc: '',
      args: [],
    );
  }

  /// `Your overall rating of this product (Requaired)`
  String get rating_of_this_product {
    return Intl.message(
      'Your overall rating of this product (Requaired)',
      name: 'rating_of_this_product',
      desc: '',
      args: [],
    );
  }

  /// `Buy all you need from various products and services`
  String get OnBoarding1 {
    return Intl.message(
      'Buy all you need from various products and services',
      name: 'OnBoarding1',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get OnBoarding1title {
    return Intl.message(
      'Shopping',
      name: 'OnBoarding1title',
      desc: '',
      args: [],
    );
  }

  /// `Buy all you need from various products and services`
  String get OnBoarding1footer {
    return Intl.message(
      'Buy all you need from various products and services',
      name: 'OnBoarding1footer',
      desc: '',
      args: [],
    );
  }

  /// `Follow your food and exercise schedules to enjoy better health and reach your goals faster`
  String get OnBoarding2 {
    return Intl.message(
      'Follow your food and exercise schedules to enjoy better health and reach your goals faster',
      name: 'OnBoarding2',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get OnBoarding2title {
    return Intl.message(
      'Health',
      name: 'OnBoarding2title',
      desc: '',
      args: [],
    );
  }

  /// `Follow your food and exercise schedules to enjoy better health and reach your goals faster`
  String get OnBoarding2footer {
    return Intl.message(
      'Follow your food and exercise schedules to enjoy better health and reach your goals faster',
      name: 'OnBoarding2footer',
      desc: '',
      args: [],
    );
  }

  /// `All your financial matters under one roof to plan and save`
  String get OnBoarding3 {
    return Intl.message(
      'All your financial matters under one roof to plan and save',
      name: 'OnBoarding3',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get OnBoarding13title {
    return Intl.message(
      'Finance',
      name: 'OnBoarding13title',
      desc: '',
      args: [],
    );
  }

  /// `All your financial matters under one roof to plan and save`
  String get OnBoarding3footer {
    return Intl.message(
      'All your financial matters under one roof to plan and save',
      name: 'OnBoarding3footer',
      desc: '',
      args: [],
    );
  }

  /// `All that in one application`
  String get OnBoarding4 {
    return Intl.message(
      'All that in one application',
      name: 'OnBoarding4',
      desc: '',
      args: [],
    );
  }

  /// `All In One Apps`
  String get OnBoarding4title {
    return Intl.message(
      'All In One Apps',
      name: 'OnBoarding4title',
      desc: '',
      args: [],
    );
  }

  /// `All that in one application`
  String get OnBoarding4footer {
    return Intl.message(
      'All that in one application',
      name: 'OnBoarding4footer',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get Forget_Password {
    return Intl.message(
      'Forget Password?',
      name: 'Forget_Password',
      desc: '',
      args: [],
    );
  }

  /// `Login_With_Google`
  String get Login_With_Google {
    return Intl.message(
      'Login_With_Google',
      name: 'Login_With_Google',
      desc: '',
      args: [],
    );
  }

  /// `Register With Google`
  String get Register_With_Google {
    return Intl.message(
      'Register With Google',
      name: 'Register_With_Google',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry.`
  String get Loginfooter {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      name: 'Loginfooter',
      desc: '',
      args: [],
    );
  }

  /// `Password not valid`
  String get validatorPassword1 {
    return Intl.message(
      'Password not valid',
      name: 'validatorPassword1',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a number with password`
  String get validatorPassword2 {
    return Intl.message(
      'Please enter a number with password',
      name: 'validatorPassword2',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get Mobile_Number {
    return Intl.message(
      'Mobile Number',
      name: 'Mobile_Number',
      desc: '',
      args: [],
    );
  }

  /// `Phone not valid`
  String get validatorMobileNumber {
    return Intl.message(
      'Phone not valid',
      name: 'validatorMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry.`
  String get Forgetpasswordfooter {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      name: 'Forgetpasswordfooter',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get Send_code {
    return Intl.message(
      'Send code',
      name: 'Send_code',
      desc: '',
      args: [],
    );
  }

  /// `I wish their was two \n like you in this world`
  String get Registerfooter {
    return Intl.message(
      'I wish their was two \n like you in this world',
      name: 'Registerfooter',
      desc: '',
      args: [],
    );
  }

  /// `What’s your name`
  String get Registerfooter2 {
    return Intl.message(
      'What’s your name',
      name: 'Registerfooter2',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get Birth_Date {
    return Intl.message(
      'Birth Date',
      name: 'Birth_Date',
      desc: '',
      args: [],
    );
  }

  /// `Cake?`
  String get RegisterButton1 {
    return Intl.message(
      'Cake?',
      name: 'RegisterButton1',
      desc: '',
      args: [],
    );
  }

  /// `Basboosh`
  String get RegisterButton2 {
    return Intl.message(
      'Basboosh',
      name: 'RegisterButton2',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry.`
  String get Registerfooter3 {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      name: 'Registerfooter3',
      desc: '',
      args: [],
    );
  }

  /// `dreams achieved`
  String get dreams_achieved {
    return Intl.message(
      'dreams achieved',
      name: 'dreams_achieved',
      desc: '',
      args: [],
    );
  }

  /// `My Life`
  String get my_life {
    return Intl.message(
      'My Life',
      name: 'my_life',
      desc: '',
      args: [],
    );
  }

  /// `Today To Do List`
  String get today_to_do_list {
    return Intl.message(
      'Today To Do List',
      name: 'today_to_do_list',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `positivity in this day`
  String get positivity_in_this_day {
    return Intl.message(
      'positivity in this day',
      name: 'positivity_in_this_day',
      desc: '',
      args: [],
    );
  }

  /// `total positive thing`
  String get total_positive_thing {
    return Intl.message(
      'total positive thing',
      name: 'total_positive_thing',
      desc: '',
      args: [],
    );
  }

  /// `Set Time and Date`
  String get set_time_and_date {
    return Intl.message(
      'Set Time and Date',
      name: 'set_time_and_date',
      desc: '',
      args: [],
    );
  }

  /// `All Days`
  String get all_days {
    return Intl.message(
      'All Days',
      name: 'all_days',
      desc: '',
      args: [],
    );
  }

  /// `Search Friend or Person Name`
  String get search_friend_or_person_name {
    return Intl.message(
      'Search Friend or Person Name',
      name: 'search_friend_or_person_name',
      desc: '',
      args: [],
    );
  }

  /// `Add An Task`
  String get add_an_task {
    return Intl.message(
      'Add An Task',
      name: 'add_an_task',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get Date_and_time {
    return Intl.message(
      'Date & Time',
      name: 'Date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Email not valid`
  String get validatoremail {
    return Intl.message(
      'Email not valid',
      name: 'validatoremail',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password not valid`
  String get validatorconfirmPassword {
    return Intl.message(
      'Confirm Password not valid',
      name: 'validatorconfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get Verify {
    return Intl.message(
      'Verify',
      name: 'Verify',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry.`
  String get confirmPasswordfooter {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      name: 'confirmPasswordfooter',
      desc: '',
      args: [],
    );
  }

  /// `enter verification code below, the code sent to`
  String get verifyfooter {
    return Intl.message(
      'enter verification code below, the code sent to',
      name: 'verifyfooter',
      desc: '',
      args: [],
    );
  }

  /// `Did’nt recieve code`
  String get recieve_code {
    return Intl.message(
      'Did’nt recieve code',
      name: 'recieve_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get Resend_Code {
    return Intl.message(
      'Resend Code',
      name: 'Resend_Code',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry.`
  String get Registerfooter4 {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      name: 'Registerfooter4',
      desc: '',
      args: [],
    );
  }

  /// `Set Mohra ID (user name)`
  String get Registertitly4 {
    return Intl.message(
      'Set Mohra ID (user name)',
      name: 'Registertitly4',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Mohra ID (User Name)`
  String get Enter_your_user_name {
    return Intl.message(
      'Enter your Mohra ID (User Name)',
      name: 'Enter_your_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hi {
    return Intl.message(
      'Hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to your own world far a way from all disturbance in here you matter the mosts`
  String get Registerfooter5 {
    return Intl.message(
      'Welcome to your own world far a way from all disturbance in here you matter the mosts',
      name: 'Registerfooter5',
      desc: '',
      args: [],
    );
  }

  /// `Start the personality test `
  String get RegisterButton5 {
    return Intl.message(
      'Start the personality test ',
      name: 'RegisterButton5',
      desc: '',
      args: [],
    );
  }

  /// `Video Call`
  String get video_call {
    return Intl.message(
      'Video Call',
      name: 'video_call',
      desc: '',
      args: [],
    );
  }

  /// `Voice Call`
  String get voice_call {
    return Intl.message(
      'Voice Call',
      name: 'voice_call',
      desc: '',
      args: [],
    );
  }

  /// `Group Call`
  String get group_call {
    return Intl.message(
      'Group Call',
      name: 'group_call',
      desc: '',
      args: [],
    );
  }

  /// `Single Call`
  String get single_call {
    return Intl.message(
      'Single Call',
      name: 'single_call',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get do_not_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'do_not_have_account',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Silver`
  String get silver {
    return Intl.message(
      'Silver',
      name: 'silver',
      desc: '',
      args: [],
    );
  }

  /// `Golden`
  String get golden {
    return Intl.message(
      'Golden',
      name: 'golden',
      desc: '',
      args: [],
    );
  }

  /// `Platinum`
  String get platinum {
    return Intl.message(
      'Platinum',
      name: 'platinum',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get vip {
    return Intl.message(
      'VIP',
      name: 'vip',
      desc: '',
      args: [],
    );
  }

  /// `please select at least one ticket`
  String get no_selected_tickets_msg {
    return Intl.message(
      'please select at least one ticket',
      name: 'no_selected_tickets_msg',
      desc: '',
      args: [],
    );
  }

  /// `please fill all personal info`
  String get fill_personal_info_msg {
    return Intl.message(
      'please fill all personal info',
      name: 'fill_personal_info_msg',
      desc: '',
      args: [],
    );
  }

  /// `please accept terms and conditions`
  String get accept_terms_msg {
    return Intl.message(
      'please accept terms and conditions',
      name: 'accept_terms_msg',
      desc: '',
      args: [],
    );
  }

  /// `pdf downloaded to`
  String get pdf_downloaded {
    return Intl.message(
      'pdf downloaded to',
      name: 'pdf_downloaded',
      desc: '',
      args: [],
    );
  }

  /// `Add Friends`
  String get add_friends {
    return Intl.message(
      'Add Friends',
      name: 'add_friends',
      desc: '',
      args: [],
    );
  }

  /// `Add Friend`
  String get add_friend {
    return Intl.message(
      'Add Friend',
      name: 'add_friend',
      desc: '',
      args: [],
    );
  }

  /// `Request Sent`
  String get request_sent {
    return Intl.message(
      'Request Sent',
      name: 'request_sent',
      desc: '',
      args: [],
    );
  }

  /// `My Friends`
  String get my_friends {
    return Intl.message(
      'My Friends',
      name: 'my_friends',
      desc: '',
      args: [],
    );
  }

  /// `Messages Cleared`
  String get messages_cleared {
    return Intl.message(
      'Messages Cleared',
      name: 'messages_cleared',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get block {
    return Intl.message(
      'Block',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `Clear Messages`
  String get clear_messages {
    return Intl.message(
      'Clear Messages',
      name: 'clear_messages',
      desc: '',
      args: [],
    );
  }

  /// `Mute`
  String get mute {
    return Intl.message(
      'Mute',
      name: 'mute',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Blocked successfully`
  String get blocked_successfully {
    return Intl.message(
      'Blocked successfully',
      name: 'blocked_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Friend Request`
  String get friend_request {
    return Intl.message(
      'Friend Request',
      name: 'friend_request',
      desc: '',
      args: [],
    );
  }

  /// `My Requests`
  String get my_request {
    return Intl.message(
      'My Requests',
      name: 'my_request',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get blocked {
    return Intl.message(
      'Blocked',
      name: 'blocked',
      desc: '',
      args: [],
    );
  }

  /// `Unblocked successfully`
  String get unblocked_successfully {
    return Intl.message(
      'Unblocked successfully',
      name: 'unblocked_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Workout  Recomendations`
  String get workout_reccommendation {
    return Intl.message(
      'Workout  Recomendations',
      name: 'workout_reccommendation',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle Play`
  String get shuffle_play {
    return Intl.message(
      'Shuffle Play',
      name: 'shuffle_play',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle Off`
  String get shuffle_off {
    return Intl.message(
      'Shuffle Off',
      name: 'shuffle_off',
      desc: '',
      args: [],
    );
  }

  /// `Album Details`
  String get album_details {
    return Intl.message(
      'Album Details',
      name: 'album_details',
      desc: '',
      args: [],
    );
  }

  /// `Recently Played`
  String get recently_played {
    return Intl.message(
      'Recently Played',
      name: 'recently_played',
      desc: '',
      args: [],
    );
  }

  /// `No songs for now`
  String get no_songs_now {
    return Intl.message(
      'No songs for now',
      name: 'no_songs_now',
      desc: '',
      args: [],
    );
  }

  /// `Popular Artists`
  String get popular_artists {
    return Intl.message(
      'Popular Artists',
      name: 'popular_artists',
      desc: '',
      args: [],
    );
  }

  /// `No artists for now`
  String get no_artists_now {
    return Intl.message(
      'No artists for now',
      name: 'no_artists_now',
      desc: '',
      args: [],
    );
  }

  /// `Your Playlists`
  String get your_playlists {
    return Intl.message(
      'Your Playlists',
      name: 'your_playlists',
      desc: '',
      args: [],
    );
  }

  /// `No playlists for now`
  String get no_playlists_now {
    return Intl.message(
      'No playlists for now',
      name: 'no_playlists_now',
      desc: '',
      args: [],
    );
  }

  /// `songs`
  String get songs {
    return Intl.message(
      'songs',
      name: 'songs',
      desc: '',
      args: [],
    );
  }

  /// `Create Playlist`
  String get create_playlist {
    return Intl.message(
      'Create Playlist',
      name: 'create_playlist',
      desc: '',
      args: [],
    );
  }

  /// `No saved songs for now`
  String get no_saved_songs_now {
    return Intl.message(
      'No saved songs for now',
      name: 'no_saved_songs_now',
      desc: '',
      args: [],
    );
  }

  /// `No saved albums for now`
  String get no_saved_albums_now {
    return Intl.message(
      'No saved albums for now',
      name: 'no_saved_albums_now',
      desc: '',
      args: [],
    );
  }

  /// `Playlist`
  String get playlist {
    return Intl.message(
      'Playlist',
      name: 'playlist',
      desc: '',
      args: [],
    );
  }

  /// `Album`
  String get album {
    return Intl.message(
      'Album',
      name: 'album',
      desc: '',
      args: [],
    );
  }

  /// `Artist`
  String get artist {
    return Intl.message(
      'Artist',
      name: 'artist',
      desc: '',
      args: [],
    );
  }

  /// `Playlists`
  String get playlists {
    return Intl.message(
      'Playlists',
      name: 'playlists',
      desc: '',
      args: [],
    );
  }

  /// `Albums`
  String get albums {
    return Intl.message(
      'Albums',
      name: 'albums',
      desc: '',
      args: [],
    );
  }

  /// `{artist} Albums`
  String artist_albums_title(Object artist) {
    return Intl.message(
      '$artist Albums',
      name: 'artist_albums_title',
      desc: '',
      args: [artist],
    );
  }

  /// `Artists`
  String get artists {
    return Intl.message(
      'Artists',
      name: 'artists',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Add Song`
  String get add_song {
    return Intl.message(
      'Add Song',
      name: 'add_song',
      desc: '',
      args: [],
    );
  }

  /// `Playlist Details`
  String get playlist_details {
    return Intl.message(
      'Playlist Details',
      name: 'playlist_details',
      desc: '',
      args: [],
    );
  }

  /// `Edit Playlist`
  String get edit_playlist {
    return Intl.message(
      'Edit Playlist',
      name: 'edit_playlist',
      desc: '',
      args: [],
    );
  }

  /// `Song added successfully`
  String get add_song_success {
    return Intl.message(
      'Song added successfully',
      name: 'add_song_success',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get no_results_found {
    return Intl.message(
      'No results found',
      name: 'no_results_found',
      desc: '',
      args: [],
    );
  }

  /// `Search for songs`
  String get search_for_songs {
    return Intl.message(
      'Search for songs',
      name: 'search_for_songs',
      desc: '',
      args: [],
    );
  }

  /// `Search for albums`
  String get search_for_albums {
    return Intl.message(
      'Search for albums',
      name: 'search_for_albums',
      desc: '',
      args: [],
    );
  }

  /// `You should cerate the playlist before adding the photo`
  String get create_playlist_before_adding_photo_error {
    return Intl.message(
      'You should cerate the playlist before adding the photo',
      name: 'create_playlist_before_adding_photo_error',
      desc: '',
      args: [],
    );
  }

  /// `Enter playlist name`
  String get playlist_name_hint {
    return Intl.message(
      'Enter playlist name',
      name: 'playlist_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Uploading ...`
  String get uploading {
    return Intl.message(
      'Uploading ...',
      name: 'uploading',
      desc: '',
      args: [],
    );
  }

  /// `Playlist created successfully`
  String get create_playlist_success {
    return Intl.message(
      'Playlist created successfully',
      name: 'create_playlist_success',
      desc: '',
      args: [],
    );
  }

  /// `Playlist updated successfully`
  String get update_playlist_success {
    return Intl.message(
      'Playlist updated successfully',
      name: 'update_playlist_success',
      desc: '',
      args: [],
    );
  }

  /// `Image updated successfully`
  String get update_image_success {
    return Intl.message(
      'Image updated successfully',
      name: 'update_image_success',
      desc: '',
      args: [],
    );
  }

  /// `Moments`
  String get moments {
    return Intl.message(
      'Moments',
      name: 'moments',
      desc: '',
      args: [],
    );
  }

  /// `Played from`
  String get played_from {
    return Intl.message(
      'Played from',
      name: 'played_from',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get library {
    return Intl.message(
      'Library',
      name: 'library',
      desc: '',
      args: [],
    );
  }

  /// `My Library`
  String get my_library {
    return Intl.message(
      'My Library',
      name: 'my_library',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Authentication failed`
  String get auth_failed {
    return Intl.message(
      'Authentication failed',
      name: 'auth_failed',
      desc: '',
      args: [],
    );
  }

  /// `Love`
  String get love {
    return Intl.message(
      'Love',
      name: 'love',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get like {
    return Intl.message(
      'Like',
      name: 'like',
      desc: '',
      args: [],
    );
  }

  /// `Dislike`
  String get dislike {
    return Intl.message(
      'Dislike',
      name: 'dislike',
      desc: '',
      args: [],
    );
  }

  /// `Sad`
  String get sad {
    return Intl.message(
      'Sad',
      name: 'sad',
      desc: '',
      args: [],
    );
  }

  /// `Haha`
  String get haha {
    return Intl.message(
      'Haha',
      name: 'haha',
      desc: '',
      args: [],
    );
  }

  /// `Amazed`
  String get amazed {
    return Intl.message(
      'Amazed',
      name: 'amazed',
      desc: '',
      args: [],
    );
  }

  /// `Angry`
  String get angry {
    return Intl.message(
      'Angry',
      name: 'angry',
      desc: '',
      args: [],
    );
  }

  /// `Dizzy`
  String get dizzy {
    return Intl.message(
      'Dizzy',
      name: 'dizzy',
      desc: '',
      args: [],
    );
  }

  /// `Unhappy`
  String get unhappy {
    return Intl.message(
      'Unhappy',
      name: 'unhappy',
      desc: '',
      args: [],
    );
  }

  /// `Cheeky`
  String get cheeky {
    return Intl.message(
      'Cheeky',
      name: 'cheeky',
      desc: '',
      args: [],
    );
  }

  /// `Serious`
  String get serious {
    return Intl.message(
      'Serious',
      name: 'serious',
      desc: '',
      args: [],
    );
  }

  /// `Cool`
  String get cool {
    return Intl.message(
      'Cool',
      name: 'cool',
      desc: '',
      args: [],
    );
  }

  /// `Stupid`
  String get stupid {
    return Intl.message(
      'Stupid',
      name: 'stupid',
      desc: '',
      args: [],
    );
  }

  /// `Crying`
  String get crying {
    return Intl.message(
      'Crying',
      name: 'crying',
      desc: '',
      args: [],
    );
  }

  /// `Wink`
  String get wink {
    return Intl.message(
      'Wink',
      name: 'wink',
      desc: '',
      args: [],
    );
  }

  /// `Bad`
  String get bad {
    return Intl.message(
      'Bad',
      name: 'bad',
      desc: '',
      args: [],
    );
  }

  /// `Pensive`
  String get pensive {
    return Intl.message(
      'Pensive',
      name: 'pensive',
      desc: '',
      args: [],
    );
  }

  /// `Drooling`
  String get drooling {
    return Intl.message(
      'Drooling',
      name: 'drooling',
      desc: '',
      args: [],
    );
  }

  /// `Silly`
  String get silly {
    return Intl.message(
      'Silly',
      name: 'silly',
      desc: '',
      args: [],
    );
  }

  /// `Satisfied`
  String get satisfied {
    return Intl.message(
      'Satisfied',
      name: 'satisfied',
      desc: '',
      args: [],
    );
  }

  /// `Dead`
  String get dead {
    return Intl.message(
      'Dead',
      name: 'dead',
      desc: '',
      args: [],
    );
  }

  /// `Confused`
  String get confused {
    return Intl.message(
      'Confused',
      name: 'confused',
      desc: '',
      args: [],
    );
  }

  /// `Greed`
  String get greed {
    return Intl.message(
      'Greed',
      name: 'greed',
      desc: '',
      args: [],
    );
  }

  /// `Grinning`
  String get grinning {
    return Intl.message(
      'Grinning',
      name: 'grinning',
      desc: '',
      args: [],
    );
  }

  /// `Shocked`
  String get shocked {
    return Intl.message(
      'Shocked',
      name: 'shocked',
      desc: '',
      args: [],
    );
  }

  /// `Happy`
  String get happy {
    return Intl.message(
      'Happy',
      name: 'happy',
      desc: '',
      args: [],
    );
  }

  /// `Tired`
  String get tired {
    return Intl.message(
      'Tired',
      name: 'tired',
      desc: '',
      args: [],
    );
  }

  /// `with`
  String get with_trs {
    return Intl.message(
      'with',
      name: 'with_trs',
      desc: '',
      args: [],
    );
  }

  /// `comments`
  String get comments {
    return Intl.message(
      'comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `No, i cant`
  String get i_cant {
    return Intl.message(
      'No, i cant',
      name: 'i_cant',
      desc: '',
      args: [],
    );
  }

  /// `reactions`
  String get reactions {
    return Intl.message(
      'reactions',
      name: 'reactions',
      desc: '',
      args: [],
    );
  }

  /// `Listening to`
  String get listening_to {
    return Intl.message(
      'Listening to',
      name: 'listening_to',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations,`
  String get congratulations {
    return Intl.message(
      'Congratulations,',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `you got ${points} points for completing the challenge`
  String complete_challenge_success(Object points) {
    return Intl.message(
      'you got \$$points points for completing the challenge',
      name: 'complete_challenge_success',
      desc: '',
      args: [points],
    );
  }

  /// `Matched location`
  String get matched_location {
    return Intl.message(
      'Matched location',
      name: 'matched_location',
      desc: '',
      args: [],
    );
  }

  /// `Select location`
  String get select_location {
    return Intl.message(
      'Select location',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `How you're feeling ?`
  String get how_are_you_feeling {
    return Intl.message(
      'How you\'re feeling ?',
      name: 'how_are_you_feeling',
      desc: '',
      args: [],
    );
  }

  /// `Post created successfully`
  String get create_post_success {
    return Intl.message(
      'Post created successfully',
      name: 'create_post_success',
      desc: '',
      args: [],
    );
  }

  /// `Post updated successfully`
  String get update_post_success {
    return Intl.message(
      'Post updated successfully',
      name: 'update_post_success',
      desc: '',
      args: [],
    );
  }

  /// `verify your attendance  by posting your activity there on your moment match`
  String get verify_attendant {
    return Intl.message(
      'verify your attendance  by posting your activity there on your moment match',
      name: 'verify_attendant',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully ...`
  String get claiming_rewards {
    return Intl.message(
      'Updated Successfully ...',
      name: 'claiming_rewards',
      desc: '',
      args: [],
    );
  }

  /// `Reward Claimed`
  String get reward_claimed {
    return Intl.message(
      'Reward Claimed',
      name: 'reward_claimed',
      desc: '',
      args: [],
    );
  }

  /// `Search for places`
  String get search_for_places {
    return Intl.message(
      'Search for places',
      name: 'search_for_places',
      desc: '',
      args: [],
    );
  }

  /// `Images And Videos Picker`
  String get images_video_picker {
    return Intl.message(
      'Images And Videos Picker',
      name: 'images_video_picker',
      desc: '',
      args: [],
    );
  }

  /// `Feeling`
  String get feeling {
    return Intl.message(
      'Feeling',
      name: 'feeling',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get capture_image {
    return Intl.message(
      'Image',
      name: 'capture_image',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get capture_video {
    return Intl.message(
      'Video',
      name: 'capture_video',
      desc: '',
      args: [],
    );
  }

  /// `Photo from the studio`
  String get gallery_image {
    return Intl.message(
      'Photo from the studio',
      name: 'gallery_image',
      desc: '',
      args: [],
    );
  }

  /// `Video from the studio`
  String get gallery_video {
    return Intl.message(
      'Video from the studio',
      name: 'gallery_video',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't match your location yet`
  String get match_location_not_complete_yet {
    return Intl.message(
      'We couldn\'t match your location yet',
      name: 'match_location_not_complete_yet',
      desc: '',
      args: [],
    );
  }

  /// `Please select a feeling`
  String get select_feeling {
    return Intl.message(
      'Please select a feeling',
      name: 'select_feeling',
      desc: '',
      args: [],
    );
  }

  /// `Please select a location`
  String get select_location_err {
    return Intl.message(
      'Please select a location',
      name: 'select_location_err',
      desc: '',
      args: [],
    );
  }

  /// `days ago`
  String get days_ago {
    return Intl.message(
      'days ago',
      name: 'days_ago',
      desc: '',
      args: [],
    );
  }

  /// `hours ago`
  String get hours_ago {
    return Intl.message(
      'hours ago',
      name: 'hours_ago',
      desc: '',
      args: [],
    );
  }

  /// `minutes ago`
  String get minutes_ago {
    return Intl.message(
      'minutes ago',
      name: 'minutes_ago',
      desc: '',
      args: [],
    );
  }

  /// `seconds ago`
  String get seconds_ago {
    return Intl.message(
      'seconds ago',
      name: 'seconds_ago',
      desc: '',
      args: [],
    );
  }

  /// `day ago`
  String get day_ago {
    return Intl.message(
      'day ago',
      name: 'day_ago',
      desc: '',
      args: [],
    );
  }

  /// `hour ago`
  String get hour_ago {
    return Intl.message(
      'hour ago',
      name: 'hour_ago',
      desc: '',
      args: [],
    );
  }

  /// `minute ago`
  String get minute_ago {
    return Intl.message(
      'minute ago',
      name: 'minute_ago',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Invite Friends`
  String get invite_friends {
    return Intl.message(
      'Invite Friends',
      name: 'invite_friends',
      desc: '',
      args: [],
    );
  }

  /// `Claim Your Rewards`
  String get claim_rewards {
    return Intl.message(
      'Claim Your Rewards',
      name: 'claim_rewards',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get place {
    return Intl.message(
      'Place',
      name: 'place',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get you {
    return Intl.message(
      'You',
      name: 'you',
      desc: '',
      args: [],
    );
  }

  /// `And many more`
  String get and_many_more {
    return Intl.message(
      'And many more',
      name: 'and_many_more',
      desc: '',
      args: [],
    );
  }

  /// `Feeling`
  String get feeling_noun {
    return Intl.message(
      'Feeling',
      name: 'feeling_noun',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music_2 {
    return Intl.message(
      'Music',
      name: 'music_2',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post_noun {
    return Intl.message(
      'Post',
      name: 'post_noun',
      desc: '',
      args: [],
    );
  }

  /// `Dream and Dream icon required`
  String get dream_dream_icon_required {
    return Intl.message(
      'Dream and Dream icon required',
      name: 'dream_dream_icon_required',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get appointment {
    return Intl.message(
      'Appointment',
      name: 'appointment',
      desc: '',
      args: [],
    );
  }

  /// `To Do List`
  String get to_do_list {
    return Intl.message(
      'To Do List',
      name: 'to_do_list',
      desc: '',
      args: [],
    );
  }

  /// `My Dream`
  String get my_dream {
    return Intl.message(
      'My Dream',
      name: 'my_dream',
      desc: '',
      args: [],
    );
  }

  /// `My Dreams`
  String get my_dreams {
    return Intl.message(
      'My Dreams',
      name: 'my_dreams',
      desc: '',
      args: [],
    );
  }

  /// `Add Positivity`
  String get add_positivity {
    return Intl.message(
      'Add Positivity',
      name: 'add_positivity',
      desc: '',
      args: [],
    );
  }

  /// `Add Positivity Today`
  String get add_positivity_today {
    return Intl.message(
      'Add Positivity Today',
      name: 'add_positivity_today',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about your dreams`
  String get tell_us_about_your_dreams {
    return Intl.message(
      'Tell us about your dreams',
      name: 'tell_us_about_your_dreams',
      desc: '',
      args: [],
    );
  }

  /// `What your dreams ?`
  String get dream_title_hint {
    return Intl.message(
      'What your dreams ?',
      name: 'dream_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add Step To Reach Your Dreams`
  String get add_step_to_reach_your_dreams {
    return Intl.message(
      'Add Step To Reach Your Dreams',
      name: 'add_step_to_reach_your_dreams',
      desc: '',
      args: [],
    );
  }

  /// `Dream Step`
  String get dream_step {
    return Intl.message(
      'Dream Step',
      name: 'dream_step',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Dream`
  String get create_your_dream {
    return Intl.message(
      'Create Your Dream',
      name: 'create_your_dream',
      desc: '',
      args: [],
    );
  }

  /// `Save My Dream`
  String get save_my_dream {
    return Intl.message(
      'Save My Dream',
      name: 'save_my_dream',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get of_trs {
    return Intl.message(
      'of',
      name: 'of_trs',
      desc: '',
      args: [],
    );
  }

  /// `step achieved`
  String get step_achieved {
    return Intl.message(
      'step achieved',
      name: 'step_achieved',
      desc: '',
      args: [],
    );
  }

  /// `STEP TO REACH GOAL`
  String get step_to_reach_goal {
    return Intl.message(
      'STEP TO REACH GOAL',
      name: 'step_to_reach_goal',
      desc: '',
      args: [],
    );
  }

  /// `Dream Icon`
  String get dream_icon {
    return Intl.message(
      'Dream Icon',
      name: 'dream_icon',
      desc: '',
      args: [],
    );
  }

  /// `Select available icon for your dream`
  String get select_dream_icon {
    return Intl.message(
      'Select available icon for your dream',
      name: 'select_dream_icon',
      desc: '',
      args: [],
    );
  }

  /// `step`
  String get step {
    return Intl.message(
      'step',
      name: 'step',
      desc: '',
      args: [],
    );
  }

  /// `Very Important`
  String get very_important {
    return Intl.message(
      'Very Important',
      name: 'very_important',
      desc: '',
      args: [],
    );
  }

  /// `Important`
  String get important {
    return Intl.message(
      'Important',
      name: 'important',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get normal {
    return Intl.message(
      'Normal',
      name: 'normal',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `weeks`
  String get weeks {
    return Intl.message(
      'weeks',
      name: 'weeks',
      desc: '',
      args: [],
    );
  }

  /// `months`
  String get months {
    return Intl.message(
      'months',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Pick a file`
  String get pick_file {
    return Intl.message(
      'Pick a file',
      name: 'pick_file',
      desc: '',
      args: [],
    );
  }

  /// `PM`
  String get pm {
    return Intl.message(
      'PM',
      name: 'pm',
      desc: '',
      args: [],
    );
  }

  /// `AM`
  String get am {
    return Intl.message(
      'AM',
      name: 'am',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get person {
    return Intl.message(
      'Person',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `Search friend or person`
  String get search_friend_or_person {
    return Intl.message(
      'Search friend or person',
      name: 'search_friend_or_person',
      desc: '',
      args: [],
    );
  }

  /// `Add a task`
  String get add_a_task {
    return Intl.message(
      'Add a task',
      name: 'add_a_task',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get date_time {
    return Intl.message(
      'Date & Time',
      name: 'date_time',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message(
      'Repeat',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `Share with`
  String get share_with {
    return Intl.message(
      'Share with',
      name: 'share_with',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Today's Appointment`
  String get today_appointment {
    return Intl.message(
      'Today\'s Appointment',
      name: 'today_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get appointments {
    return Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );
  }

  /// `dreams in progress`
  String get dream_in_progress {
    return Intl.message(
      'dreams in progress',
      name: 'dream_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `dreams achieved`
  String get dream_achieved {
    return Intl.message(
      'dreams achieved',
      name: 'dream_achieved',
      desc: '',
      args: [],
    );
  }

  /// `EPISODE`
  String get episode {
    return Intl.message(
      'EPISODE',
      name: 'episode',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get likes {
    return Intl.message(
      'Likes',
      name: 'likes',
      desc: '',
      args: [],
    );
  }

  /// `Dislikes`
  String get dislikes {
    return Intl.message(
      'Dislikes',
      name: 'dislikes',
      desc: '',
      args: [],
    );
  }

  /// `Dreams`
  String get dreams {
    return Intl.message(
      'Dreams',
      name: 'dreams',
      desc: '',
      args: [],
    );
  }

  /// `Positivity`
  String get positivity {
    return Intl.message(
      'Positivity',
      name: 'positivity',
      desc: '',
      args: [],
    );
  }

  /// `Story`
  String get story {
    return Intl.message(
      'Story',
      name: 'story',
      desc: '',
      args: [],
    );
  }

  /// `To Do`
  String get to_do {
    return Intl.message(
      'To Do',
      name: 'to_do',
      desc: '',
      args: [],
    );
  }

  /// `You don't have appointment today`
  String get you_dont_have_appointment_today {
    return Intl.message(
      'You don\'t have appointment today',
      name: 'you_dont_have_appointment_today',
      desc: '',
      args: [],
    );
  }

  /// `Add An Appointment`
  String get add_appointment {
    return Intl.message(
      'Add An Appointment',
      name: 'add_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Today's To Do List`
  String get today_todo_list {
    return Intl.message(
      'Today\'s To Do List',
      name: 'today_todo_list',
      desc: '',
      args: [],
    );
  }

  /// `To Do List`
  String get todo_list {
    return Intl.message(
      'To Do List',
      name: 'todo_list',
      desc: '',
      args: [],
    );
  }

  /// `You dont have any to do list today`
  String get you_dont_have_todo_list_today {
    return Intl.message(
      'You dont have any to do list today',
      name: 'you_dont_have_todo_list_today',
      desc: '',
      args: [],
    );
  }

  /// `Add To Do List`
  String get add_todo_list {
    return Intl.message(
      'Add To Do List',
      name: 'add_todo_list',
      desc: '',
      args: [],
    );
  }

  /// `Add My Dreams`
  String get add_my_dreams {
    return Intl.message(
      'Add My Dreams',
      name: 'add_my_dreams',
      desc: '',
      args: [],
    );
  }

  /// `To help you reach your goals, Please fill in at least 20 dreams Explain your dreams and plans to achieve them`
  String get help_to_reach_dreams_message {
    return Intl.message(
      'To help you reach your goals, Please fill in at least 20 dreams Explain your dreams and plans to achieve them',
      name: 'help_to_reach_dreams_message',
      desc: '',
      args: [],
    );
  }

  /// `Load More Stories`
  String get load_more_stories {
    return Intl.message(
      'Load More Stories',
      name: 'load_more_stories',
      desc: '',
      args: [],
    );
  }

  /// `We hope you write the positive things that happened to you today. Think a little, for sure you will find something!`
  String get add_positivity_message {
    return Intl.message(
      'We hope you write the positive things that happened to you today. Think a little, for sure you will find something!',
      name: 'add_positivity_message',
      desc: '',
      args: [],
    );
  }

  /// `Today's Positivity`
  String get today_positivity {
    return Intl.message(
      'Today\'s Positivity',
      name: 'today_positivity',
      desc: '',
      args: [],
    );
  }

  /// `Delete Group`
  String get delete_group {
    return Intl.message(
      'Delete Group',
      name: 'delete_group',
      desc: '',
      args: [],
    );
  }

  /// `Group Deleted`
  String get group_deleted {
    return Intl.message(
      'Group Deleted',
      name: 'group_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Edit Group`
  String get edit_group {
    return Intl.message(
      'Edit Group',
      name: 'edit_group',
      desc: '',
      args: [],
    );
  }

  /// `Added successfully`
  String get added_successfully {
    return Intl.message(
      'Added successfully',
      name: 'added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Add members`
  String get add_members {
    return Intl.message(
      'Add members',
      name: 'add_members',
      desc: '',
      args: [],
    );
  }

  /// `Remove members`
  String get remove_members {
    return Intl.message(
      'Remove members',
      name: 'remove_members',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Removed Successfully`
  String get removed_successfully {
    return Intl.message(
      'Removed Successfully',
      name: 'removed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get image {
    return Intl.message(
      'Image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Press mic button to record messages`
  String get record_message {
    return Intl.message(
      'Press mic button to record messages',
      name: 'record_message',
      desc: '',
      args: [],
    );
  }

  /// `Create Event`
  String get create_event {
    return Intl.message(
      'Create Event',
      name: 'create_event',
      desc: '',
      args: [],
    );
  }

  /// `Mark As Read`
  String get mark_as_read {
    return Intl.message(
      'Mark As Read',
      name: 'mark_as_read',
      desc: '',
      args: [],
    );
  }

  /// `Select All`
  String get select_all {
    return Intl.message(
      'Select All',
      name: 'select_all',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code`
  String get scan_qr_code {
    return Intl.message(
      'Scan QR code',
      name: 'scan_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `hi please accept me`
  String get accept_me_message {
    return Intl.message(
      'hi please accept me',
      name: 'accept_me_message',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get files {
    return Intl.message(
      'Files',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get groups {
    return Intl.message(
      'Groups',
      name: 'groups',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get friends {
    return Intl.message(
      'Friends',
      name: 'friends',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Private Message`
  String get private_message {
    return Intl.message(
      'Private Message',
      name: 'private_message',
      desc: '',
      args: [],
    );
  }

  /// `Broadcast Message`
  String get broadcast_message {
    return Intl.message(
      'Broadcast Message',
      name: 'broadcast_message',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Write Messages`
  String get write_message {
    return Intl.message(
      'Write Messages',
      name: 'write_message',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Getting your location ...`
  String get get_location_message {
    return Intl.message(
      'Getting your location ...',
      name: 'get_location_message',
      desc: '',
      args: [],
    );
  }

  /// `Religion`
  String get religion {
    return Intl.message(
      'Religion',
      name: 'religion',
      desc: '',
      args: [],
    );
  }

  /// `Quran`
  String get quran {
    return Intl.message(
      'Quran',
      name: 'quran',
      desc: '',
      args: [],
    );
  }

  /// `Azkar`
  String get azkar {
    return Intl.message(
      'Azkar',
      name: 'azkar',
      desc: '',
      args: [],
    );
  }

  /// `Mosque Finder`
  String get mosque_finder {
    return Intl.message(
      'Mosque Finder',
      name: 'mosque_finder',
      desc: '',
      args: [],
    );
  }

  /// `Qblah`
  String get qblah {
    return Intl.message(
      'Qblah',
      name: 'qblah',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Times`
  String get prayer_times {
    return Intl.message(
      'Prayer Times',
      name: 'prayer_times',
      desc: '',
      args: [],
    );
  }

  /// `Sunrise`
  String get sunrise {
    return Intl.message(
      'Sunrise',
      name: 'sunrise',
      desc: '',
      args: [],
    );
  }

  /// `Dhuhr`
  String get dhuhr {
    return Intl.message(
      'Dhuhr',
      name: 'dhuhr',
      desc: '',
      args: [],
    );
  }

  /// `Asr`
  String get asr {
    return Intl.message(
      'Asr',
      name: 'asr',
      desc: '',
      args: [],
    );
  }

  /// `Maghrib`
  String get maghrib {
    return Intl.message(
      'Maghrib',
      name: 'maghrib',
      desc: '',
      args: [],
    );
  }

  /// `Isha`
  String get isha {
    return Intl.message(
      'Isha',
      name: 'isha',
      desc: '',
      args: [],
    );
  }

  /// `Fajr`
  String get fajr {
    return Intl.message(
      'Fajr',
      name: 'fajr',
      desc: '',
      args: [],
    );
  }

  /// `Last read`
  String get last_read {
    return Intl.message(
      'Last read',
      name: 'last_read',
      desc: '',
      args: [],
    );
  }

  /// `Ayah No`
  String get ayah_no {
    return Intl.message(
      'Ayah No',
      name: 'ayah_no',
      desc: '',
      args: [],
    );
  }

  /// `Surah`
  String get surah {
    return Intl.message(
      'Surah',
      name: 'surah',
      desc: '',
      args: [],
    );
  }

  /// `Juz`
  String get juz {
    return Intl.message(
      'Juz',
      name: 'juz',
      desc: '',
      args: [],
    );
  }

  /// `Find Mosque`
  String get find_mosque {
    return Intl.message(
      'Find Mosque',
      name: 'find_mosque',
      desc: '',
      args: [],
    );
  }

  /// `Morning`
  String get morning {
    return Intl.message(
      'Morning',
      name: 'morning',
      desc: '',
      args: [],
    );
  }

  /// `Evening`
  String get evening {
    return Intl.message(
      'Evening',
      name: 'evening',
      desc: '',
      args: [],
    );
  }

  /// `After Prayer`
  String get after_prayer {
    return Intl.message(
      'After Prayer',
      name: 'after_prayer',
      desc: '',
      args: [],
    );
  }

  /// `What’s news today!`
  String get what_is_new {
    return Intl.message(
      'What’s news today!',
      name: 'what_is_new',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get see_all {
    return Intl.message(
      'See all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `You may like`
  String get you_may_like {
    return Intl.message(
      'You may like',
      name: 'you_may_like',
      desc: '',
      args: [],
    );
  }

  /// `Today News Summary`
  String get today_news_summary {
    return Intl.message(
      'Today News Summary',
      name: 'today_news_summary',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Send message to`
  String get send_message_to {
    return Intl.message(
      'Send message to',
      name: 'send_message_to',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get expenses {
    return Intl.message(
      'Expenses',
      name: 'expenses',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get sports {
    return Intl.message(
      'Sports',
      name: 'sports',
      desc: '',
      args: [],
    );
  }

  /// `Top Picks For You`
  String get picks_for_you {
    return Intl.message(
      'Top Picks For You',
      name: 'picks_for_you',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get good_morning {
    return Intl.message(
      'Good Morning',
      name: 'good_morning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get good_afternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'good_afternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get good_evening {
    return Intl.message(
      'Good Evening',
      name: 'good_evening',
      desc: '',
      args: [],
    );
  }

  /// `Lovely Night`
  String get good_night {
    return Intl.message(
      'Lovely Night',
      name: 'good_night',
      desc: '',
      args: [],
    );
  }

  /// `My Contacts`
  String get my_contacts {
    return Intl.message(
      'My Contacts',
      name: 'my_contacts',
      desc: '',
      args: [],
    );
  }

  /// `what do you want to do today ?`
  String get home_message_day {
    return Intl.message(
      'what do you want to do today ?',
      name: 'home_message_day',
      desc: '',
      args: [],
    );
  }

  /// `what do you want to do tonight ?`
  String get home_message_night {
    return Intl.message(
      'what do you want to do tonight ?',
      name: 'home_message_night',
      desc: '',
      args: [],
    );
  }

  /// `Challenge`
  String get challenge {
    return Intl.message(
      'Challenge',
      name: 'challenge',
      desc: '',
      args: [],
    );
  }

  /// `Join Now`
  String get join_now {
    return Intl.message(
      'Join Now',
      name: 'join_now',
      desc: '',
      args: [],
    );
  }

  /// `Un join`
  String get un_join {
    return Intl.message(
      'Un join',
      name: 'un_join',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `My QR code`
  String get my_qr_code {
    return Intl.message(
      'My QR code',
      name: 'my_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Before using health feature we need to know about your self and your goal, so we can give proper plans, exercise and diet for your health`
  String get health_intro_message {
    return Intl.message(
      'Before using health feature we need to know about your self and your goal, so we can give proper plans, exercise and diet for your health',
      name: 'health_intro_message',
      desc: '',
      args: [],
    );
  }

  /// `Help us know you better`
  String get help_us_know_you {
    return Intl.message(
      'Help us know you better',
      name: 'help_us_know_you',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_confirm {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Spotify is not installed on your phone, install it and try again.`
  String get install_spotify {
    return Intl.message(
      'Spotify is not installed on your phone, install it and try again.',
      name: 'install_spotify',
      desc: '',
      args: [],
    );
  }

  /// `Install`
  String get install {
    return Intl.message(
      'Install',
      name: 'install',
      desc: '',
      args: [],
    );
  }

  /// `Enter your weight`
  String get enter_your_weight {
    return Intl.message(
      'Enter your weight',
      name: 'enter_your_weight',
      desc: '',
      args: [],
    );
  }

  /// `Enter your height`
  String get enter_your_height {
    return Intl.message(
      'Enter your height',
      name: 'enter_your_height',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Healthy`
  String get healthy {
    return Intl.message(
      'Healthy',
      name: 'healthy',
      desc: '',
      args: [],
    );
  }

  /// `Very healthy`
  String get very_healthy {
    return Intl.message(
      'Very healthy',
      name: 'very_healthy',
      desc: '',
      args: [],
    );
  }

  /// `Medical conditions`
  String get medical_conditions {
    return Intl.message(
      'Medical conditions',
      name: 'medical_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Select Birth Date`
  String get select_birth_date {
    return Intl.message(
      'Select Birth Date',
      name: 'select_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Weight summary`
  String get weight_summary {
    return Intl.message(
      'Weight summary',
      name: 'weight_summary',
      desc: '',
      args: [],
    );
  }

  /// `According to your weight and height measurement`
  String get weight_height_measure_message {
    return Intl.message(
      'According to your weight and height measurement',
      name: 'weight_height_measure_message',
      desc: '',
      args: [],
    );
  }

  /// `Ideal`
  String get ideal {
    return Intl.message(
      'Ideal',
      name: 'ideal',
      desc: '',
      args: [],
    );
  }

  /// `Your BMI`
  String get your_bmi {
    return Intl.message(
      'Your BMI',
      name: 'your_bmi',
      desc: '',
      args: [],
    );
  }

  /// `Recommended weight`
  String get recommended_weight {
    return Intl.message(
      'Recommended weight',
      name: 'recommended_weight',
      desc: '',
      args: [],
    );
  }

  /// `Setup your profile`
  String get setup_your_profile {
    return Intl.message(
      'Setup your profile',
      name: 'setup_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `All fields required`
  String get all_fields_required {
    return Intl.message(
      'All fields required',
      name: 'all_fields_required',
      desc: '',
      args: [],
    );
  }

  /// `complete all this question below before continue`
  String get complete_questions_message {
    return Intl.message(
      'complete all this question below before continue',
      name: 'complete_questions_message',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Your Personality`
  String get your_personality {
    return Intl.message(
      'Your Personality',
      name: 'your_personality',
      desc: '',
      args: [],
    );
  }

  /// `Set a goal`
  String get set_goal {
    return Intl.message(
      'Set a goal',
      name: 'set_goal',
      desc: '',
      args: [],
    );
  }

  /// `Set your target weight`
  String get set_target_weight {
    return Intl.message(
      'Set your target weight',
      name: 'set_target_weight',
      desc: '',
      args: [],
    );
  }

  /// `How quickly you want to gain`
  String get quickly_gain {
    return Intl.message(
      'How quickly you want to gain',
      name: 'quickly_gain',
      desc: '',
      args: [],
    );
  }

  /// `How quickly you want to loss`
  String get quickly_loss {
    return Intl.message(
      'How quickly you want to loss',
      name: 'quickly_loss',
      desc: '',
      args: [],
    );
  }

  /// `Select Difficulty`
  String get select_difficulty {
    return Intl.message(
      'Select Difficulty',
      name: 'select_difficulty',
      desc: '',
      args: [],
    );
  }

  /// `You will reach your goal before`
  String get reach_goal {
    return Intl.message(
      'You will reach your goal before',
      name: 'reach_goal',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Easy (0.25 kg per week)`
  String get easy_difficulty {
    return Intl.message(
      'Easy (0.25 kg per week)',
      name: 'easy_difficulty',
      desc: '',
      args: [],
    );
  }

  /// `Medium (0.50 kg per week)`
  String get medium_difficulty {
    return Intl.message(
      'Medium (0.50 kg per week)',
      name: 'medium_difficulty',
      desc: '',
      args: [],
    );
  }

  /// `Hard (1.0 kg per week)`
  String get hard_difficulty {
    return Intl.message(
      'Hard (1.0 kg per week)',
      name: 'hard_difficulty',
      desc: '',
      args: [],
    );
  }

  /// `target goal,difficulty, and Activity level are required`
  String get target_goal_required {
    return Intl.message(
      'target goal,difficulty, and Activity level are required',
      name: 'target_goal_required',
      desc: '',
      args: [],
    );
  }

  /// `Tell us your eating habit`
  String get tell_us_eating_habit {
    return Intl.message(
      'Tell us your eating habit',
      name: 'tell_us_eating_habit',
      desc: '',
      args: [],
    );
  }

  /// `question`
  String get question {
    return Intl.message(
      'question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Saving Answer`
  String get saving_answer {
    return Intl.message(
      'Saving Answer',
      name: 'saving_answer',
      desc: '',
      args: [],
    );
  }

  /// `To stay fit, you need to`
  String get to_stay_fit {
    return Intl.message(
      'To stay fit, you need to',
      name: 'to_stay_fit',
      desc: '',
      args: [],
    );
  }

  /// `Tracking your food, water, steps and workout will help you reach your goal 3x faster`
  String get tracking_your_food {
    return Intl.message(
      'Tracking your food, water, steps and workout will help you reach your goal 3x faster',
      name: 'tracking_your_food',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Eat 1700 Cal everyday`
  String get eat_cal {
    return Intl.message(
      'Eat 1700 Cal everyday',
      name: 'eat_cal',
      desc: '',
      args: [],
    );
  }

  /// `Drink 7 glasses of water everyday`
  String get drink_water {
    return Intl.message(
      'Drink 7 glasses of water everyday',
      name: 'drink_water',
      desc: '',
      args: [],
    );
  }

  /// `Walk. 10,000 steps everyday`
  String get walk_every_day {
    return Intl.message(
      'Walk. 10,000 steps everyday',
      name: 'walk_every_day',
      desc: '',
      args: [],
    );
  }

  /// `Burn 392 Cal Everyday `
  String get burn_cal {
    return Intl.message(
      'Burn 392 Cal Everyday ',
      name: 'burn_cal',
      desc: '',
      args: [],
    );
  }

  /// `Intake`
  String get intake {
    return Intl.message(
      'Intake',
      name: 'intake',
      desc: '',
      args: [],
    );
  }

  /// `kcal eaten`
  String get kcal_eaten {
    return Intl.message(
      'kcal eaten',
      name: 'kcal_eaten',
      desc: '',
      args: [],
    );
  }

  /// `Training`
  String get training {
    return Intl.message(
      'Training',
      name: 'training',
      desc: '',
      args: [],
    );
  }

  /// `kcal burned`
  String get kcal_burned {
    return Intl.message(
      'kcal burned',
      name: 'kcal_burned',
      desc: '',
      args: [],
    );
  }

  /// `Goals`
  String get goals {
    return Intl.message(
      'Goals',
      name: 'goals',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get ooff {
    return Intl.message(
      'of',
      name: 'ooff',
      desc: '',
      args: [],
    );
  }

  /// `Water`
  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: '',
      args: [],
    );
  }

  /// `Cups`
  String get cups {
    return Intl.message(
      'Cups',
      name: 'cups',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition`
  String get nutrition {
    return Intl.message(
      'Nutrition',
      name: 'nutrition',
      desc: '',
      args: [],
    );
  }

  /// `Carbs`
  String get carbs {
    return Intl.message(
      'Carbs',
      name: 'carbs',
      desc: '',
      args: [],
    );
  }

  /// `Fat`
  String get fat {
    return Intl.message(
      'Fat',
      name: 'fat',
      desc: '',
      args: [],
    );
  }

  /// `Protein`
  String get protein {
    return Intl.message(
      'Protein',
      name: 'protein',
      desc: '',
      args: [],
    );
  }

  /// `Left`
  String get left {
    return Intl.message(
      'Left',
      name: 'left',
      desc: '',
      args: [],
    );
  }

  /// `Walking`
  String get walking {
    return Intl.message(
      'Walking',
      name: 'walking',
      desc: '',
      args: [],
    );
  }

  /// `Daily Exercises`
  String get daily_exercises {
    return Intl.message(
      'Daily Exercises',
      name: 'daily_exercises',
      desc: '',
      args: [],
    );
  }

  /// `Daily Activity`
  String get daily_activity {
    return Intl.message(
      'Daily Activity',
      name: 'daily_activity',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast`
  String get breakfast {
    return Intl.message(
      'Breakfast',
      name: 'breakfast',
      desc: '',
      args: [],
    );
  }

  /// `Lunch`
  String get lunch {
    return Intl.message(
      'Lunch',
      name: 'lunch',
      desc: '',
      args: [],
    );
  }

  /// `Dinner`
  String get dinner {
    return Intl.message(
      'Dinner',
      name: 'dinner',
      desc: '',
      args: [],
    );
  }

  /// `Snack`
  String get snack {
    return Intl.message(
      'Snack',
      name: 'snack',
      desc: '',
      args: [],
    );
  }

  /// `Birth date`
  String get birth_date {
    return Intl.message(
      'Birth date',
      name: 'birth_date',
      desc: '',
      args: [],
    );
  }

  /// `My Points`
  String get my_points {
    return Intl.message(
      'My Points',
      name: 'my_points',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Updating your profile`
  String get updating_your_profile {
    return Intl.message(
      'Updating your profile',
      name: 'updating_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get updated_successfully {
    return Intl.message(
      'Updated Successfully',
      name: 'updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Adding to Daily Dishes`
  String get add_to_daily_dishes {
    return Intl.message(
      'Adding to Daily Dishes',
      name: 'add_to_daily_dishes',
      desc: '',
      args: [],
    );
  }

  /// `Add Exercise`
  String get add_exercise {
    return Intl.message(
      'Add Exercise',
      name: 'add_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Search Exercise`
  String get search_exercise {
    return Intl.message(
      'Search Exercise',
      name: 'search_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Browse Exercise`
  String get browse_exercise {
    return Intl.message(
      'Browse Exercise',
      name: 'browse_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Browse Food`
  String get browse_food {
    return Intl.message(
      'Browse Food',
      name: 'browse_food',
      desc: '',
      args: [],
    );
  }

  /// `Create New`
  String get create_new {
    return Intl.message(
      'Create New',
      name: 'create_new',
      desc: '',
      args: [],
    );
  }

  /// `Add snack`
  String get add_snack {
    return Intl.message(
      'Add snack',
      name: 'add_snack',
      desc: '',
      args: [],
    );
  }

  /// `Search food`
  String get search_food {
    return Intl.message(
      'Search food',
      name: 'search_food',
      desc: '',
      args: [],
    );
  }

  /// `Add breakfast`
  String get add_breakfast {
    return Intl.message(
      'Add breakfast',
      name: 'add_breakfast',
      desc: '',
      args: [],
    );
  }

  /// `Add dinner`
  String get add_dinner {
    return Intl.message(
      'Add dinner',
      name: 'add_dinner',
      desc: '',
      args: [],
    );
  }

  /// `Add lunch`
  String get add_lunch {
    return Intl.message(
      'Add lunch',
      name: 'add_lunch',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Library`
  String get exercise_library {
    return Intl.message(
      'Exercise Library',
      name: 'exercise_library',
      desc: '',
      args: [],
    );
  }

  /// `Warm up`
  String get warm_up {
    return Intl.message(
      'Warm up',
      name: 'warm_up',
      desc: '',
      args: [],
    );
  }

  /// `Main Workout`
  String get main_workout {
    return Intl.message(
      'Main Workout',
      name: 'main_workout',
      desc: '',
      args: [],
    );
  }

  /// `Cool down`
  String get cool_down {
    return Intl.message(
      'Cool down',
      name: 'cool_down',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Adding to Daily sessions`
  String get add_to_daily_sessions {
    return Intl.message(
      'Adding to Daily sessions',
      name: 'add_to_daily_sessions',
      desc: '',
      args: [],
    );
  }

  /// `No Favorite Dish Found`
  String get no_favorite_dish {
    return Intl.message(
      'No Favorite Dish Found',
      name: 'no_favorite_dish',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message(
      'Food',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Recipe`
  String get recipe {
    return Intl.message(
      'Recipe',
      name: 'recipe',
      desc: '',
      args: [],
    );
  }

  /// `Browse`
  String get browse {
    return Intl.message(
      'Browse',
      name: 'browse',
      desc: '',
      args: [],
    );
  }

  /// `No Dish Found for this category`
  String get no_dish_for_category {
    return Intl.message(
      'No Dish Found for this category',
      name: 'no_dish_for_category',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get upload_image {
    return Intl.message(
      'Upload Image',
      name: 'upload_image',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enter_name {
    return Intl.message(
      'Enter name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Calories`
  String get calories {
    return Intl.message(
      'Calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `Enter Food Calories`
  String get enter_food_calories {
    return Intl.message(
      'Enter Food Calories',
      name: 'enter_food_calories',
      desc: '',
      args: [],
    );
  }

  /// `Created your daily dish`
  String get created_daily_dish {
    return Intl.message(
      'Created your daily dish',
      name: 'created_daily_dish',
      desc: '',
      args: [],
    );
  }

  /// `Live match`
  String get live_match {
    return Intl.message(
      'Live match',
      name: 'live_match',
      desc: '',
      args: [],
    );
  }

  /// `Not Available`
  String get not_available {
    return Intl.message(
      'Not Available',
      name: 'not_available',
      desc: '',
      args: [],
    );
  }

  /// `Stats`
  String get stats {
    return Intl.message(
      'Stats',
      name: 'stats',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Lineup`
  String get lineup {
    return Intl.message(
      'Lineup',
      name: 'lineup',
      desc: '',
      args: [],
    );
  }

  /// `Statistic Not available yet`
  String get stats_not_available {
    return Intl.message(
      'Statistic Not available yet',
      name: 'stats_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Player`
  String get player {
    return Intl.message(
      'Player',
      name: 'player',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Ball Possession`
  String get ball_possession {
    return Intl.message(
      'Ball Possession',
      name: 'ball_possession',
      desc: '',
      args: [],
    );
  }

  /// `Shots on target`
  String get shots_on_target {
    return Intl.message(
      'Shots on target',
      name: 'shots_on_target',
      desc: '',
      args: [],
    );
  }

  /// `Shots off target`
  String get shots_off_target {
    return Intl.message(
      'Shots off target',
      name: 'shots_off_target',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Shots`
  String get blocked_shots {
    return Intl.message(
      'Blocked Shots',
      name: 'blocked_shots',
      desc: '',
      args: [],
    );
  }

  /// `Corner kick`
  String get corner_kick {
    return Intl.message(
      'Corner kick',
      name: 'corner_kick',
      desc: '',
      args: [],
    );
  }

  /// `Fouls`
  String get fouls {
    return Intl.message(
      'Fouls',
      name: 'fouls',
      desc: '',
      args: [],
    );
  }

  /// `Yellow Cards`
  String get yellow_cards {
    return Intl.message(
      'Yellow Cards',
      name: 'yellow_cards',
      desc: '',
      args: [],
    );
  }

  /// `Red Cards`
  String get red_cards {
    return Intl.message(
      'Red Cards',
      name: 'red_cards',
      desc: '',
      args: [],
    );
  }

  /// `Live Matches`
  String get live_matches {
    return Intl.message(
      'Live Matches',
      name: 'live_matches',
      desc: '',
      args: [],
    );
  }

  /// `Today matches`
  String get today_matches {
    return Intl.message(
      'Today matches',
      name: 'today_matches',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Table`
  String get table {
    return Intl.message(
      'Table',
      name: 'table',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get team {
    return Intl.message(
      'Team',
      name: 'team',
      desc: '',
      args: [],
    );
  }

  /// `Standings`
  String get standings {
    return Intl.message(
      'Standings',
      name: 'standings',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Simple show the QR code and \n your friends can scan and tap!`
  String get show_qr_code_message {
    return Intl.message(
      'Simple show the QR code and \n your friends can scan and tap!',
      name: 'show_qr_code_message',
      desc: '',
      args: [],
    );
  }

  /// `you will be added as a friend when your`
  String get add_friend_message1 {
    return Intl.message(
      'you will be added as a friend when your',
      name: 'add_friend_message1',
      desc: '',
      args: [],
    );
  }

  /// `friend scan your QR code .`
  String get add_friend_message2 {
    return Intl.message(
      'friend scan your QR code .',
      name: 'add_friend_message2',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get coming_soon {
    return Intl.message(
      'Coming Soon',
      name: 'coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Nearby people`
  String get nearby_people {
    return Intl.message(
      'Nearby people',
      name: 'nearby_people',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Search Location`
  String get search_location {
    return Intl.message(
      'Search Location',
      name: 'search_location',
      desc: '',
      args: [],
    );
  }

  /// `Nearby mosques`
  String get nearby_mosque {
    return Intl.message(
      'Nearby mosques',
      name: 'nearby_mosque',
      desc: '',
      args: [],
    );
  }

  /// `Search News`
  String get search_news {
    return Intl.message(
      'Search News',
      name: 'search_news',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `payment`
  String get payment {
    return Intl.message(
      'payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Pay With My Wallet`
  String get pay_with_wallet {
    return Intl.message(
      'Pay With My Wallet',
      name: 'pay_with_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Track In Wallet ?`
  String get track_in_wallet {
    return Intl.message(
      'Track In Wallet ?',
      name: 'track_in_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Now`
  String get purchase_now {
    return Intl.message(
      'Purchase Now',
      name: 'purchase_now',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Information`
  String get shipping_information {
    return Intl.message(
      'Shipping Information',
      name: 'shipping_information',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Add Shipping Information`
  String get add_shipping_info {
    return Intl.message(
      'Add Shipping Information',
      name: 'add_shipping_info',
      desc: '',
      args: [],
    );
  }

  /// `Choose Shipping Method`
  String get choose_shipping_method {
    return Intl.message(
      'Choose Shipping Method',
      name: 'choose_shipping_method',
      desc: '',
      args: [],
    );
  }

  /// `Order overview`
  String get order_overview {
    return Intl.message(
      'Order overview',
      name: 'order_overview',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Card not contain enough funds`
  String get card_funds {
    return Intl.message(
      'Card not contain enough funds',
      name: 'card_funds',
      desc: '',
      args: [],
    );
  }

  /// `Card Declined`
  String get card_declined {
    return Intl.message(
      'Card Declined',
      name: 'card_declined',
      desc: '',
      args: [],
    );
  }

  /// `Not Enrolled`
  String get transaction_attempt_failed {
    return Intl.message(
      'Not Enrolled',
      name: 'transaction_attempt_failed',
      desc: '',
      args: [],
    );
  }

  /// `Invalid PIN rejected`
  String get Invalid_PIN_rejected {
    return Intl.message(
      'Invalid PIN rejected',
      name: 'Invalid_PIN_rejected',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `Processing Your Order`
  String get processing_order {
    return Intl.message(
      'Processing Your Order',
      name: 'processing_order',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get successful {
    return Intl.message(
      'Successful',
      name: 'successful',
      desc: '',
      args: [],
    );
  }

  /// `please wait we processing your order now`
  String get processing_order_now {
    return Intl.message(
      'please wait we processing your order now',
      name: 'processing_order_now',
      desc: '',
      args: [],
    );
  }

  /// `My Address`
  String get my_address {
    return Intl.message(
      'My Address',
      name: 'my_address',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Add Other Address`
  String get add_other_address {
    return Intl.message(
      'Add Other Address',
      name: 'add_other_address',
      desc: '',
      args: [],
    );
  }

  /// `Charity`
  String get charity {
    return Intl.message(
      'Charity',
      name: 'charity',
      desc: '',
      args: [],
    );
  }

  /// `Food Delivery`
  String get food_delivery {
    return Intl.message(
      'Food Delivery',
      name: 'food_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Home Services`
  String get home_services {
    return Intl.message(
      'Home Services',
      name: 'home_services',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Booking`
  String get cancel_booking {
    return Intl.message(
      'Cancel Booking',
      name: 'cancel_booking',
      desc: '',
      args: [],
    );
  }

  /// `View Direction`
  String get view_direction {
    return Intl.message(
      'View Direction',
      name: 'view_direction',
      desc: '',
      args: [],
    );
  }

  /// `Services Ordered`
  String get services_ordered {
    return Intl.message(
      'Services Ordered',
      name: 'services_ordered',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Sorting by`
  String get sorting_by {
    return Intl.message(
      'Sorting by',
      name: 'sorting_by',
      desc: '',
      args: [],
    );
  }

  /// `Product Category`
  String get product_category {
    return Intl.message(
      'Product Category',
      name: 'product_category',
      desc: '',
      args: [],
    );
  }

  /// `Successfully added to cart`
  String get successfully_added_to_cart {
    return Intl.message(
      'Successfully added to cart',
      name: 'successfully_added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `View Cart`
  String get view_cart {
    return Intl.message(
      'View Cart',
      name: 'view_cart',
      desc: '',
      args: [],
    );
  }

  /// `other product you might like`
  String get other_products_might_like {
    return Intl.message(
      'other product you might like',
      name: 'other_products_might_like',
      desc: '',
      args: [],
    );
  }

  /// `Most Expensive`
  String get most_expensive {
    return Intl.message(
      'Most Expensive',
      name: 'most_expensive',
      desc: '',
      args: [],
    );
  }

  /// `Lowest Price`
  String get lowest_price {
    return Intl.message(
      'Lowest Price',
      name: 'lowest_price',
      desc: '',
      args: [],
    );
  }

  /// `Store Rating`
  String get store_rating {
    return Intl.message(
      'Store Rating',
      name: 'store_rating',
      desc: '',
      args: [],
    );
  }

  /// `Top Rating`
  String get top_rating {
    return Intl.message(
      'Top Rating',
      name: 'top_rating',
      desc: '',
      args: [],
    );
  }

  /// `Lowest rating`
  String get lowest_rating {
    return Intl.message(
      'Lowest rating',
      name: 'lowest_rating',
      desc: '',
      args: [],
    );
  }

  /// `Modern history`
  String get modern_history {
    return Intl.message(
      'Modern history',
      name: 'modern_history',
      desc: '',
      args: [],
    );
  }

  /// `The newest`
  String get the_newest {
    return Intl.message(
      'The newest',
      name: 'the_newest',
      desc: '',
      args: [],
    );
  }

  /// `The oldest`
  String get the_oldest {
    return Intl.message(
      'The oldest',
      name: 'the_oldest',
      desc: '',
      args: [],
    );
  }

  /// `add note for seller`
  String get add_note_to_seller {
    return Intl.message(
      'add note for seller',
      name: 'add_note_to_seller',
      desc: '',
      args: [],
    );
  }

  /// `Select all items`
  String get select_all_items {
    return Intl.message(
      'Select all items',
      name: 'select_all_items',
      desc: '',
      args: [],
    );
  }

  /// `View By order`
  String get view_by_order {
    return Intl.message(
      'View By order',
      name: 'view_by_order',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shipping`
  String get continue_shipping {
    return Intl.message(
      'Continue Shipping',
      name: 'continue_shipping',
      desc: '',
      args: [],
    );
  }

  /// `Top`
  String get top {
    return Intl.message(
      'Top',
      name: 'top',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting payments`
  String get awaiting_payments {
    return Intl.message(
      'Awaiting payments',
      name: 'awaiting_payments',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting fulfillment`
  String get awaiting_fulfillment {
    return Intl.message(
      'Awaiting fulfillment',
      name: 'awaiting_fulfillment',
      desc: '',
      args: [],
    );
  }

  /// `Shipped`
  String get shipped {
    return Intl.message(
      'Shipped',
      name: 'shipped',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Declined`
  String get declined {
    return Intl.message(
      'Declined',
      name: 'declined',
      desc: '',
      args: [],
    );
  }

  /// `Refunded`
  String get refunded {
    return Intl.message(
      'Refunded',
      name: 'refunded',
      desc: '',
      args: [],
    );
  }

  /// `The image cannot be empty `
  String get image_required {
    return Intl.message(
      'The image cannot be empty ',
      name: 'image_required',
      desc: '',
      args: [],
    );
  }

  /// `top selling`
  String get top_selling {
    return Intl.message(
      'top selling',
      name: 'top_selling',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `Jobs`
  String get jobs {
    return Intl.message(
      'Jobs',
      name: 'jobs',
      desc: '',
      args: [],
    );
  }

  /// `Ticket & Hotel`
  String get ticket_hotel {
    return Intl.message(
      'Ticket & Hotel',
      name: 'ticket_hotel',
      desc: '',
      args: [],
    );
  }

  /// `Party Planner`
  String get party_planner {
    return Intl.message(
      'Party Planner',
      name: 'party_planner',
      desc: '',
      args: [],
    );
  }

  /// `Vision 2030`
  String get vision_2030 {
    return Intl.message(
      'Vision 2030',
      name: 'vision_2030',
      desc: '',
      args: [],
    );
  }

  /// `Check In`
  String get check_in {
    return Intl.message(
      'Check In',
      name: 'check_in',
      desc: '',
      args: [],
    );
  }

  /// `Check In`
  String get check_in_moment {
    return Intl.message(
      'Check In',
      name: 'check_in_moment',
      desc: '',
      args: [],
    );
  }

  /// `at`
  String get at {
    return Intl.message(
      'at',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Friend`
  String get friend {
    return Intl.message(
      'Friend',
      name: 'friend',
      desc: '',
      args: [],
    );
  }

  /// `People Here`
  String get people_here {
    return Intl.message(
      'People Here',
      name: 'people_here',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `Get ticket now`
  String get get_ticket_now {
    return Intl.message(
      'Get ticket now',
      name: 'get_ticket_now',
      desc: '',
      args: [],
    );
  }

  /// `Get ticket on Website`
  String get get_ticket_on_website {
    return Intl.message(
      'Get ticket on Website',
      name: 'get_ticket_on_website',
      desc: '',
      args: [],
    );
  }

  /// `Get ticket`
  String get get_ticket {
    return Intl.message(
      'Get ticket',
      name: 'get_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Enter Private code`
  String get enter_private_code {
    return Intl.message(
      'Enter Private code',
      name: 'enter_private_code',
      desc: '',
      args: [],
    );
  }

  /// `Saved Successfully`
  String get saved_successfully {
    return Intl.message(
      'Saved Successfully',
      name: 'saved_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Select Member`
  String get select_member {
    return Intl.message(
      'Select Member',
      name: 'select_member',
      desc: '',
      args: [],
    );
  }

  /// `members`
  String get members {
    return Intl.message(
      'members',
      name: 'members',
      desc: '',
      args: [],
    );
  }

  /// `Files larger than 5 MB are not allowed`
  String get size_limit_msg {
    return Intl.message(
      'Files larger than 5 MB are not allowed',
      name: 'size_limit_msg',
      desc: '',
      args: [],
    );
  }

  /// `Points`
  String get points {
    return Intl.message(
      'Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to set this image as profile picture?`
  String get update_profile_image_message {
    return Intl.message(
      'Are you sure you want to set this image as profile picture?',
      name: 'update_profile_image_message',
      desc: '',
      args: [],
    );
  }

  /// `Edit My Address`
  String get edit_address {
    return Intl.message(
      'Edit My Address',
      name: 'edit_address',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get address_desc {
    return Intl.message(
      'Description',
      name: 'address_desc',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get address_street {
    return Intl.message(
      'Street',
      name: 'address_street',
      desc: '',
      args: [],
    );
  }

  /// `Please select your city`
  String get select_city_error {
    return Intl.message(
      'Please select your city',
      name: 'select_city_error',
      desc: '',
      args: [],
    );
  }

  /// `Please add street`
  String get street_error {
    return Intl.message(
      'Please add street',
      name: 'street_error',
      desc: '',
      args: [],
    );
  }

  /// `Please add some description`
  String get description_error {
    return Intl.message(
      'Please add some description',
      name: 'description_error',
      desc: '',
      args: [],
    );
  }

  /// `Start Date : `
  String get start_date {
    return Intl.message(
      'Start Date : ',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `End Date :`
  String get end_date {
    return Intl.message(
      'End Date :',
      name: 'end_date',
      desc: '',
      args: [],
    );
  }

  /// `From Hour :`
  String get from_time {
    return Intl.message(
      'From Hour :',
      name: 'from_time',
      desc: '',
      args: [],
    );
  }

  /// `To Hour :`
  String get to_time {
    return Intl.message(
      'To Hour :',
      name: 'to_time',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Poll`
  String get poll {
    return Intl.message(
      'Poll',
      name: 'poll',
      desc: '',
      args: [],
    );
  }

  /// `Share Location`
  String get share_location {
    return Intl.message(
      'Share Location',
      name: 'share_location',
      desc: '',
      args: [],
    );
  }

  /// `Share My Live Location`
  String get share_live_location {
    return Intl.message(
      'Share My Live Location',
      name: 'share_live_location',
      desc: '',
      args: [],
    );
  }

  /// `Send this locations`
  String get send_location {
    return Intl.message(
      'Send this locations',
      name: 'send_location',
      desc: '',
      args: [],
    );
  }

  /// `Cart is empty`
  String get empty_cart_message {
    return Intl.message(
      'Cart is empty',
      name: 'empty_cart_message',
      desc: '',
      args: [],
    );
  }

  /// `CLEAR CART`
  String get clear_cart {
    return Intl.message(
      'CLEAR CART',
      name: 'clear_cart',
      desc: '',
      args: [],
    );
  }

  /// `qun`
  String get quantity_shortcut {
    return Intl.message(
      'qun',
      name: 'quantity_shortcut',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get coupon {
    return Intl.message(
      'Coupon',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Applied successfully`
  String get apply_coupon_success {
    return Intl.message(
      'Coupon Applied successfully',
      name: 'apply_coupon_success',
      desc: '',
      args: [],
    );
  }

  /// `The purchase coupon has not been activated, it belongs to a second store`
  String get apply_coupon_error {
    return Intl.message(
      'The purchase coupon has not been activated, it belongs to a second store',
      name: 'apply_coupon_error',
      desc: '',
      args: [],
    );
  }

  /// `Shop followed successfully`
  String get follow_shop_success {
    return Intl.message(
      'Shop followed successfully',
      name: 'follow_shop_success',
      desc: '',
      args: [],
    );
  }

  /// `Shop un followed successfully`
  String get un_follow_shop_success {
    return Intl.message(
      'Shop un followed successfully',
      name: 'un_follow_shop_success',
      desc: '',
      args: [],
    );
  }

  /// `Un follow`
  String get un_follow {
    return Intl.message(
      'Un follow',
      name: 'un_follow',
      desc: '',
      args: [],
    );
  }

  /// `Review created successfully`
  String get create_review_success {
    return Intl.message(
      'Review created successfully',
      name: 'create_review_success',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get filter_product_price {
    return Intl.message(
      'Price',
      name: 'filter_product_price',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get filter_product_rate {
    return Intl.message(
      'Rate',
      name: 'filter_product_rate',
      desc: '',
      args: [],
    );
  }

  /// `Creation Time`
  String get filter_product_creationTime {
    return Intl.message(
      'Creation Time',
      name: 'filter_product_creationTime',
      desc: '',
      args: [],
    );
  }

  /// `Most Requested`
  String get filter_product_most_requested {
    return Intl.message(
      'Most Requested',
      name: 'filter_product_most_requested',
      desc: '',
      args: [],
    );
  }

  /// `Top Selling`
  String get filter_product_top_selling {
    return Intl.message(
      'Top Selling',
      name: 'filter_product_top_selling',
      desc: '',
      args: [],
    );
  }

  /// `Address added successfully`
  String get success_add_address {
    return Intl.message(
      'Address added successfully',
      name: 'success_add_address',
      desc: '',
      args: [],
    );
  }

  /// `Address updated successfully`
  String get success_update_address {
    return Intl.message(
      'Address updated successfully',
      name: 'success_update_address',
      desc: '',
      args: [],
    );
  }

  /// `Save address as (eg house, apartment etc)`
  String get select_address_type_label {
    return Intl.message(
      'Save address as (eg house, apartment etc)',
      name: 'select_address_type_label',
      desc: '',
      args: [],
    );
  }

  /// `Select Address Type`
  String get select_address_type_hint {
    return Intl.message(
      'Select Address Type',
      name: 'select_address_type_hint',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name_label {
    return Intl.message(
      'Full Name',
      name: 'full_name_label',
      desc: '',
      args: [],
    );
  }

  /// `John Doe`
  String get full_name_hint {
    return Intl.message(
      'John Doe',
      name: 'full_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Street address`
  String get street_address_label {
    return Intl.message(
      'Street address',
      name: 'street_address_label',
      desc: '',
      args: [],
    );
  }

  /// `1060 W Addison St`
  String get street_address_hint {
    return Intl.message(
      '1060 W Addison St',
      name: 'street_address_hint',
      desc: '',
      args: [],
    );
  }

  /// `Apt. Suite, building (opt)`
  String get building_number_label {
    return Intl.message(
      'Apt. Suite, building (opt)',
      name: 'building_number_label',
      desc: '',
      args: [],
    );
  }

  /// `Unit 14`
  String get building_number_hint {
    return Intl.message(
      'Unit 14',
      name: 'building_number_hint',
      desc: '',
      args: [],
    );
  }

  /// `ZIP CODE`
  String get zip_code_label {
    return Intl.message(
      'ZIP CODE',
      name: 'zip_code_label',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city_label {
    return Intl.message(
      'City',
      name: 'city_label',
      desc: '',
      args: [],
    );
  }

  /// `Select City`
  String get city_hint {
    return Intl.message(
      'Select City',
      name: 'city_hint',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number_label {
    return Intl.message(
      'Phone Number',
      name: 'phone_number_label',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get save_address {
    return Intl.message(
      'Save Address',
      name: 'save_address',
      desc: '',
      args: [],
    );
  }

  /// `Apartment`
  String get apartment {
    return Intl.message(
      'Apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `House`
  String get house {
    return Intl.message(
      'House',
      name: 'house',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Image Saved to gallery`
  String get image_saved {
    return Intl.message(
      'Image Saved to gallery',
      name: 'image_saved',
      desc: '',
      args: [],
    );
  }

  /// `Message was not sent`
  String get message_not_sent {
    return Intl.message(
      'Message was not sent',
      name: 'message_not_sent',
      desc: '',
      args: [],
    );
  }

  /// `Allow notifications`
  String get allow_notifications {
    return Intl.message(
      'Allow notifications',
      name: 'allow_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Our app would like to send you notifications`
  String get app_to_send_notifications {
    return Intl.message(
      'Our app would like to send you notifications',
      name: 'app_to_send_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `Don't allow`
  String get do_not_allow {
    return Intl.message(
      'Don\'t allow',
      name: 'do_not_allow',
      desc: '',
      args: [],
    );
  }

  /// `Basboosh`
  String get basboosh {
    return Intl.message(
      'Basboosh',
      name: 'basboosh',
      desc: '',
      args: [],
    );
  }

  /// `Cake`
  String get cack {
    return Intl.message(
      'Cake',
      name: 'cack',
      desc: '',
      args: [],
    );
  }

  /// `Are you a ?`
  String get cake_or_basboosh {
    return Intl.message(
      'Are you a ?',
      name: 'cake_or_basboosh',
      desc: '',
      args: [],
    );
  }

  /// `Welcome `
  String get register_2_desc_part1 {
    return Intl.message(
      'Welcome ',
      name: 'register_2_desc_part1',
      desc: '',
      args: [],
    );
  }

  /// ` , Please Fill your Information here`
  String get register_2_desc_part2 {
    return Intl.message(
      ' , Please Fill your Information here',
      name: 'register_2_desc_part2',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to your private world, far from all the inconveniences and celebrities, here in Mohra you are the important.`
  String get personality_desc {
    return Intl.message(
      'Welcome to your private world, far from all the inconveniences and celebrities, here in Mohra you are the important.',
      name: 'personality_desc',
      desc: '',
      args: [],
    );
  }

  /// `The username, try to make it unique so that people add you easily`
  String get user_name_desc {
    return Intl.message(
      'The username, try to make it unique so that people add you easily',
      name: 'user_name_desc',
      desc: '',
      args: [],
    );
  }

  /// `Advanced Filter`
  String get advanced_filter {
    return Intl.message(
      'Advanced Filter',
      name: 'advanced_filter',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Requests Count`
  String get requests_count {
    return Intl.message(
      'Requests Count',
      name: 'requests_count',
      desc: '',
      args: [],
    );
  }

  /// `Sales Count`
  String get sales_count {
    return Intl.message(
      'Sales Count',
      name: 'sales_count',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Un Block`
  String get un_block {
    return Intl.message(
      'Un Block',
      name: 'un_block',
      desc: '',
      args: [],
    );
  }

  /// `Sport`
  String get sport {
    return Intl.message(
      'Sport',
      name: 'sport',
      desc: '',
      args: [],
    );
  }

  /// `Saudi League`
  String get mbs_league {
    return Intl.message(
      'Saudi League',
      name: 'mbs_league',
      desc: '',
      args: [],
    );
  }

  /// `Saudi League Scores`
  String get mbs_last_scores {
    return Intl.message(
      'Saudi League Scores',
      name: 'mbs_last_scores',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Standing table`
  String get mbs_standing {
    return Intl.message(
      'Saudi Standing table',
      name: 'mbs_standing',
      desc: '',
      args: [],
    );
  }

  /// `EPL League`
  String get epl_league {
    return Intl.message(
      'EPL League',
      name: 'epl_league',
      desc: '',
      args: [],
    );
  }

  /// `EPL League Scores`
  String get epl_last_scores {
    return Intl.message(
      'EPL League Scores',
      name: 'epl_last_scores',
      desc: '',
      args: [],
    );
  }

  /// `EPL  Standing table`
  String get epl_standing {
    return Intl.message(
      'EPL  Standing table',
      name: 'epl_standing',
      desc: '',
      args: [],
    );
  }

  /// `No running events for now`
  String get no_event {
    return Intl.message(
      'No running events for now',
      name: 'no_event',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get order_number {
    return Intl.message(
      'Order Number',
      name: 'order_number',
      desc: '',
      args: [],
    );
  }

  /// `Order Quantity`
  String get order_quantity {
    return Intl.message(
      'Order Quantity',
      name: 'order_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Order Price`
  String get order_price {
    return Intl.message(
      'Order Price',
      name: 'order_price',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get my_addresses {
    return Intl.message(
      'My Addresses',
      name: 'my_addresses',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirm_delete {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirm_delete',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get change_email {
    return Intl.message(
      'Change Email',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Change phone number`
  String get change_phone {
    return Intl.message(
      'Change phone number',
      name: 'change_phone',
      desc: '',
      args: [],
    );
  }

  /// `New Email`
  String get new_email {
    return Intl.message(
      'New Email',
      name: 'new_email',
      desc: '',
      args: [],
    );
  }

  /// `Registered Email`
  String get registered_email {
    return Intl.message(
      'Registered Email',
      name: 'registered_email',
      desc: '',
      args: [],
    );
  }

  /// `Registered Phone Number`
  String get registered_phone {
    return Intl.message(
      'Registered Phone Number',
      name: 'registered_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get enter_verify_code {
    return Intl.message(
      'Enter verification code',
      name: 'enter_verify_code',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent a text message with your verification code to`
  String get code_sent_mobile {
    return Intl.message(
      'We’ve sent a text message with your verification code to',
      name: 'code_sent_mobile',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent an email with your verification code to`
  String get code_sent_email {
    return Intl.message(
      'We’ve sent an email with your verification code to',
      name: 'code_sent_email',
      desc: '',
      args: [],
    );
  }

  /// `Verify email`
  String get verify_email {
    return Intl.message(
      'Verify email',
      name: 'verify_email',
      desc: '',
      args: [],
    );
  }

  /// `Verify Phone`
  String get verify_phone {
    return Intl.message(
      'Verify Phone',
      name: 'verify_phone',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive the email?`
  String get dont_receive_mail {
    return Intl.message(
      'Didn’t receive the email?',
      name: 'dont_receive_mail',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive the message?`
  String get dont_receive_phone {
    return Intl.message(
      'Didn’t receive the message?',
      name: 'dont_receive_phone',
      desc: '',
      args: [],
    );
  }

  /// `Email changed`
  String get email_changed {
    return Intl.message(
      'Email changed',
      name: 'email_changed',
      desc: '',
      args: [],
    );
  }

  /// `Phone changed`
  String get phone_changed {
    return Intl.message(
      'Phone changed',
      name: 'phone_changed',
      desc: '',
      args: [],
    );
  }

  /// `congratulations, your email has been changed`
  String get email_change_success {
    return Intl.message(
      'congratulations, your email has been changed',
      name: 'email_change_success',
      desc: '',
      args: [],
    );
  }

  /// `congratulations, your phone number has been changed`
  String get phone_change_success {
    return Intl.message(
      'congratulations, your phone number has been changed',
      name: 'phone_change_success',
      desc: '',
      args: [],
    );
  }

  /// `Back to setting`
  String get back_to_setting {
    return Intl.message(
      'Back to setting',
      name: 'back_to_setting',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get re_send_code {
    return Intl.message(
      'Resend Code',
      name: 're_send_code',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `Change Name`
  String get change_name {
    return Intl.message(
      'Change Name',
      name: 'change_name',
      desc: '',
      args: [],
    );
  }

  /// `Delete Address ?`
  String get delete_address_title {
    return Intl.message(
      'Delete Address ?',
      name: 'delete_address_title',
      desc: '',
      args: [],
    );
  }

  /// `Address Deleted Successfully`
  String get delete_address_success {
    return Intl.message(
      'Address Deleted Successfully',
      name: 'delete_address_success',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this address? This action cannot be undone.`
  String get delete_address_message {
    return Intl.message(
      'Are you sure you want to delete this address? This action cannot be undone.',
      name: 'delete_address_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete Profile Image`
  String get delete_image_title {
    return Intl.message(
      'Delete Profile Image',
      name: 'delete_image_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your profile image?`
  String get delete_image_message {
    return Intl.message(
      'Are you sure you want to delete your profile image?',
      name: 'delete_image_message',
      desc: '',
      args: [],
    );
  }

  /// `Delete Cover Image`
  String get delete_cover_title {
    return Intl.message(
      'Delete Cover Image',
      name: 'delete_cover_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your Cover image?`
  String get delete_cover_message {
    return Intl.message(
      'Are you sure you want to delete your Cover image?',
      name: 'delete_cover_message',
      desc: '',
      args: [],
    );
  }

  /// `processing your request in background`
  String get processing_in_background {
    return Intl.message(
      'processing your request in background',
      name: 'processing_in_background',
      desc: '',
      args: [],
    );
  }

  /// `You Don\'t have an avatar`
  String get set_avatar_error {
    return Intl.message(
      'You Don\\\'t have an avatar',
      name: 'set_avatar_error',
      desc: '',
      args: [],
    );
  }

  /// `Set Avatar as profile picture`
  String get set_avatar_title {
    return Intl.message(
      'Set Avatar as profile picture',
      name: 'set_avatar_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to Set Avatar as profile picture ?`
  String get set_avatar_message {
    return Intl.message(
      'Are you sure you want to Set Avatar as profile picture ?',
      name: 'set_avatar_message',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online_event {
    return Intl.message(
      'Online',
      name: 'online_event',
      desc: '',
      args: [],
    );
  }

  /// `Local`
  String get local_event {
    return Intl.message(
      'Local',
      name: 'local_event',
      desc: '',
      args: [],
    );
  }

  /// `Event Link will sent to your mail after buy a ticket`
  String get view_on_link {
    return Intl.message(
      'Event Link will sent to your mail after buy a ticket',
      name: 'view_on_link',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get go {
    return Intl.message(
      'Go',
      name: 'go',
      desc: '',
      args: [],
    );
  }

  /// `Muted`
  String get muted {
    return Intl.message(
      'Muted',
      name: 'muted',
      desc: '',
      args: [],
    );
  }

  /// `Will be added soon`
  String get will_be_added_soon {
    return Intl.message(
      'Will be added soon',
      name: 'will_be_added_soon',
      desc: '',
      args: [],
    );
  }

  /// `Cuddly`
  String get cuddly {
    return Intl.message(
      'Cuddly',
      name: 'cuddly',
      desc: '',
      args: [],
    );
  }

  /// `Nasty`
  String get nasty {
    return Intl.message(
      'Nasty',
      name: 'nasty',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, No Moments at the moment`
  String get no_moments_for_now {
    return Intl.message(
      'Sorry, No Moments at the moment',
      name: 'no_moments_for_now',
      desc: '',
      args: [],
    );
  }

  /// `Media,Links & Others`
  String get Media_links_others {
    return Intl.message(
      'Media,Links & Others',
      name: 'Media_links_others',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get events {
    return Intl.message(
      'Events',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Pick Image`
  String get pick_image {
    return Intl.message(
      'Pick Image',
      name: 'pick_image',
      desc: '',
      args: [],
    );
  }

  /// `Sending a confirmation code`
  String get sendingCode {
    return Intl.message(
      'Sending a confirmation code',
      name: 'sendingCode',
      desc: '',
      args: [],
    );
  }

  /// `Checking if Phone Number Available to use`
  String get checkPhoneNumber {
    return Intl.message(
      'Checking if Phone Number Available to use',
      name: 'checkPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Number isn't available`
  String get invalid_number {
    return Intl.message(
      'Number isn\'t available',
      name: 'invalid_number',
      desc: '',
      args: [],
    );
  }

  /// `Challenge Organizer`
  String get challenge_organizer {
    return Intl.message(
      'Challenge Organizer',
      name: 'challenge_organizer',
      desc: '',
      args: [],
    );
  }

  /// `reward after join the challenge`
  String get reward_join_challenge {
    return Intl.message(
      'reward after join the challenge',
      name: 'reward_join_challenge',
      desc: '',
      args: [],
    );
  }

  /// `How To Complete The Challenge ?`
  String get how_complete_cha {
    return Intl.message(
      'How To Complete The Challenge ?',
      name: 'how_complete_cha',
      desc: '',
      args: [],
    );
  }

  /// `Follow this step to complete the challenge and get your rewards`
  String get how_complete_cha_desc {
    return Intl.message(
      'Follow this step to complete the challenge and get your rewards',
      name: 'how_complete_cha_desc',
      desc: '',
      args: [],
    );
  }

  /// `Join The Challenge`
  String get join_challenge {
    return Intl.message(
      'Join The Challenge',
      name: 'join_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Invite your friends to join`
  String get invite_friend_to_cha {
    return Intl.message(
      'Invite your friends to join',
      name: 'invite_friend_to_cha',
      desc: '',
      args: [],
    );
  }

  /// `Make the challenge more impactfull by inviting your friends and get extra rewards , minimum is`
  String get invite_friend_to_cha_des {
    return Intl.message(
      'Make the challenge more impactfull by inviting your friends and get extra rewards , minimum is',
      name: 'invite_friend_to_cha_des',
      desc: '',
      args: [],
    );
  }

  /// `Go to the event`
  String get go_to_event {
    return Intl.message(
      'Go to the event',
      name: 'go_to_event',
      desc: '',
      args: [],
    );
  }

  /// `Go to the event locations, use the button bellow to verivy you was there`
  String get go_to_event_des {
    return Intl.message(
      'Go to the event locations, use the button bellow to verivy you was there',
      name: 'go_to_event_des',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Claim your reward`
  String get claim_cha_reward {
    return Intl.message(
      'Claim your reward',
      name: 'claim_cha_reward',
      desc: '',
      args: [],
    );
  }

  /// `Claim My Rewards`
  String get claim_my_reward {
    return Intl.message(
      'Claim My Rewards',
      name: 'claim_my_reward',
      desc: '',
      args: [],
    );
  }

  /// `Once you complete all the step aboove our system will verify your activity and send the rewards to your points wallet`
  String get claim_cha_reward_des {
    return Intl.message(
      'Once you complete all the step aboove our system will verify your activity and send the rewards to your points wallet',
      name: 'claim_cha_reward_des',
      desc: '',
      args: [],
    );
  }

  /// `Already joined`
  String get already_joined {
    return Intl.message(
      'Already joined',
      name: 'already_joined',
      desc: '',
      args: [],
    );
  }

  /// `Leave Challenge`
  String get leave_cha {
    return Intl.message(
      'Leave Challenge',
      name: 'leave_cha',
      desc: '',
      args: [],
    );
  }

  /// `Take all negative words out of your mental dictionary and focus on solutions with utmost conviction and patience`
  String get positivity_desc_hint {
    return Intl.message(
      'Take all negative words out of your mental dictionary and focus on solutions with utmost conviction and patience',
      name: 'positivity_desc_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please select date and time`
  String get my_life_appointment_date_time_validation {
    return Intl.message(
      'Please select date and time',
      name: 'my_life_appointment_date_time_validation',
      desc: '',
      args: [],
    );
  }

  /// `please select a priority`
  String get my_life_appointment_priority_validation {
    return Intl.message(
      'please select a priority',
      name: 'my_life_appointment_priority_validation',
      desc: '',
      args: [],
    );
  }

  /// `Please write a title`
  String get my_life_appointment_title_validation {
    return Intl.message(
      'Please write a title',
      name: 'my_life_appointment_title_validation',
      desc: '',
      args: [],
    );
  }

  /// `Please select a reminder`
  String get my_life_appointment_reminder_validation {
    return Intl.message(
      'Please select a reminder',
      name: 'my_life_appointment_reminder_validation',
      desc: '',
      args: [],
    );
  }

  /// `Please select The Repeat Mode`
  String get my_life_appointment_repeat_mode_validation {
    return Intl.message(
      'Please select The Repeat Mode',
      name: 'my_life_appointment_repeat_mode_validation',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error, Try Later`
  String get my_life_appointment_unknown_validation {
    return Intl.message(
      'Unknown Error, Try Later',
      name: 'my_life_appointment_unknown_validation',
      desc: '',
      args: [],
    );
  }

  /// `Reason`
  String get reason {
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }

  /// `Post was deleted successfully`
  String get post_was_deleted_successfully {
    return Intl.message(
      'Post was deleted successfully',
      name: 'post_was_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Post was reported successfully`
  String get post_was_reported_successfully {
    return Intl.message(
      'Post was reported successfully',
      name: 'post_was_reported_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Example`
  String get example {
    return Intl.message(
      'Example',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `Your birthday so we can celebrate it with you`
  String get register_birth_date_title {
    return Intl.message(
      'Your birthday so we can celebrate it with you',
      name: 'register_birth_date_title',
      desc: '',
      args: [],
    );
  }

  /// `Cake`
  String get the_cake {
    return Intl.message(
      'Cake',
      name: 'the_cake',
      desc: '',
      args: [],
    );
  }

  /// `Basboosh`
  String get the_basboosh {
    return Intl.message(
      'Basboosh',
      name: 'the_basboosh',
      desc: '',
      args: [],
    );
  }

  /// `Mohra ID (username), try to make it unique`
  String get user_name_desc1 {
    return Intl.message(
      'Mohra ID (username), try to make it unique',
      name: 'user_name_desc1',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Specifications`
  String get specifications {
    return Intl.message(
      'Specifications',
      name: 'specifications',
      desc: '',
      args: [],
    );
  }

  /// `so that people add you easily`
  String get user_name_desc2 {
    return Intl.message(
      'so that people add you easily',
      name: 'user_name_desc2',
      desc: '',
      args: [],
    );
  }

  /// `password should be at least of 8 length`
  String get password_field_validation_error1 {
    return Intl.message(
      'password should be at least of 8 length',
      name: 'password_field_validation_error1',
      desc: '',
      args: [],
    );
  }

  /// `Password should contain at least one number and one letter`
  String get password_field_validation_error2 {
    return Intl.message(
      'Password should contain at least one number and one letter',
      name: 'password_field_validation_error2',
      desc: '',
      args: [],
    );
  }

  /// `Checking Personality`
  String get checking_personality {
    return Intl.message(
      'Checking Personality',
      name: 'checking_personality',
      desc: '',
      args: [],
    );
  }

  /// `Check If Phone Number Valid`
  String get checking_phone_number {
    return Intl.message(
      'Check If Phone Number Valid',
      name: 'checking_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Check If Email is Valid`
  String get checking_email {
    return Intl.message(
      'Check If Email is Valid',
      name: 'checking_email',
      desc: '',
      args: [],
    );
  }

  /// `The Code you have entered is wrong`
  String get invalid_verification_code {
    return Intl.message(
      'The Code you have entered is wrong',
      name: 'invalid_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Please tell us why you want to delete your account?`
  String get delete_account_reason {
    return Intl.message(
      'Please tell us why you want to delete your account?',
      name: 'delete_account_reason',
      desc: '',
      args: [],
    );
  }

  /// `Something was broken`
  String get something_broken {
    return Intl.message(
      'Something was broken',
      name: 'something_broken',
      desc: '',
      args: [],
    );
  }

  /// `I have privacy concern`
  String get privacy_concern {
    return Intl.message(
      'I have privacy concern',
      name: 'privacy_concern',
      desc: '',
      args: [],
    );
  }

  /// `I’m not getting any friends`
  String get no_friends {
    return Intl.message(
      'I’m not getting any friends',
      name: 'no_friends',
      desc: '',
      args: [],
    );
  }

  /// `I don't like it`
  String get dont_like_it {
    return Intl.message(
      'I don\'t like it',
      name: 'dont_like_it',
      desc: '',
      args: [],
    );
  }

  /// `I prefer not to answer`
  String get prefer_not_to_answer {
    return Intl.message(
      'I prefer not to answer',
      name: 'prefer_not_to_answer',
      desc: '',
      args: [],
    );
  }

  /// `Can you share to us what was not working?`
  String get why_not_working {
    return Intl.message(
      'Can you share to us what was not working?',
      name: 'why_not_working',
      desc: '',
      args: [],
    );
  }

  /// `Your explanation is entirely optional`
  String get explanation_optional {
    return Intl.message(
      'Your explanation is entirely optional',
      name: 'explanation_optional',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password to delete account`
  String get password_confirm {
    return Intl.message(
      'Enter your password to delete account',
      name: 'password_confirm',
      desc: '',
      args: [],
    );
  }

  /// `We will permanently delete your mohra data, contacts, messages info and other related data`
  String get delete_confirm {
    return Intl.message(
      'We will permanently delete your mohra data, contacts, messages info and other related data',
      name: 'delete_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Check If Mohra ID (username) is unique and valid`
  String get checking_user_name {
    return Intl.message(
      'Check If Mohra ID (username) is unique and valid',
      name: 'checking_user_name',
      desc: '',
      args: [],
    );
  }

  /// `Edit Birth Date`
  String get edit_birth_date {
    return Intl.message(
      'Edit Birth Date',
      name: 'edit_birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Select Date First`
  String get select_date_first {
    return Intl.message(
      'Select Date First',
      name: 'select_date_first',
      desc: '',
      args: [],
    );
  }

  /// `First Name must be 20 chars at most`
  String get first_name_validator {
    return Intl.message(
      'First Name must be 20 chars at most',
      name: 'first_name_validator',
      desc: '',
      args: [],
    );
  }

  /// `Last Name must be 20 chars at most`
  String get last_name_validator {
    return Intl.message(
      'Last Name must be 20 chars at most',
      name: 'last_name_validator',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number not belong to any user`
  String get phone_not_exist {
    return Intl.message(
      'Phone Number not belong to any user',
      name: 'phone_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Add New`
  String get add_new {
    return Intl.message(
      'Add New',
      name: 'add_new',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select_address {
    return Intl.message(
      'Select',
      name: 'select_address',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected_address {
    return Intl.message(
      'Selected',
      name: 'selected_address',
      desc: '',
      args: [],
    );
  }

  /// `Setting new default address`
  String get change_selected_address {
    return Intl.message(
      'Setting new default address',
      name: 'change_selected_address',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Private Account`
  String get private_account {
    return Intl.message(
      'Private Account',
      name: 'private_account',
      desc: '',
      args: [],
    );
  }

  /// `Allow Friend Requests`
  String get allow_friend_requests {
    return Intl.message(
      'Allow Friend Requests',
      name: 'allow_friend_requests',
      desc: '',
      args: [],
    );
  }

  /// `Group Requests`
  String get Group_requests {
    return Intl.message(
      'Group Requests',
      name: 'Group_requests',
      desc: '',
      args: [],
    );
  }

  /// `Hide My Location`
  String get hide_my_location {
    return Intl.message(
      'Hide My Location',
      name: 'hide_my_location',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Accounts`
  String get blocked_accounts {
    return Intl.message(
      'Blocked Accounts',
      name: 'blocked_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Muted Accounts`
  String get muted_accounts {
    return Intl.message(
      'Muted Accounts',
      name: 'muted_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Public`
  String get public {
    return Intl.message(
      'Public',
      name: 'public',
      desc: '',
      args: [],
    );
  }

  /// `Only Me`
  String get only_me {
    return Intl.message(
      'Only Me',
      name: 'only_me',
      desc: '',
      args: [],
    );
  }

  /// `Only Friends`
  String get only_friends {
    return Intl.message(
      'Only Friends',
      name: 'only_friends',
      desc: '',
      args: [],
    );
  }

  /// `Everyone can see your moments`
  String get public_moments_desc {
    return Intl.message(
      'Everyone can see your moments',
      name: 'public_moments_desc',
      desc: '',
      args: [],
    );
  }

  /// `Everyone can see your comments`
  String get public_comments_desc {
    return Intl.message(
      'Everyone can see your comments',
      name: 'public_comments_desc',
      desc: '',
      args: [],
    );
  }

  /// `Interactions`
  String get interactions {
    return Intl.message(
      'Interactions',
      name: 'interactions',
      desc: '',
      args: [],
    );
  }

  /// `Communications`
  String get communications {
    return Intl.message(
      'Communications',
      name: 'communications',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get help_center {
    return Intl.message(
      'Help Center',
      name: 'help_center',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message(
      'Contact Us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about_us {
    return Intl.message(
      'About Us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number is invalid`
  String get invalid_phone_number_firebase {
    return Intl.message(
      'Phone Number is invalid',
      name: 'invalid_phone_number_firebase',
      desc: '',
      args: [],
    );
  }

  /// `Verification code can't be empty`
  String get code_empty {
    return Intl.message(
      'Verification code can\'t be empty',
      name: 'code_empty',
      desc: '',
      args: [],
    );
  }

  /// `Verification code must be 6 numbers`
  String get code_too_short {
    return Intl.message(
      'Verification code must be 6 numbers',
      name: 'code_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Un Mute`
  String get un_mute {
    return Intl.message(
      'Un Mute',
      name: 'un_mute',
      desc: '',
      args: [],
    );
  }

  /// `First Question about gender is required`
  String get answer_all_personality_question {
    return Intl.message(
      'First Question about gender is required',
      name: 'answer_all_personality_question',
      desc: '',
      args: [],
    );
  }

  /// `Friend Added successfully`
  String get friend_added_successfully {
    return Intl.message(
      'Friend Added successfully',
      name: 'friend_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Adding friend ...`
  String get friend_added_in_progress {
    return Intl.message(
      'Adding friend ...',
      name: 'friend_added_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Add New exercise`
  String get add_new_exercise {
    return Intl.message(
      'Add New exercise',
      name: 'add_new_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Enter Food Carbs value`
  String get enter_carbs {
    return Intl.message(
      'Enter Food Carbs value',
      name: 'enter_carbs',
      desc: '',
      args: [],
    );
  }

  /// `Enter Food Fat value`
  String get enter_fats {
    return Intl.message(
      'Enter Food Fat value',
      name: 'enter_fats',
      desc: '',
      args: [],
    );
  }

  /// `Enter Food Protein value`
  String get enter_protein {
    return Intl.message(
      'Enter Food Protein value',
      name: 'enter_protein',
      desc: '',
      args: [],
    );
  }

  /// `( Optional )`
  String get optional {
    return Intl.message(
      '( Optional )',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Created Successfully`
  String get ticket_created_success {
    return Intl.message(
      'Ticket Created Successfully',
      name: 'ticket_created_success',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Sedentary (little or no exercise) `
  String get sedentary_level {
    return Intl.message(
      'Sedentary (little or no exercise) ',
      name: 'sedentary_level',
      desc: '',
      args: [],
    );
  }

  /// `Lightly active (exercise 1–3 days/week)`
  String get lightly_level {
    return Intl.message(
      'Lightly active (exercise 1–3 days/week)',
      name: 'lightly_level',
      desc: '',
      args: [],
    );
  }

  /// `Moderately active (exercise 3–5 days/week)`
  String get moderately_level {
    return Intl.message(
      'Moderately active (exercise 3–5 days/week)',
      name: 'moderately_level',
      desc: '',
      args: [],
    );
  }

  /// `Active (exercise 6–7 days/week)`
  String get active_level {
    return Intl.message(
      'Active (exercise 6–7 days/week)',
      name: 'active_level',
      desc: '',
      args: [],
    );
  }

  /// `Very active (hard exercise 6–7 days/week`
  String get very_active_level {
    return Intl.message(
      'Very active (hard exercise 6–7 days/week',
      name: 'very_active_level',
      desc: '',
      args: [],
    );
  }

  /// `Select your activity level`
  String get select_activity_level {
    return Intl.message(
      'Select your activity level',
      name: 'select_activity_level',
      desc: '',
      args: [],
    );
  }

  /// `Help us tracking your health situation`
  String get select_activity_level_desc {
    return Intl.message(
      'Help us tracking your health situation',
      name: 'select_activity_level_desc',
      desc: '',
      args: [],
    );
  }

  /// `Eat`
  String get eat_stepper_1 {
    return Intl.message(
      'Eat',
      name: 'eat_stepper_1',
      desc: '',
      args: [],
    );
  }

  /// `Calories everyday`
  String get eat_stepper_2 {
    return Intl.message(
      'Calories everyday',
      name: 'eat_stepper_2',
      desc: '',
      args: [],
    );
  }

  /// `Drink`
  String get drink_stepper_1 {
    return Intl.message(
      'Drink',
      name: 'drink_stepper_1',
      desc: '',
      args: [],
    );
  }

  /// `Glass of water everyday`
  String get drink_stepper_2 {
    return Intl.message(
      'Glass of water everyday',
      name: 'drink_stepper_2',
      desc: '',
      args: [],
    );
  }

  /// `Walk`
  String get walk_stepper_1 {
    return Intl.message(
      'Walk',
      name: 'walk_stepper_1',
      desc: '',
      args: [],
    );
  }

  /// `Step everyday`
  String get walk_stepper_2 {
    return Intl.message(
      'Step everyday',
      name: 'walk_stepper_2',
      desc: '',
      args: [],
    );
  }

  /// `Burn`
  String get burn_stepper_1 {
    return Intl.message(
      'Burn',
      name: 'burn_stepper_1',
      desc: '',
      args: [],
    );
  }

  /// `Calories everyday`
  String get burn_stepper_2 {
    return Intl.message(
      'Calories everyday',
      name: 'burn_stepper_2',
      desc: '',
      args: [],
    );
  }

  /// `Required calories for this day`
  String get day_calories_desc {
    return Intl.message(
      'Required calories for this day',
      name: 'day_calories_desc',
      desc: '',
      args: [],
    );
  }

  /// `Please Install google fit to let us track your steps everyday`
  String get google_fit_not_installed {
    return Intl.message(
      'Please Install google fit to let us track your steps everyday',
      name: 'google_fit_not_installed',
      desc: '',
      args: [],
    );
  }

  /// `Name of dish is required`
  String get name_is_required {
    return Intl.message(
      'Name of dish is required',
      name: 'name_is_required',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days2 {
    return Intl.message(
      'Days',
      name: 'days2',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours2 {
    return Intl.message(
      'Hours',
      name: 'hours2',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes2 {
    return Intl.message(
      'Minutes',
      name: 'minutes2',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Countdown`
  String get countdown {
    return Intl.message(
      'Countdown',
      name: 'countdown',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get input_your_date {
    return Intl.message(
      'Select Date',
      name: 'input_your_date',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get input_your_time {
    return Intl.message(
      'Select Time',
      name: 'input_your_time',
      desc: '',
      args: [],
    );
  }

  /// `Add your important events, swipe to delete or click to edit`
  String get swipe_card_to_delete {
    return Intl.message(
      'Add your important events, swipe to delete or click to edit',
      name: 'swipe_card_to_delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Event?`
  String get confirm_delete_countdown {
    return Intl.message(
      'Are you sure you want to delete this Event?',
      name: 'confirm_delete_countdown',
      desc: '',
      args: [],
    );
  }

  /// `Edit Event`
  String get edit_event {
    return Intl.message(
      'Edit Event',
      name: 'edit_event',
      desc: '',
      args: [],
    );
  }

  /// `Add Event`
  String get add_event {
    return Intl.message(
      'Add Event',
      name: 'add_event',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `write your event title here`
  String get event_title_hint {
    return Intl.message(
      'write your event title here',
      name: 'event_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `This Event is not related to you`
  String get cant_delete_event {
    return Intl.message(
      'This Event is not related to you',
      name: 'cant_delete_event',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order_2 {
    return Intl.message(
      'Order',
      name: 'order_2',
      desc: '',
      args: [],
    );
  }

  /// `Session Expired`
  String get session_expired {
    return Intl.message(
      'Session Expired',
      name: 'session_expired',
      desc: '',
      args: [],
    );
  }

  /// `As everyone wants to help to build a great country for all of us in this part, what we aim to do is to anyone who’s excited and wants to help us to the future THIS the right place.`
  String get vision_desc_1 {
    return Intl.message(
      'As everyone wants to help to build a great country for all of us in this part, what we aim to do is to anyone who’s excited and wants to help us to the future THIS the right place.',
      name: 'vision_desc_1',
      desc: '',
      args: [],
    );
  }

  /// `And for government entities if you have any initiative the individuals can participate please don’t hesitate contacting us in here:`
  String get vision_desc_2 {
    return Intl.message(
      'And for government entities if you have any initiative the individuals can participate please don’t hesitate contacting us in here:',
      name: 'vision_desc_2',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get free {
    return Intl.message(
      'Free',
      name: 'free',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `Accept the terms and conditions to proceed`
  String get Accept_the_terms_and_conditions_to_proceed {
    return Intl.message(
      'Accept the terms and conditions to proceed',
      name: 'Accept_the_terms_and_conditions_to_proceed',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get Privacy_Policy {
    return Intl.message(
      'Privacy Policy',
      name: 'Privacy_Policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms Of Use`
  String get TermsOfUse {
    return Intl.message(
      'Terms Of Use',
      name: 'TermsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `LAST PICK`
  String get LAST_PICK {
    return Intl.message(
      'LAST PICK',
      name: 'LAST_PICK',
      desc: '',
      args: [],
    );
  }

  /// `Share my character`
  String get Share_my_character {
    return Intl.message(
      'Share my character',
      name: 'Share_my_character',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications`
  String get Delete_all_notifications {
    return Intl.message(
      'Delete all notifications',
      name: 'Delete_all_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Change Profile Photo`
  String get Change_Profile_Photo {
    return Intl.message(
      'Change Profile Photo',
      name: 'Change_Profile_Photo',
      desc: '',
      args: [],
    );
  }

  /// `Open Camera`
  String get Open_Camera {
    return Intl.message(
      'Open Camera',
      name: 'Open_Camera',
      desc: '',
      args: [],
    );
  }

  /// `Open Gallery`
  String get Open_Gallery {
    return Intl.message(
      'Open Gallery',
      name: 'Open_Gallery',
      desc: '',
      args: [],
    );
  }

  /// `Use Avatar`
  String get Use_Avatar {
    return Intl.message(
      'Use Avatar',
      name: 'Use_Avatar',
      desc: '',
      args: [],
    );
  }

  /// `Delete Profile Image`
  String get Delete_Profile_Image {
    return Intl.message(
      'Delete Profile Image',
      name: 'Delete_Profile_Image',
      desc: '',
      args: [],
    );
  }

  /// `STEP TO REACH GOAL`
  String get STEP_TO_REACH_GOAL {
    return Intl.message(
      'STEP TO REACH GOAL',
      name: 'STEP_TO_REACH_GOAL',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get of_of {
    return Intl.message(
      'of',
      name: 'of_of',
      desc: '',
      args: [],
    );
  }

  /// `Upload a picture of the dish`
  String get Upload_a_picture_of_the_dish {
    return Intl.message(
      'Upload a picture of the dish',
      name: 'Upload_a_picture_of_the_dish',
      desc: '',
      args: [],
    );
  }

  /// `Create Simple Calories`
  String get Create_Simple_Calories {
    return Intl.message(
      'Create Simple Calories',
      name: 'Create_Simple_Calories',
      desc: '',
      args: [],
    );
  }

  /// `Create Food`
  String get Create_Food {
    return Intl.message(
      'Create Food',
      name: 'Create_Food',
      desc: '',
      args: [],
    );
  }

  /// `Create Recipe`
  String get Create_Recipe {
    return Intl.message(
      'Create Recipe',
      name: 'Create_Recipe',
      desc: '',
      args: [],
    );
  }

  /// `Create Meal`
  String get Create_Meal {
    return Intl.message(
      'Create Meal',
      name: 'Create_Meal',
      desc: '',
      args: [],
    );
  }

  /// `Change Cover Photo`
  String get Change_Cover_Photo {
    return Intl.message(
      'Change Cover Photo',
      name: 'Change_Cover_Photo',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get personal {
    return Intl.message(
      'Personal',
      name: 'personal',
      desc: '',
      args: [],
    );
  }

  /// `The weight must be real, not imaginary`
  String get The_weight_must_be_real_not_imaginary {
    return Intl.message(
      'The weight must be real, not imaginary',
      name: 'The_weight_must_be_real_not_imaginary',
      desc: '',
      args: [],
    );
  }

  /// `The height must be real not imaginary`
  String get The_height_must_be_real_not_imaginary {
    return Intl.message(
      'The height must be real not imaginary',
      name: 'The_height_must_be_real_not_imaginary',
      desc: '',
      args: [],
    );
  }

  /// `A blank report cannot be added`
  String get A_blank_report_cannot_be_added {
    return Intl.message(
      'A blank report cannot be added',
      name: 'A_blank_report_cannot_be_added',
      desc: '',
      args: [],
    );
  }

  /// `The report has been added successfully`
  String get The_report_has_been_added_successfully {
    return Intl.message(
      'The report has been added successfully',
      name: 'The_report_has_been_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred when adding the report`
  String get An_error_occurred_when_adding_the_report {
    return Intl.message(
      'An error occurred when adding the report',
      name: 'An_error_occurred_when_adding_the_report',
      desc: '',
      args: [],
    );
  }

  /// `Mohra Team`
  String get Mohra_Team {
    return Intl.message(
      'Mohra Team',
      name: 'Mohra_Team',
      desc: '',
      args: [],
    );
  }

  /// `No messages here yet...`
  String get No_messages_here_yet {
    return Intl.message(
      'No messages here yet...',
      name: 'No_messages_here_yet',
      desc: '',
      args: [],
    );
  }

  /// `Send a message`
  String get Send_a_message {
    return Intl.message(
      'Send a message',
      name: 'Send_a_message',
      desc: '',
      args: [],
    );
  }

  /// `Send a welcome message`
  String get Send_a_welcome_message {
    return Intl.message(
      'Send a welcome message',
      name: 'Send_a_welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `There are no conversations here yet...`
  String get There_are_no_conversations_here_yet {
    return Intl.message(
      'There are no conversations here yet...',
      name: 'There_are_no_conversations_here_yet',
      desc: '',
      args: [],
    );
  }

  /// `There are no groups here yet...`
  String get There_are_no_groups_here_yet {
    return Intl.message(
      'There are no groups here yet...',
      name: 'There_are_no_groups_here_yet',
      desc: '',
      args: [],
    );
  }

  /// `Start chatting with my friends`
  String get Start_chatting_with_my_friends {
    return Intl.message(
      'Start chatting with my friends',
      name: 'Start_chatting_with_my_friends',
      desc: '',
      args: [],
    );
  }

  /// `Create a new group`
  String get Create_a_new_group {
    return Intl.message(
      'Create a new group',
      name: 'Create_a_new_group',
      desc: '',
      args: [],
    );
  }

  /// `Create a new one`
  String get Create_a_new_one {
    return Intl.message(
      'Create a new one',
      name: 'Create_a_new_one',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Already your friend`
  String get already_your_friend {
    return Intl.message(
      'Already your friend',
      name: 'already_your_friend',
      desc: '',
      args: [],
    );
  }

  /// `Helle all`
  String get Helle_all {
    return Intl.message(
      'Helle all',
      name: 'Helle_all',
      desc: '',
      args: [],
    );
  }

  /// `Create Group`
  String get Create_Group {
    return Intl.message(
      'Create Group',
      name: 'Create_Group',
      desc: '',
      args: [],
    );
  }

  /// `Friend request declined`
  String get Friend_request_declined {
    return Intl.message(
      'Friend request declined',
      name: 'Friend_request_declined',
      desc: '',
      args: [],
    );
  }

  /// `Latest Events`
  String get Latest_Events {
    return Intl.message(
      'Latest Events',
      name: 'Latest_Events',
      desc: '',
      args: [],
    );
  }

  /// `Oldest Events`
  String get Oldest_Events {
    return Intl.message(
      'Oldest Events',
      name: 'Oldest_Events',
      desc: '',
      args: [],
    );
  }

  /// `Name: A-Z`
  String get Name_A_Z {
    return Intl.message(
      'Name: A-Z',
      name: 'Name_A_Z',
      desc: '',
      args: [],
    );
  }

  /// `Name: Z-A`
  String get Name_Z_A {
    return Intl.message(
      'Name: Z-A',
      name: 'Name_Z_A',
      desc: '',
      args: [],
    );
  }

  /// `Attendees: High to Low`
  String get Attendees_High_to_Low {
    return Intl.message(
      'Attendees: High to Low',
      name: 'Attendees_High_to_Low',
      desc: '',
      args: [],
    );
  }

  /// `Attendees: Low to High`
  String get Attendees_Low_to_High {
    return Intl.message(
      'Attendees: Low to High',
      name: 'Attendees_Low_to_High',
      desc: '',
      args: [],
    );
  }

  /// `Sort event by`
  String get Sort_event_by {
    return Intl.message(
      'Sort event by',
      name: 'Sort_event_by',
      desc: '',
      args: [],
    );
  }

  /// `Event Filter`
  String get Event_Filter {
    return Intl.message(
      'Event Filter',
      name: 'Event_Filter',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get Location {
    return Intl.message(
      'Location',
      name: 'Location',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Type`
  String get Ticket_Type {
    return Intl.message(
      'Ticket Type',
      name: 'Ticket_Type',
      desc: '',
      args: [],
    );
  }

  /// `Event Category`
  String get Event_Category {
    return Intl.message(
      'Event Category',
      name: 'Event_Category',
      desc: '',
      args: [],
    );
  }

  /// `Event Date`
  String get Event_Date {
    return Intl.message(
      'Event Date',
      name: 'Event_Date',
      desc: '',
      args: [],
    );
  }

  /// `Multi Day`
  String get Multi_Day {
    return Intl.message(
      'Multi Day',
      name: 'Multi_Day',
      desc: '',
      args: [],
    );
  }

  /// `Single Day`
  String get Single_Day {
    return Intl.message(
      'Single Day',
      name: 'Single_Day',
      desc: '',
      args: [],
    );
  }

  /// `A friend request has been sent`
  String get A_friend_request_has_been_sent {
    return Intl.message(
      'A friend request has been sent',
      name: 'A_friend_request_has_been_sent',
      desc: '',
      args: [],
    );
  }

  /// `Attendance`
  String get Attendance {
    return Intl.message(
      'Attendance',
      name: 'Attendance',
      desc: '',
      args: [],
    );
  }

  /// `Attendees Info`
  String get Attendees_Info {
    return Intl.message(
      'Attendees Info',
      name: 'Attendees_Info',
      desc: '',
      args: [],
    );
  }

  /// `Total Ticket`
  String get Total_Ticket {
    return Intl.message(
      'Total Ticket',
      name: 'Total_Ticket',
      desc: '',
      args: [],
    );
  }

  /// `Checked-In`
  String get Checked_In {
    return Intl.message(
      'Checked-In',
      name: 'Checked_In',
      desc: '',
      args: [],
    );
  }

  /// `Check-In`
  String get Check_In {
    return Intl.message(
      'Check-In',
      name: 'Check_In',
      desc: '',
      args: [],
    );
  }

  /// `Not Checked In`
  String get Not_Checked_In {
    return Intl.message(
      'Not Checked In',
      name: 'Not_Checked_In',
      desc: '',
      args: [],
    );
  }

  /// `Price: high to low`
  String get Price_high_to_low {
    return Intl.message(
      'Price: high to low',
      name: 'Price_high_to_low',
      desc: '',
      args: [],
    );
  }

  /// `Price: low to high`
  String get Price_low_to_high {
    return Intl.message(
      'Price: low to high',
      name: 'Price_low_to_high',
      desc: '',
      args: [],
    );
  }

  /// `Booking ID`
  String get Booking_ID {
    return Intl.message(
      'Booking ID',
      name: 'Booking_ID',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Number`
  String get Ticket_Number {
    return Intl.message(
      'Ticket Number',
      name: 'Ticket_Number',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Scanning Ticket ...`
  String get Scanning_Ticket {
    return Intl.message(
      'Scanning Ticket ...',
      name: 'Scanning_Ticket',
      desc: '',
      args: [],
    );
  }

  /// `Scan Ticket`
  String get Scan_Ticket {
    return Intl.message(
      'Scan Ticket',
      name: 'Scan_Ticket',
      desc: '',
      args: [],
    );
  }

  /// `Code scanned successfully..`
  String get code_scanned_successfully {
    return Intl.message(
      'Code scanned successfully..',
      name: 'code_scanned_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Code scanned error..`
  String get code_scanned_error {
    return Intl.message(
      'Code scanned error..',
      name: 'code_scanned_error',
      desc: '',
      args: [],
    );
  }

  /// `CheckIn Status`
  String get CheckIn_Status {
    return Intl.message(
      'CheckIn Status',
      name: 'CheckIn_Status',
      desc: '',
      args: [],
    );
  }

  /// `Filter attendees`
  String get Filter_attendees {
    return Intl.message(
      'Filter attendees',
      name: 'Filter_attendees',
      desc: '',
      args: [],
    );
  }

  /// `IsScanned`
  String get IsScanned {
    return Intl.message(
      'IsScanned',
      name: 'IsScanned',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get Terms_and_Conditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'Terms_and_Conditions',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get SAR {
    return Intl.message(
      'SAR',
      name: 'SAR',
      desc: '',
      args: [],
    );
  }

  /// `Place name`
  String get place_name {
    return Intl.message(
      'Place name',
      name: 'place_name',
      desc: '',
      args: [],
    );
  }

  /// `back`
  String get back {
    return Intl.message(
      'back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't get your location :(`
  String get Could_not_get_your_location {
    return Intl.message(
      'Couldn\'t get your location :(',
      name: 'Could_not_get_your_location',
      desc: '',
      args: [],
    );
  }

  /// `Can't find the answer you're looking for? Please contact our friendly team.`
  String
      get Can_not_find_the_answer_you_are_looking_for_Please_contact_our_friendly_team {
    return Intl.message(
      'Can\'t find the answer you\'re looking for? Please contact our friendly team.',
      name:
          'Can_not_find_the_answer_you_are_looking_for_Please_contact_our_friendly_team',
      desc: '',
      args: [],
    );
  }

  /// `how can we help you for all customer care issues related today?`
  String get how_can_we_help_you_today {
    return Intl.message(
      'how can we help you for all customer care issues related today?',
      name: 'how_can_we_help_you_today',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get Hi {
    return Intl.message(
      'Hi',
      name: 'Hi',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get Contact_Us {
    return Intl.message(
      'Contact Us',
      name: 'Contact_Us',
      desc: '',
      args: [],
    );
  }

  /// `If you need direct help with our support teams for.`
  String get If_you_need_direct_help_with_our_support_teams_for {
    return Intl.message(
      'If you need direct help with our support teams for.',
      name: 'If_you_need_direct_help_with_our_support_teams_for',
      desc: '',
      args: [],
    );
  }

  /// `There is no delivery address`
  String get There_is_no_delivery_address {
    return Intl.message(
      'There is no delivery address',
      name: 'There_is_no_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Num of Tickets`
  String get num_of_tickets {
    return Intl.message(
      'Num of Tickets',
      name: 'num_of_tickets',
      desc: '',
      args: [],
    );
  }

  /// `Please specify the delivery address so that we can reach you easily`
  String
      get Please_specify_the_delivery_address_so_that_we_can_reach_you_easily {
    return Intl.message(
      'Please specify the delivery address so that we can reach you easily',
      name:
          'Please_specify_the_delivery_address_so_that_we_can_reach_you_easily',
      desc: '',
      args: [],
    );
  }

  /// `left in stock`
  String get left_in_stock {
    return Intl.message(
      'left in stock',
      name: 'left_in_stock',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message(
      'items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Open settings`
  String get Open_settings {
    return Intl.message(
      'Open settings',
      name: 'Open_settings',
      desc: '',
      args: [],
    );
  }

  /// `Book tickets in advance`
  String get Book_tickets_in_advance {
    return Intl.message(
      'Book tickets in advance',
      name: 'Book_tickets_in_advance',
      desc: '',
      args: [],
    );
  }

  /// `Search country`
  String get Search_country {
    return Intl.message(
      'Search country',
      name: 'Search_country',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get Order_Number {
    return Intl.message(
      'Order Number',
      name: 'Order_Number',
      desc: '',
      args: [],
    );
  }

  /// `Name address`
  String get name_my_address {
    return Intl.message(
      'Name address',
      name: 'name_my_address',
      desc: '',
      args: [],
    );
  }

  /// `Name street`
  String get name_my_street {
    return Intl.message(
      'Name street',
      name: 'name_my_street',
      desc: '',
      args: [],
    );
  }

  /// `build number`
  String get build_number {
    return Intl.message(
      'build number',
      name: 'build_number',
      desc: '',
      args: [],
    );
  }

  /// `Type Address`
  String get type_address {
    return Intl.message(
      'Type Address',
      name: 'type_address',
      desc: '',
      args: [],
    );
  }

  /// `Appartement`
  String get appartement {
    return Intl.message(
      'Appartement',
      name: 'appartement',
      desc: '',
      args: [],
    );
  }

  /// `The Address`
  String get Address {
    return Intl.message(
      'The Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `what services are you looking for`
  String get wha_services_are_you_looking_for {
    return Intl.message(
      'what services are you looking for',
      name: 'wha_services_are_you_looking_for',
      desc: '',
      args: [],
    );
  }

  /// `Services Categories`
  String get Services_Categories {
    return Intl.message(
      'Services Categories',
      name: 'Services_Categories',
      desc: '',
      args: [],
    );
  }

  /// `About the services`
  String get About_the_services {
    return Intl.message(
      'About the services',
      name: 'About_the_services',
      desc: '',
      args: [],
    );
  }

  /// `Services benefit`
  String get Services_benefit {
    return Intl.message(
      'Services benefit',
      name: 'Services_benefit',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get Booking {
    return Intl.message(
      'Booking',
      name: 'Booking',
      desc: '',
      args: [],
    );
  }

  /// `Selet Cateogry`
  String get Selet_Cateogry {
    return Intl.message(
      'Selet Cateogry',
      name: 'Selet_Cateogry',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get Distance {
    return Intl.message(
      'Distance',
      name: 'Distance',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get Send_Message {
    return Intl.message(
      'Send Message',
      name: 'Send_Message',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get Follow {
    return Intl.message(
      'Follow',
      name: 'Follow',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't get your camera :(`
  String get Could_not_get_your_camera {
    return Intl.message(
      'Couldn\'t get your camera :(',
      name: 'Could_not_get_your_camera',
      desc: '',
      args: [],
    );
  }

  /// `Payment is processed`
  String get Payment_is_processed {
    return Intl.message(
      'Payment is processed',
      name: 'Payment_is_processed',
      desc: '',
      args: [],
    );
  }

  /// `Please wait while the payment is completed`
  String get Please_wait_while {
    return Intl.message(
      'Please wait while the payment is completed',
      name: 'Please_wait_while',
      desc: '',
      args: [],
    );
  }

  /// `And don't do anything`
  String get And_dont_do_anything {
    return Intl.message(
      'And don\'t do anything',
      name: 'And_dont_do_anything',
      desc: '',
      args: [],
    );
  }

  /// `please don't come back`
  String get please_don_t_come_back {
    return Intl.message(
      'please don\'t come back',
      name: 'please_don_t_come_back',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder`
  String get Card_Holder {
    return Intl.message(
      'Card Holder',
      name: 'Card_Holder',
      desc: '',
      args: [],
    );
  }

  /// `Expired Date`
  String get Expired_Date {
    return Intl.message(
      'Expired Date',
      name: 'Expired_Date',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get Card_Number {
    return Intl.message(
      'Card Number',
      name: 'Card_Number',
      desc: '',
      args: [],
    );
  }

  /// `Card info`
  String get Card_info {
    return Intl.message(
      'Card info',
      name: 'Card_info',
      desc: '',
      args: [],
    );
  }

  /// `Save card for future reference`
  String get Save_card_for_future_reference {
    return Intl.message(
      'Save card for future reference',
      name: 'Save_card_for_future_reference',
      desc: '',
      args: [],
    );
  }

  /// `Expired Date Error`
  String get Expired_Date_Error {
    return Intl.message(
      'Expired Date Error',
      name: 'Expired_Date_Error',
      desc: '',
      args: [],
    );
  }

  /// `Reset All Fields`
  String get reset_all {
    return Intl.message(
      'Reset All Fields',
      name: 'reset_all',
      desc: '',
      args: [],
    );
  }

  /// `View all my moments`
  String get view_all_my_moments {
    return Intl.message(
      'View all my moments',
      name: 'view_all_my_moments',
      desc: '',
      args: [],
    );
  }

  /// `Please select shipping information`
  String get please_select_shipping_information {
    return Intl.message(
      'Please select shipping information',
      name: 'please_select_shipping_information',
      desc: '',
      args: [],
    );
  }

  /// `Others payment method`
  String get other_payment_method {
    return Intl.message(
      'Others payment method',
      name: 'other_payment_method',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Translation> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Translation> load(Locale locale) => Translation.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
