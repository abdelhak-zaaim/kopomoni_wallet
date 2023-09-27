import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final Function? icon;
  final Function? onTap;
  final Duration? eventDuration;
  final bool? isDetailsPage;
  const TitleRow({Key? key, required this.title,this.icon, this.onTap, this.eventDuration, this.isDetailsPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? days, hours, minutes, seconds;
    if (eventDuration != null) {
      days = eventDuration!.inDays;
      hours = eventDuration!.inHours - days * 24;
      minutes = eventDuration!.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = eventDuration!.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    }

    return Row(children: [
      Text(title, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).textTheme.titleLarge!.color)),
      eventDuration == null
          ? const Expanded(child: SizedBox.shrink())
          : Expanded(
              child: Row(children: [
              const SizedBox(width: 5),
              TimerBox(time: days),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: hours),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: minutes),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: seconds, isBorder: true),
            ])),

      onTap != null
          ? InkWell(
              onTap: onTap as void Function()?,
              child: Row(children: [
                isDetailsPage == null
                    ? Text('view_all'.tr,
                        style: rubikRegular.copyWith(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                          fontSize: Dimensions.fontSizeDefault,
                        ))
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(left : Dimensions.paddingSizeSmall,top:Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall),
                  child: Icon(Icons.arrow_forward_ios,
                    color: isDetailsPage == null ? Theme.of(context).textTheme.titleLarge!.color : Theme.of(context).hintColor,
                    size: Dimensions.fontSizeSmall,
                  ),
                ),
              ]),
            )
          : const SizedBox.shrink(),
    ]);
  }
}

class TimerBox extends StatelessWidget {
  final int? time;
  final bool isBorder;

  const TimerBox({Key? key, required this.time, this.isBorder = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(isBorder ? 0 : 2),
      decoration: BoxDecoration(
        color: isBorder ? null : Theme.of(context).primaryColor,
        border: isBorder ? Border.all(width: 2, color: Theme.of(context).primaryColor) : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(time! < 10 ? '0$time' : time.toString(),
          style: rubikSemiBold.copyWith(
            color: isBorder ? Theme.of(context).primaryColor : Theme.of(context).highlightColor,
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
      ),
    );
  }
}
