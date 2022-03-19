import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchBarWidget extends StatelessWidget {
  Function (String value) typedText;

  SearchBarWidget({this.typedText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.all(Radius.circular(5)),
          color: Colors.white,

        ),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                // onChanged:typedText,
                // onSaved:typedText ,
                onFieldSubmitted:typedText ,
                maxLines: 1,
                style: TextStyle(
                    fontFamily: "din",
                    fontSize: 12.sp,
                    color:const Color(0xff8B8B8B)
                ),
                decoration: InputDecoration(
                  hintText:"Search movie Name",
                  hintStyle: TextStyle(
                      color:const Color(0xff8B8B8B),
                      fontFamily: "din",
                      fontSize: ScreenUtil().setSp(13)),
                  prefixIcon: const Icon(Icons.search,),
                  focusedBorder:
                  const  OutlineInputBorder(borderSide:  BorderSide(color: Colors.white)),
                  enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  border:const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
