import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/core/routes/app_routes_name.dart';
import 'package:news_app/modules/home/model/app_category.dart';

class CategoryCardWidget extends StatefulWidget {
  const CategoryCardWidget(
      {super.key, required this.category, required this.isLeft});

  final AppCategory category;
  final bool isLeft;

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  double dx = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery=MediaQuery.of(context).size;
    var height=mediaQuery.height;
    var width=mediaQuery.width;
    return Container(
      height: height*0.22,
      decoration: BoxDecoration(
          color: theme.primaryColorLight,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        textDirection: widget.isLeft ? TextDirection.ltr : TextDirection.rtl,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(width:width*0.4,height: double.infinity,child: Image.asset(widget.category.categoryImage,fit: BoxFit.cover,))),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.category.categoryName,
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontSize: 25, color: theme.primaryColor),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.localPosition.dx > 0 &&
                      details.localPosition.dx < 100 &&
                      !widget.isLeft) {
                    dx = details.localPosition.dx;
                    if (dx > 80) {
                      Navigator.pushNamed(context, RoutesName.news,arguments: widget.category);
                      dx = 0;
                    }

                    setState(() {});
                  } else if (details.localPosition.dx < 0 &&
                      details.localPosition.dx > -100 &&
                      widget.isLeft) {
                    dx = details.localPosition.dx;
                    if (dx < -80) {
                      Navigator.pushNamed(context, RoutesName.news,arguments: widget.category);
                      dx = 0;
                    }
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(360)),
                  child: Row(
                    textDirection:
                        widget.isLeft ? TextDirection.ltr : TextDirection.rtl,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 250),
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: dx > 50 || dx < -50
                                  ? Colors.transparent
                                  : null),
                          child: Text(
                            "View All",
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(dx, 0),
                        child: CircleAvatar(
                          backgroundColor: theme.primaryColor,
                          radius: 25,
                          child: Icon(
                            widget.isLeft
                                ? Icons.arrow_back_ios_new_rounded
                                : Icons.arrow_forward_ios_rounded,
                            color: theme.primaryColorLight,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
