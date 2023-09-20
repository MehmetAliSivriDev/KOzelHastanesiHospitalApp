import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/features/personal_home/cubit/personal_home_cubit.dart';
import 'package:hospital_app/features/personal_home/service/personal_home_service.dart';
import 'package:hospital_app/features/personal_home/view/answer_patient_question_view.dart';
import 'package:hospital_app/product/constants/product_grid_delegate.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/mixin/show_bottom_sheet.dart';
import 'package:hospital_app/product/widgets/lottie_loading.dart';
import 'package:kartal/kartal.dart';

class PolyclinicForQuestionsView extends StatelessWidget with ShowBottomSheet {
  const PolyclinicForQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PersonalHomeCubit(BaseService(), PersonalHomeService(), context)
            ..fetchPolyclinics(),
      child: Scaffold(
        appBar: _buildCustomAppBar(),
        body: BlocBuilder<PersonalHomeCubit, PersonalHomeState>(
          builder: (context, state) {
            return state.isLoading == true
                ? const LottieLoading()
                : _buildPolyclinics(state);
          },
        ),
      ),
    );
  }

  Widget _buildPolyclinics(PersonalHomeState state) {
    return GridView.builder(
      padding: const ProductPaddings.bodyPadding(),
      gridDelegate: ProductGridDelegate.instance.pfqwPolyclinics,
      itemCount: state.polyclinics?.length ?? 0,
      itemBuilder: (context, index) {
        return _buildPolyclinicCard(state, index, context);
      },
    );
  }

  Widget _buildPolyclinicCard(
      PersonalHomeState state, int index, BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const ProductPaddings.bodyPadding(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.polyclinics?[index].polikilinikAdi ?? "",
                style: context.general.textTheme.titleLarge,
              ),
              _buildPolyclinicSButton(context, state, index)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolyclinicSButton(
      BuildContext context, PersonalHomeState state, int index) {
    return FilledButton.icon(
        onPressed: () {
          showCustomSheet(
              context,
              AnswerPatientQuestionView(
                  polyclinicName:
                      state.polyclinics?[index].polikilinikAdi ?? ""));
        },
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        label: Text(
          ProductStrings.instance.pfqwPolyclinicSButton,
          style: context.general.textTheme.titleMedium,
        ));
  }

  PreferredSize _buildCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: BlocBuilder<PersonalHomeCubit, PersonalHomeState>(
        builder: (context, state) {
          return WillPopScope(
              onWillPop: () async {
                if (state.isLoading == true) {
                  return false;
                } else {
                  return true;
                }
              },
              child: AppBar(
                title: Text(ProductStrings.instance.pfqwAppBarText),
              ));
        },
      ),
    );
  }
}
