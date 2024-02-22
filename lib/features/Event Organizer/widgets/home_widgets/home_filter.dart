
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_categories_shimmer_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_tabs_widget.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/cubit/event_orginizer_cubit.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/provider/event_organizer_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
class HomeFilter extends StatefulWidget {
  final EventOrganizerScreenNotifier sn;
   HomeFilter({Key? key, required this.sn}) : super(key: key);

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {



  @override
  void initState() {
    widget.sn.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: (){
              widget.sn.clearAll();
              Nav.pop();
            },
            child: Padding(
              padding:  EdgeInsets.only(top: 30.0,left: 15,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(Translation.current.Event_Filter,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Icon(Icons.close)
                ],
              ),
            ),
          ),
        ),
        // location
        Positioned(
          left: 0,
            right: 0,
            top: 80,
            bottom: 0,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(Translation.current.Location,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 10,
                                    children: [
                                      ChoiceChip(
                                        labelPadding: const EdgeInsets.all(2.0),
                                        label: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          height: 40,
                                          width: 70,
                                          child: Center(
                                            child: Text(
                                              Translation.current.local_event,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(color: Colors.black, fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(
                                                width: 2,
                                                color: Color(0xFFFFEEE9)
                                            )
                                        ),
                                        selected:widget.sn.eventLocation == 0,
                                        selectedColor: const Color(0xFFFFEEE9),
                                        onSelected: (value) {
                                          setState(() {
                                            widget.sn.eventLocation == 0 ? widget.sn.eventLocation = null : widget.sn.eventLocation = 0;
                                          });
                                        },
                                        // backgroundColor: color,
                                        elevation: 1,
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                      ),
                                      ChoiceChip(
                                        labelPadding: const EdgeInsets.all(2.0),
                                        label: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          height: 40,
                                          width: 70,
                                          child: Center(
                                            child: Text(
                                              Translation.current.online_event,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(color: Colors.black, fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(
                                                width: 2,
                                                color: Color(0xFFFFEEE9)
                                            )
                                        ),
                                        selected:widget.sn.eventLocation == 1,
                                        selectedColor: const Color(0xFFFFEEE9),
                                        onSelected: (value) {
                                          setState(() {
                                            widget.sn.eventLocation == 1 ? widget.sn.eventLocation = null : widget.sn.eventLocation = 1;
                                          });
                                        },
                                        // backgroundColor: color,
                                        elevation: 1,
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // ticket
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(Translation.current.Ticket_Type,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                Wrap(
                                  spacing: 10,
                                  children: [
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 70,
                                        child: Center(
                                          child: Text(
                                            Translation.current.free,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.ticketTypes == 0,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.ticketTypes == 0 ? widget.sn.ticketTypes = null : widget.sn.ticketTypes = 0;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 70,
                                        child: Center(
                                          child: Text(
                                            Translation.current.paid,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.ticketTypes == 1,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.ticketTypes == 1 ? widget.sn.ticketTypes = null : widget.sn.ticketTypes = 1;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // city list filter
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(Translation.current.city,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                Wrap(
                                  runAlignment: WrapAlignment.start,
                                  runSpacing: 6.0,
                                  spacing: 15,
                                  children: List.generate(Provider.of<SessionData>(AppConfig().appContext, listen: false).cities.length, (index) {
                                    return ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 70,
                                        child: Center(
                                          child: Text(
                                            Provider.of<SessionData>(AppConfig().appContext, listen: false).cities[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected: widget.sn.isFoundCities(Provider.of<SessionData>(AppConfig().appContext, listen: false).cities[index].id) != -1 ,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.changeCity(Provider.of<SessionData>(AppConfig().appContext, listen: false).cities[index].id);
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // event category list filter
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Text(Translation.current.Event_Category,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                const SizedBox(height: 10,),
                                BlocConsumer<EventOrginizerCubit, EventOrginizerState>(
                                  bloc: widget.sn.eventCategoriesCubit,
                                  listener: (context, state) {

                                  },
                                  builder: (context, state) {
                                    return state.maybeMap(
                                      eventOrginizerInitState: (value) => const CircularProgressIndicator.adaptive(),
                                      eventOrginizerLoadingState: (value) =>
                                      const CircularProgressIndicator.adaptive(),
                                      eventCategoriesLoadedState: (value) {
                                        return Column(
                                          children: [
                                            value.eventCategoriesEntity.items.isEmpty
                                                ? _buildEmptyWidget()
                                                :  Wrap(
                                              runAlignment: WrapAlignment.start,
                                              runSpacing: 6.0,
                                              spacing: 15,
                                              children: List.generate(value.eventCategoriesEntity.items.length, (index) {
                                                return ChoiceChip(
                                                  labelPadding: const EdgeInsets.all(2.0),
                                                  label: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15)
                                                    ),
                                                    height: 40,
                                                    width: 70,
                                                    child: Center(
                                                      child: Text(
                                                        value.eventCategoriesEntity.items[index].name,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(color: Colors.black, fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      side: const BorderSide(
                                                          width: 2,
                                                          color: Color(0xFFFFEEE9)
                                                      )
                                                  ),
                                                  selected: widget.sn.isFoundCategories(value.eventCategoriesEntity.items[index].id!) != -1 ,
                                                  selectedColor: const Color(0xFFFFEEE9),
                                                  onSelected: (valueBool) {
                                                    setState(() {
                                                      widget.sn.changeCategories( value.eventCategoriesEntity.items[index].id!);
                                                    });
                                                  },
                                                  // backgroundColor: color,
                                                  elevation: 1,
                                                  backgroundColor: Colors.white,
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                                );
                                              }),
                                            ),
                                          ],
                                        );
                                      },
                                      eventOrginizerErrorState: (value) {
                                        return SizedBox(
                                          height: 0.2.sh,
                                          child: Center(
                                            child: ErrorScreenWidget(
                                                error: value.error, callback: value.callback),
                                          ),
                                        );
                                      },
                                      orElse: () => const SizedBox.shrink(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        // event date
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 1.sw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Padding(
                                  padding:  EdgeInsets.only(left: 2.0),
                                  child:  Text(Translation.current.Event_Date,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                                const SizedBox(height: 10,),
                                Wrap(
                                  spacing: 10,
                                  children: [
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 70,
                                        child: Center(
                                          child: Text(
                                            Translation.current.Multi_Day,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.eventDate == 0,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.eventDate == 0 ? widget.sn.eventDate = null : widget.sn.eventDate = 0;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                    ChoiceChip(
                                      labelPadding: const EdgeInsets.all(2.0),
                                      label: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        height: 40,
                                        width: 70,
                                        child: Center(
                                          child: Text(
                                            Translation.current.Single_Day,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black, fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFFFEEE9)
                                          )
                                      ),
                                      selected:widget.sn.eventDate == 1,
                                      selectedColor: const Color(0xFFFFEEE9),
                                      onSelected: (value) {
                                        setState(() {
                                          widget.sn.eventDate == 1 ? widget.sn.eventDate = null : widget.sn.eventDate = 1;
                                        });
                                      },
                                      // backgroundColor: color,
                                      elevation: 1,
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // button
                InkWell(
                  onTap: (){
                    widget.sn.getEvents();
                    Nav.pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    height: 50,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFFF5921)
                    ),
                    child: Center(
                      child: Text(Translation.current.view_details,style: TextStyle(fontSize: 16,color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
  Widget _buildEmptyWidget() {
    return SizedBox(
      height: 0.2.sh,
      child: Center(
        child: EmptyErrorScreenWidget(
          message: Translation.current.no_data,
          textColor: AppColors.white_text,
        ),
      ),
    );
  }
}
