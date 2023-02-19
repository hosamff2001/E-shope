import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/styles.dart';

class LanguageModel {
  final String language;
  final String code;

  LanguageModel({
    required this.language,
    required this.code,
  });
}

List<LanguageModel> languageList = [
  LanguageModel(
    language: 'English',
    code: 'en',
  ),
  LanguageModel(
    language: 'العربية',
    code: 'ar',
  ),
];

// Widget languageItem(
//   LanguageModel model, {
//   context,
//   index,
// }) =>
//     InkWell(
//       onTap: () {
//         AppCubit.get(context).changeSelectedLanguage(index);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 model.language,
//               ),
//             ),
//             if (AppCubit.get(context).selectedLanguage[index])
//               Icon(
//                 IconBroken.Arrow___Right_Circle,
//               ),
//           ],
//         ),
//       ),
//     );

Widget defaultTextFormfiled({
  required String? Function(String? value)? validator,
  required String hint,
  required TextEditingController controller,
  required IconData prefixicon,
  IconData? suffixIcon,
  VoidCallback? suffixfunction,
  bool ispassword = false,
  Function(String text)? onsubmitt
}) =>
    TextFormField(
      controller: controller,
      validator: validator,
      obscureText: ispassword,
      onFieldSubmitted: onsubmitt,
      decoration: InputDecoration(
        hintText: hint,
        
        suffixIcon: IconButton(
            icon: Icon(ispassword == false ? suffixIcon : Icons.visibility_off),
            onPressed: suffixfunction),
        prefixIcon: Icon(
          prefixicon,
        ),
        labelText: hint,
        border: OutlineInputBorder(),
      ),
    );

Widget defaulttextbutton(
        {required VoidCallback onpressed, required String text}) =>
    TextButton(onPressed: onpressed, child: Text(text.toUpperCase()));

Widget defaultSeparator() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

Widget defaultButton({
  required VoidCallback function,
  required String text,
}) =>
    Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: white14bold(),
        ),
      ),
    );

void showToast({
  required String text,
  required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Future<bool?> Showtoast({required String msg, required ToastStates color}) =>
    Fluttertoast.showToast(
      
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: toastcolor(state: color),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARING }

Color toastcolor({required ToastStates state}) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
      case ToastStates.ERROR:
      return Colors.red;
      case ToastStates.WARING:
      return Colors.amber;
  }
}
