import 'package:flutter/material.dart';
import 'package:yogaflutter/models/lesson.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



 class PageChooseInstructor extends StatelessWidget {
    final Lesson lesson;
    PageChooseInstructor({Key key, @required this.lesson}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1125, height: 2436, allowFontScaling: true);
    return new Scaffold(
      appBar: new AppBar(backgroundColor: Colors.indigo[400],),
      body: new Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: ScreenUtil().setHeight(1050),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: 5,                         //instructors.length - 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      ),
                      child: InstructorCard(
                      cardNum: index
                      ),
                    );
                  },
                )
              ),
              Center(
              child: RaisedButton(
                onPressed: () {
                  
                  //Navigator.of(context).push(
                  //new MaterialPageRoute(
                    //builder: (BuildContext context) =>
                      //InstructorPage(lesson: lesson,)));
                },
                child: Text(
                  'Prosegui',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)
                  )
              )
            )
            ]
          )
        )
      )
    );
  }
}

class InstructorCard extends StatelessWidget {
  final int cardNum;
  InstructorCard({this.cardNum});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(642),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(40)
              ),
              child: Container(
                width: ScreenUtil().setWidth(620),
                height: ScreenUtil().setHeight(990),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFFFFCC5C), const Color(0xFFFF6F69)],             //instructors.colors,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 8),
                      blurRadius: 8,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(45),
                          bottom: ScreenUtil().setHeight(45),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Luca"                                //instructors.name,
                            ),
                          ],
                        )
                      )
                    )
                  ],
                )
              )
            ),
          ),
          //Positioned(
            //top: ScreenUtil().setHeight(60),
            //left: ScreenUtil().setWidth(-22),
            //child: Image.asset(
               //'./pictures/yogi.png',                         //instructors.imageURL,
              //width: ScreenUtil().setWidth(640),
              //height: ScreenUtil().setHeight(610),
              //fit: BoxFit.cover
            //)
          //),
          
        ],
      ),
    );
  }
} 