import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/features/appointment/view/hospital_polyclinic_view.dart';
import 'package:hospital_app/features/home/cubit/home_cubit.dart';
import 'package:hospital_app/features/home/service/home_service.dart';
import 'package:hospital_app/features/home/view/patient_messages_view.dart';
import 'package:hospital_app/features/home/view/patient_question_view.dart';
import 'package:hospital_app/features/home/view/update_patient_info_view.dart';
import 'package:hospital_app/product/constants/product_box_decoration.dart';
import 'package:hospital_app/product/constants/product_button_styles.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/mixin/show_bottom_sheet.dart';
import 'package:hospital_app/product/widgets/buttons/exit_floating_action_button.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatelessWidget with ShowBottomSheet {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(BaseService(), HomeService()),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const ExitFloatingActionButton(),
        appBar: AppBar(
          title: Text(ProductStrings.instance.homeViewAppBarText),
          actions: [
            Padding(
              padding: const ProductPaddings.homeViewMBPadding(),
              child: _buildMessagesButton(),
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const ProductPaddings.bodyPadding(),
              child: _buildHome(context, state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHome(BuildContext context, HomeState state) {
    return Column(children: [
      _buildPatientContainer(context, state),
      Padding(
        padding: const ProductPaddings.homeLTileContainerPadding(),
        child: _buildListTileContainer(
          context,
          icon: Icons.question_mark,
          title: ProductStrings.instance.uzmanSoruTitle,
          subtitle: ProductStrings.instance.uzmanSoruSubtitle,
          onTap: () {
            showCustomSheet(context, const PatientQuestionView());
          },
        ),
      ),
      Padding(
        padding: const ProductPaddings.homeLTileContainerPadding(),
        child: _buildListTileContainer(
          context,
          icon: Icons.edit_calendar_rounded,
          title: ProductStrings.instance.randevuAlTitle,
          subtitle: ProductStrings.instance.randevuAlSubtitle,
          onTap: () {
            context.route.navigateToPage(const HospitalPolyclinicView(),
                type: SlideType.LEFT);
          },
        ),
      ),
      Expanded(child: Image.asset(ImagePaths.logo.getLogoPaths()))
    ]);
  }

  Widget _buildMessagesButton() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return IconButton(
            onPressed: () {
              context.route.navigateToPage(
                  PatientMessagesView(eposta: state.email ?? ""),
                  type: SlideType.LEFT);
            },
            icon: Badge(
                isLabelVisible:
                    ((state.patientMessages?.length ?? 0) > 0) ? true : false,
                child: const Icon(Icons.message)));
      },
    );
  }

  Widget _buildListTileContainer(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required void Function() onTap}) {
    return Container(
      alignment: Alignment.center,
      decoration: ProductBoxDecoration.homeLTileContainerBDecoration(),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListTile(
          onTap: () {
            onTap();
          },
          title: Text(
            title,
            style: context.general.textTheme.titleMedium,
          ),
          subtitle: Text(
            subtitle,
            style: context.general.textTheme.labelSmall,
          ),
          trailing: Icon(
            icon,
          )),
    );
  }

  Widget _buildPatientContainer(BuildContext context, HomeState state) {
    return Container(
      decoration: ProductBoxDecoration.patientContainerBDecoration(context),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 30,
                child: Image.asset(ImagePaths.hastaLogo.getLogoPaths()),
              ),
              Column(
                children: [
                  Text(
                      "${state.patientModel?.hastaAdi} ${state.patientModel?.hastaSoyadi}",
                      style: context.general.textTheme.titleMedium),
                  Text("${state.email}",
                      style: context.general.textTheme.titleSmall),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Kan Grubu: ${state.patientModel?.hastaKan}",
                  style: context.general.textTheme.titleMedium),
              FilledButton.tonal(
                  style: ProductButtonStyles.pUpdateInfoBStyle(),
                  onPressed: () {
                    context.route.navigateToPage(const UpdatePatientInfoView(),
                        type: SlideType.LEFT);
                  },
                  child: Row(
                    children: [
                      Text(ProductStrings.instance.pUpdateInfoBText,
                          style: context.general.textTheme.titleSmall),
                      const Icon(
                        size: 20,
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
