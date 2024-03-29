import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';
import 'package:kuma_flutter_app/widget/common/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final String value;
  final String hint;
  final String errorText;
  final List<DropdownMenuItem> items;
  final Function onChanged;

  const  CustomDropDown(
      {Key key,
        this.value,
        this.hint,
        this.items,
        this.onChanged,
        this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
              color: kDisabled, borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding:
            const EdgeInsets.only(left: 30, right: 10),
            child: DropdownButton<String>(
              value: value,
              hint: CustomText(
                text:hint,
                fontSize: 10.0,
                isEllipsis: true,
              ),
              style: Theme.of(context).textTheme.headline6,
              items: items,
              onChanged: (item) {
                onChanged(item);
              },
              isExpanded: true,
              underline: Container(),
              icon: const Icon(Icons.keyboard_arrow_down,color: kWhite,),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Text(errorText, style: TextStyle(fontSize: 12, color: Colors.red[800]),),
          )

      ],
    );
  }
}