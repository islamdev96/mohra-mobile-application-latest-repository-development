import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/generated/l10n.dart';
import 'build_error_screen.dart';
import 'package:starter_application/core/common/extensions/extensions.dart';

part 'bad_request_error_screen/bad_request_error_screen_widget.dart';

part 'connection_error_screen/connection_error_screen_widget.dart';

part 'custom_error_screen/custom_error_screen_widget.dart';

part 'forbidden_error_screen/forbidden_error_screen_widget.dart';

part 'internal_server_error_screen/internal_server_error_screen_widget.dart';

part 'not_found_error_screen/not_found_error_screen_widget.dart';

part 'time_out_error_screen.dart/time_out_error_screen_widget.dart';

part 'unauthorized_error_screen/unauthorized_error_screen_widget.dart';

part 'unexpected_error_screen/unexpected_error_screen_widget.dart';

part 'internal_server_with_data_error_screen/internal_server_with_data_error_screen.dart';

part 'account_not_verified_error_screen/account_not_verified_error_screen.dart';

part 'cancel_error_screen/cancel_error_screen.dart';

part 'conflict_error_screen/conflict_error_screen.dart';

part 'format_error_screen/format_error_screen.dart';

part 'login_required_error_screen/login_required_error_screen.dart';

part 'net_error_screen/net_error_screen.dart';

part 'response_error_screen/response_error_screen.dart';

part 'screen_not_implemented_error/screen_not_implemented_error.dart';

part 'socket_error_screen/socket_error_screen.dart';

part 'unknown_error_screen/unknown_error_screen.dart';

class ErrorScreenWidget extends StatelessWidget {
  final AppErrors error;
  final VoidCallback callback;
  final bool disableRetryButton;
  final String? backTitle;

  const ErrorScreenWidget({
    Key? key,
    required this.error,
    required this.callback,
    this.backTitle,
    this.disableRetryButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    error.runtimeType.toString().logD;

    Column? errorWidget;
    if (backTitle != null) {
      errorWidget = Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(150),
            margin: EdgeInsets.only(
              top: ScreenUtil().statusBarHeight,
            ),
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(35)),
            child: Row(
              children: [
                ButtonTheme(
                  minWidth: 0,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AppConstants.getIconBack(),
                          color: Theme.of(context).primaryColor,
                          size: ScreenUtil().setSp(45),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(5),
                        ),
                        Text(
                          backTitle!,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: ScreenUtil().setSp(40)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    final errorResWidget = error.map(
      connectionError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            ConnectionErrorScreenWidget(
              callback: callback,
              disableRetryButton: this.disableRetryButton,
            ),
          );
          return errorWidget;
        }
        else {
          return ConnectionErrorScreenWidget(
              callback: callback, disableRetryButton: this.disableRetryButton);
        }
      },
      internalServerError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            InternalServerErrorScreenWidget(
              callback: callback,
              disableRetryButton: this.disableRetryButton,
            ),
          );
        } else {
          return InternalServerErrorScreenWidget(
              callback: callback, disableRetryButton: this.disableRetryButton);
        }
      },
      internalServerWithDataError: (error) {
        if (errorWidget != null) {
          errorWidget.children.add(
            InternalServerWithDataErrorScreen(
              errorCode: error.errorCode,
              message: error.message,
              callback: callback,
              disableRetryButton: this.disableRetryButton,
            ),
          );
        }
        else {
          return InternalServerWithDataErrorScreen(
            errorCode: error.errorCode,
            message: error.message,
            callback: callback,
            disableRetryButton: this.disableRetryButton,
          );
        }
      },
      accountNotVerifiedError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            AccountNotVerifiedErrorScreen(),
          );
        } else {
          return AccountNotVerifiedErrorScreen();
        }
      },
      badRequestError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(BadRequestErrorScreenWidget());
          return errorWidget;
        } else {
          return BadRequestErrorScreenWidget();
        }
      },
      cancelError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(CancelErrorScreen());
          return errorWidget;
        } else {
          return CancelErrorScreen();
        }
      },
      conflictError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(ConflictErrorScreen());
          return errorWidget;
        } else {
          return ConflictErrorScreen();
        }
      },
      customError: (error) {
        if (errorWidget != null) {
          errorWidget.children.add(
            CustomErrorScreenWidget(
              message: error.message,
              callback: callback,
              disableRetryButton: this.disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return CustomErrorScreenWidget(
            message: error.message,
            disableRetryButton: this.disableRetryButton,
          );
        }
      },
      forbiddenError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(ForbiddenErrorScreenWidget());
          return errorWidget;
        } else {
          return ForbiddenErrorScreenWidget();
        }
      },
      formatError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(FormatErrorScreen());
          return errorWidget;
        } else {
          return FormatErrorScreen();
        }
      },
      loginRequiredError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(LoginRequiredErrorScreen());
          return errorWidget;
        } else {
          return LoginRequiredErrorScreen();
        }
      },
      netError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            NetErrorScreen(
              callback: callback,
              disableRetryButton: this.disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return NetErrorScreen(
              callback: callback, disableRetryButton: this.disableRetryButton);
        }
      },
      notFoundError: (error) {
        if (errorWidget != null) {
          errorWidget.children.add(NotFoundErrorScreenWidget(
            callback: callback,
            disableRetryButton: this.disableRetryButton,
            url: error.requestedUrlPath,
          ));
          return errorWidget;
        } else {
          return NotFoundErrorScreenWidget(
            callback: callback,
            disableRetryButton: this.disableRetryButton,
            url: error.requestedUrlPath,
          );
        }
      },
      responseError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(ResponseErrorScreen());
          return errorWidget;
        } else {
          return ResponseErrorScreen();
        }
      },
      screenNotImplementedError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(ScreenNotImplementedError());
          return errorWidget;
        } else {
          return ScreenNotImplementedError();
        }
      },
      socketError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            SocketErrorScreen(
              callback: callback,
              disableRetryButton: this.disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return SocketErrorScreen(
              callback: callback, disableRetryButton: this.disableRetryButton);
        }
      },
      timeoutError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(
            TimeOutErrorScreenWidget(
              callback: callback,
              disableRetryButton: this.disableRetryButton,
            ),
          );
          return errorWidget;
        } else {
          return TimeOutErrorScreenWidget(
            callback: callback,
            disableRetryButton: this.disableRetryButton,
          );
        }
      },
      unauthorizedError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(UnauthorizedErrorScreenWidget());
          return errorWidget;
        } else {
          return UnauthorizedErrorScreenWidget();
        }
      },
      unknownError: (_) {
        if (errorWidget != null) {
          errorWidget.children.add(UnknownErrorScreen(
            callback: callback,
          ));
          return errorWidget;
        } else {
          return UnknownErrorScreen(
            callback: callback,
          );
        }
      },
    );

    if (errorResWidget != null) {
      return errorResWidget;
    }

    if (errorWidget != null) {
      errorWidget.children.add(
        UnexpectedErrorScreenWidget(
          callback: callback,
          disableRetryButton: this.disableRetryButton,
        ),
      );
    } else {
      return UnexpectedErrorScreenWidget(
          callback: callback, disableRetryButton: this.disableRetryButton);
    }
    return UnexpectedErrorScreenWidget(
      callback: callback,
      disableRetryButton: this.disableRetryButton,
    );
  }
}
