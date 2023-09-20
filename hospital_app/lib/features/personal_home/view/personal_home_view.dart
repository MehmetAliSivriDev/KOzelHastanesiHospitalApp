import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/features/personal_home/cubit/personal_home_cubit.dart';
import 'package:hospital_app/features/personal_home/service/personal_home_service.dart';
import 'package:hospital_app/features/personal_home/view/polyclinic_for_questions_view.dart';
import 'package:hospital_app/product/constants/product_box_decoration.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/widgets/buttons/exit_floating_action_button.dart';
import 'package:kartal/kartal.dart';

class PersonalHomeView extends StatelessWidget {
  const PersonalHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PersonalHomeCubit(BaseService(), PersonalHomeService(), context)
            ..initalComplete(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const ExitFloatingActionButton(),
        appBar: AppBar(
          title: Text(ProductStrings.instance.homeViewAppBarText),
        ),
        body: BlocBuilder<PersonalHomeCubit, PersonalHomeState>(
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

  Widget _buildHome(BuildContext context, PersonalHomeState state) {
    return Column(
      children: [
        _buildDoctorContainer(context, state),
        Padding(
          padding: const ProductPaddings.homeLTileContainerPadding(),
          child: _buildQuestionsListTile(context),
        ),
        Expanded(child: Image.asset(ImagePaths.logo.getLogoPaths()))
      ],
    );
  }

  Widget _buildQuestionsListTile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      alignment: Alignment.center,
      decoration: ProductBoxDecoration.homeLTileContainerBDecoration(),
      child: ListTile(
        onTap: () {
          context.route.navigateToPage(const PolyclinicForQuestionsView(),
              type: SlideType.LEFT);
        },
        title: Text(
          ProductStrings.instance.phwQLTileTitleText,
          style: context.general.textTheme.titleMedium,
        ),
        subtitle: Text(
          ProductStrings.instance.phwQLTileSubtitleText,
          style: context.general.textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.question_answer),
      ),
    );
  }

  Widget _buildDoctorContainer(BuildContext context, PersonalHomeState state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: ProductBoxDecoration.patientContainerBDecoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ProductStrings.instance.phwDContainerWelcomeText,
            style: context.general.textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Dr. ${state.doctorModel?.doktorAdi} ${state.doctorModel?.doktorSoyadi}",
            style: context.general.textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${state.doctorModel?.doktorEposta}",
            style: context.general.textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
