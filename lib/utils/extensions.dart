import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:texol_stock_parser/utils/constants.dart';

extension AppErrorTypeExtension on AppErrorType {
  String get message {
    switch (this) {
      case AppErrorType.api:
        return "Something went wrong, please try again later";
      case AppErrorType.network:
        return 'Something went wrong , Please check your network connection';
      case AppErrorType.database:
        return 'Something went wrong , Please check your database connection';
      case AppErrorType.unauthorised:
        return "You are not authorised to perform this action";
      case AppErrorType.sessionDenied:
        return "Session Expired, Please login again";
    }
  }

  String get svgImage {
    switch (this) {
      case AppErrorType.api:
        return 'assets/svgs/api_error.svg';
      case AppErrorType.network:
        return 'assets/svgs/network_error.svg';
      case AppErrorType.database:
        return 'assets/svgs/database_error.svg';
      case AppErrorType.unauthorised:
        return 'assets/svgs/unauthorised_error.svg';
      case AppErrorType.sessionDenied:
        return 'assets/svgs/session_denied_error.svg';
    }
  }
}

extension AppErrorExtension on AppError {
  handleError() {
    logger.info(appErrorType);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(appErrorType.message),
      ),
    );
  }
}

extension CriteriaExtension on String {
  CriteriaType get criteriaType {
    switch (this) {
      case "plain_text":
        return CriteriaType.plaintext;
      case "variable":
        return CriteriaType.variable;
      default:
        return CriteriaType.plaintext;
    }
  }

  VariableType get variableType {
    switch (this) {
      case "value":
        return VariableType.value;
      case "indicator":
        return VariableType.indicator;
      default:
        return VariableType.value;
    }
  }
}

enum CriteriaType {
  plaintext,
  variable,
}

enum VariableType { value, indicator }

extension VariableTypeExtension on VariableType {
  Widget alertDialog(Map<String, dynamic> placeholderValueObject) {
    switch (this) {
      case VariableType.value:
        return AlertDialog(content: Builder(builder: (context) {
          final List values = placeholderValueObject["values"];
          return ListView.separated(
            shrinkWrap: true,
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              List values = placeholderValueObject["values"];
              return ListTile(
                title: Text(values[index].toString()),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        }));
      case VariableType.indicator:
        return AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(placeholderValueObject["study_type"]
                    .toString()
                    .toUpperCase()),
                Text(
                  "Set Parameters",
                  style: Theme.of(Get.context!).textTheme.bodyText1,
                )
              ],
            ),
            content: Row(
              children: [
                const Text("Period"),
                defaultSpacerHorizontal,
                Expanded(
                  child: TextFormField(
                    initialValue:
                        placeholderValueObject["default_value"].toString(),
                  ),
                ),
              ],
            ));
    }
  }

  String actionText(Map<String, dynamic> placeholderObject) {
    switch (this) {
      case VariableType.value:
        return "(${placeholderObject["values"][0]})";
      case VariableType.indicator:
        return "(${placeholderObject["default_value"]})";
    }
  }

  WidgetSpan actionWidget(Map<String, dynamic> placeholderObject) {
    return WidgetSpan(
      child: GestureDetector(
        onTap: () => Get.dialog(alertDialog(placeholderObject)),
        child: Text(
          actionText(placeholderObject),
          style: Theme.of(Get.context!)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.blue),
        ),
      ),
    );
  }
}
