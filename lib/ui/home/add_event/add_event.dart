import 'dart:ui' as ui;

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:evently/models/events.dart';
import 'package:evently/providers/event_map_provider.dart';
import 'package:evently/providers/my_user_provider.dart';
import 'package:evently/ui/home/add_event/widgets/choose_date_or_time.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/fire_base_utils.dart';
import 'package:evently/wigets/custom_elevated_button.dart';
import 'package:evently/wigets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wheel_picker/wheel_picker.dart';

import '../../../models/events_tab_item.dart';
import '../../../utils/app_const.dart';
import '../tabs/home_tab/widgets/event_tab_bar.dart';

class AddEvent extends StatefulWidget {
  AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String selectedImage = '';
  String selectedName = '';
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String formattedDate = '';
  String formattedTimne = '';
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override

  @override
  @override
  Widget build(BuildContext context) {
    final pickLocationProvider = Provider.of<PickLocationProvider>(context);
    var appConst = AppConst(context);
    List<String> eventsCategories = [
      'sport',
      'birthday',
      'meeting',
      'gaming',
      'eating',
      'holiday',
      'exhibition',
      'workShop',
      'book_club',
    ];
    selectedName = eventsCategories[selectedIndex];
    List<EventTabItem> eventsTabItems = [
      EventTabItem(
        eventName: appConst.text.sport,
        eventIcon: Icons.directions_bike,
      ),
      EventTabItem(
        eventName: appConst.text.birthday,
        eventIcon: Icons.cake_outlined,
      ),
      EventTabItem(
        eventName: appConst.text.meeting,
        eventIcon: Icons.laptop_chromebook,
      ),
      EventTabItem(
        eventName: appConst.text.gaming,
        eventIcon: Icons.gamepad_outlined,
      ),
      EventTabItem(eventName: appConst.text.eating, eventIcon: Icons.fastfood),
      EventTabItem(
        eventName: appConst.text.holiday,
        eventIcon: Icons.beach_access_outlined,
      ),
      EventTabItem(
        eventName: appConst.text.exhibition,
        eventIcon: Icons.collections_bookmark_outlined,
      ),
      EventTabItem(
        eventName: appConst.text.workShop,
        eventIcon: Icons.work_outline_sharp,
      ),
      EventTabItem(
        eventName: appConst.text.book_club,
        eventIcon: Icons.my_library_books_outlined,
      ),
    ];
    Map<String, String> eventImages = {
      appConst.text.sport: appConst.image.sport,
      appConst.text.birthday: appConst.image.birthday,
      appConst.text.meeting: appConst.image.meeting,
      appConst.text.gaming: appConst.image.gaming,
      appConst.text.eating: appConst.image.eating,
      appConst.text.holiday: appConst.image.holiday,
      appConst.text.exhibition: appConst.image.exhibition,
      appConst.text.workShop: appConst.image.workShop,
      appConst.text.book_club: appConst.image.bookClub,
    };
    selectedImage = eventImages[eventsTabItems[selectedIndex].eventName]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appConst.text.create_event, style: AppStyles.primaryMed20),
        centerTitle: true,
        backgroundColor: appConst.theme.cardColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: appConst.height * .25,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: Image.asset(
                    eventImages[eventsTabItems[selectedIndex].eventName]!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: appConst.height * 0.07,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 17),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: EventTabBar(
                      eventName: eventsTabItems[index].eventName,
                      eventIcon: eventsTabItems[index].eventIcon,
                      isSelected: selectedIndex == index,
                      isItAddEvent: true,
                    ),
                  ),
                  itemCount: eventsTabItems.length,
                ),
              ),
              Text(appConst.text.title, style: appConst.textStyle.bodyMedium),
              CustomTextFormField(
                controller: titleController,
                prefixIcon: Icons.edit_note_rounded,
                hintText: appConst.text.event_title,
                onValidator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return appConst.text.please_enter_event_title;
                  }
                  return null;
                },
              ),
              Text(
                appConst.text.description,
                style: appConst.textStyle.bodyMedium,
              ),
              CustomTextFormField(
                controller: descriptionController,
                hasPrefixIcon: false,
                maxLines: 3,
                hintText: appConst.text.event_description,
                onValidator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return appConst.text.please_enter_event_discription;
                  }
                  return null;
                },
              ),
              ChooseDateOrTime(
                icon: Icons.calendar_month_outlined,
                text: appConst.text.event_date,
                functionText: selectedDate == null
                    ? appConst.text.choose_date
                    : formattedDate,
                onChange: showDate,
              ),
              ChooseDateOrTime(
                icon: Icons.watch_later_outlined,
                text: appConst.text.event_time,
                functionText: selectedTime == null
                    ? appConst.text.choose_time
                    : formattedTimne,
                onChange: showTime,
              ),
              Text(
                appConst.text.location,
                style: appConst.textStyle.bodyMedium,
              ),
              CustomElevatedButton(
                backGroundColor: Colors.transparent,
                borderColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.eventMapRouteName,arguments: pickLocationProvider);
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.gps_fixed,
                        color: appConst.theme.cardColor,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(pickLocationProvider.eventLocation==null?
                          appConst.text.tap_on_location_to_select
                          :'${pickLocationProvider.country} , ${pickLocationProvider.city}'

                          , style: AppStyles.primaryMed16,
                        softWrap: true,

                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                onPressed: addEvent,
                child: Text(
                  appConst.text.add_event,
                  style: AppStyles.whiteMed20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDate() {
    var appConst = AppConst(context);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EasyDateTimeLine(
          timeLineProps: EasyTimeLineProps(decoration: BoxDecoration()),
          dayProps: EasyDayProps(
            inactiveMothStrStyle: AppStyles.primaryBold16,
            inactiveDayStrStyle: AppStyles.primaryBold16,
            activeDayStrStyle: AppStyles.blackBold16,
            activeMothStrStyle: AppStyles.blackBold16,
          ),
          locale: appConst.localProvider.appLocal,
          initialDate: selectedDate ?? DateTime.now(),
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
              formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
            });
          },
          activeColor: AppColors.primaryColor,
          headerProps: EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            monthStyle: AppStyles.primaryBold16,
            selectedDateStyle: AppStyles.primaryBold16,
          ),
        );
      },
    );
  }

  void showTime() {
    var appConst = AppConst(context);
    int min = 0;
    int hour = 0;
    String per = '';
    showModalBottomSheet(
      backgroundColor: Theme.of(context).canvasColor,
      context: context,
      builder: (BuildContext context) {
        return Row(
          textDirection: ui.TextDirection.ltr,

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: WheelPicker(
                itemCount: 60,
                builder: (context, index) => Text(
                  index < 10 ? "0${index}" : "$index",
                  style: AppStyles.primaryBold20,
                ),
                selectedIndexColor: AppColors.primaryColor,
                style: WheelPickerStyle(
                  itemExtent: 50,
                  // Text height
                  squeeze: 1.25,
                  diameterRatio: .8,
                  surroundingOpacity: .25,
                  magnification: 1.2,
                ),
                onIndexChanged: (index, interactionType) {
                  min = index;
                },
              ),
            ),
            SizedBox(width: 15),
            SizedBox(
              width: 40,

              child: WheelPicker(
                itemCount: 12,
                builder: (context, index) =>
                    Text("$index", style: AppStyles.primaryBold20),
                selectedIndexColor: AppColors.primaryColor,
                style: WheelPickerStyle(
                  itemExtent: 50,
                  // Text height
                  squeeze: 1.25,
                  diameterRatio: .8,
                  surroundingOpacity: .25,
                  magnification: 1.2,
                ),
                onIndexChanged: (index, interactionType) {
                  hour = index == 0 ? 12 : index;
                },
              ),
            ),
            SizedBox(width: 15),
            SizedBox(
              width: 40,

              child: WheelPicker(
                itemCount: 2,
                builder: (context, index) => Text(
                  index == 0 ? "am" : "pm",
                  style: AppStyles.primaryBold20,
                ),
                selectedIndexColor: AppColors.primaryColor,
                style: WheelPickerStyle(
                  itemExtent: 50,
                  // Text height
                  squeeze: 1.25,
                  diameterRatio: .8,
                  surroundingOpacity: .25,
                  magnification: 1.2,
                ),
                looping: false,
                onIndexChanged: (index, interactionType) {
                  per = index == 0 ? 'am' : 'pm';
                },
              ),
            ),
            SizedBox(width: 50),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedTime = TimeOfDay(
                      hour: per == 'am' ? hour : hour + 12,
                      minute: min,
                    );
                    formattedTimne = selectedTime!.format(context);
                    Navigator.pop(context);
                  });
                },
                child: Text(appConst.text.done, style: AppStyles.primaryBold20),
              ),
            ),
          ],
        );
      },
    );
  }

  void addEvent() async {
    var appConst = AppConst(context);
    if (selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appConst.text.please_enter_event_time),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appConst.text.please_enter_event_date),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      var myUserProvider = Provider.of<MyUserProvider>(context, listen: false);
      Event event = Event(
          eventName: selectedName,
          eventTime: formattedTimne,
          eventDate: selectedDate!,
          eventTitle: titleController!.text,
          eventDescrption: descriptionController!.text);
      await FireBaseUtils.setEvent(event);
      await FireBaseUtils.setUserEvent(myUserProvider.currentUser!.id!, event);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(appConst.text.event_added),
          backgroundColor: AppColors.primaryColor
      ));
      Navigator.of(context).pop();
    }
  }
}
