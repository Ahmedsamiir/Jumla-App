


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/layouts/shopLayout/cubit/cubit.dart';
import 'package:salla/models/favorites_model.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';


Widget defaultButton({
  required Function function,
  required String text,
}) =>
    Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          text.toUpperCase(),
          style: white14bold(),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) => TextButton(
  onPressed: function(),
  child: Text(text.toUpperCase()),
);

Widget buildSeparator() => Container(
  height: 1.0,
  width: double.infinity,
  color: Colors.grey[300],
);

Widget defaultButtons({
  required String text,
  required Function function,

})=> Container(
  height: 40.0,
  width: double.infinity,
  decoration: BoxDecoration(
    color: defaultColor,
    borderRadius: BorderRadius.circular(
      3.0,
    ),
  ),
  child: MaterialButton(
    child: Text(
      text,
      style: white14bold(),
    ),
    onPressed:function() ,
  ),
);

Widget defaultFormField({
  required controller,
  hint = '',
  required type,
  required Function onType,
  isPassword = false,
  required Icon icon,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onChanged: onType(),
        decoration: InputDecoration(
          hintText: hint,
          prefix: icon,
          border: InputBorder.none,
        ),
      ),
    );

Widget myDivider()=> Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(width: double.infinity, height: 1.0,)
);
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
  // to remove previous routes of pages
      (Route<dynamic> route) => false,
);

void showToast({
  required String text,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR, WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;

}

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120.0,
              height: 120.0,

            ),
            if(model.discount!=0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14.0, height: 1.3),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(fontSize: 12.0, color: defaultColor),
                  ),
                  const SizedBox(width: 5.0,),
                  if(model.discount!= 0 && isOldPrice)
                    Text(
                      '${model.oldPrice}',
                      style: const TextStyle(fontSize: 10.0, color: Colors.grey, decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.id);

                    },
                    icon:  CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                      child:  const Icon(Icons.favorite_border, size: 14.0,
                      ),
                    ), // todo something here

                  ),


                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);