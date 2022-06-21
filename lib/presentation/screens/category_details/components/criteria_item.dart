import 'package:flutter/material.dart';

import '../../../../utils/extensions.dart';

class CriteriaItem extends StatelessWidget {
  const CriteriaItem({
    Key? key,
    required this.criteria,
  }) : super(key: key);

  final dynamic criteria;

  @override
  Widget build(BuildContext context) {
    final CriteriaType criteriaType = criteria["type"].toString().criteriaType;
    switch (criteriaType) {
      case CriteriaType.plaintext:
        return Text(criteria["text"]);

      case CriteriaType.variable:
        List<String> textComponents = criteria["text"].split("\$");
        return RichText(
          text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: List.generate(textComponents.length, (index) {
                String textComponent = textComponents[index];
                int? placeHolder = int.tryParse(textComponent[0]);
                if (placeHolder != null) {
                  textComponent = textComponent.substring(1);
                  var placeholderValueObject =
                      criteria["variable"]["\$$placeHolder"];
                  VariableType variableType =
                      placeholderValueObject["type"].toString().variableType;

                  return TextSpan(children: [
                    variableType.actionWidget(placeholderValueObject),
                    TextSpan(
                      text: textComponent,
                    ),
                  ]);
                } else {
                  return TextSpan(text: textComponent);
                }
              })),
        );
    }
  }
}
