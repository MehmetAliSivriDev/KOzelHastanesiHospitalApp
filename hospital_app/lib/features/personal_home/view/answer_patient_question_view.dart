import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/features/personal_home/cubit/personal_home_cubit.dart';
import 'package:hospital_app/features/personal_home/model/doctor_answer_model.dart';
import 'package:hospital_app/features/personal_home/service/personal_home_service.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_durations.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/widgets/buttons/divider_close_button.dart';
import 'package:kartal/kartal.dart';

import '../../../product/constants/product_colors.dart';

// ignore: must_be_immutable
class AnswerPatientQuestionView extends StatelessWidget {
  AnswerPatientQuestionView({super.key, required this.polyclinicName});

  final String polyclinicName;

  PageController _pageController = PageController(initialPage: 0);

  List<TextEditingController> answerControllers = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PersonalHomeCubit(BaseService(), PersonalHomeService(), context)
            ..getDoctorId()
            ..getPatientQuestionsWithPolyclinic(polyclinicName),
      child: BlocBuilder<PersonalHomeCubit, PersonalHomeState>(
        builder: (context, state) {
          if (state.questions == null || state.questions?.length == 0) {
            return _buildNoQuestionBox(context);
          } else {
            return _buildQuestions(context, state);
          }
        },
      ),
    );
  }

  Widget _buildQuestions(BuildContext context, PersonalHomeState state) {
    return AnimatedSize(
      duration: ProductDurations.imageRowDuration,
      child: SizedBox(
        height: context.general.isKeyBoardOpen
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            const DividerCloseButton(),
            Text("$polyclinicName Soruları",
                style: context.general.textTheme.titleLarge),
            _buildMainCards(state),
            _buildPageButtons()
          ],
        ),
      ),
    );
  }

  Widget _buildPageButtons() {
    return Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FilledButton(
                onPressed: () {
                  _pageController.previousPage(
                      duration: ProductDurations.passTxtFieldDuration,
                      curve: Curves.linear);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            FilledButton(
                onPressed: () {
                  _pageController.nextPage(
                      duration: ProductDurations.passTxtFieldDuration,
                      curve: Curves.linear);
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ))
          ],
        ));
  }

  Widget _buildMainCards(PersonalHomeState state) {
    return Expanded(
      flex: 5,
      child: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: state.questions?.length ?? 5,
        itemBuilder: (context, index) {
          answerControllers.add(TextEditingController());
          return _buildCard(context, state, index);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, PersonalHomeState state, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const ProductPaddings.bodyPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const ProductPaddings.pmCardPadding(),
                child: _buildQuestionRow(
                    context,
                    state.questions?[index].soru ?? "",
                    "- ${state.questions?[index].hastaEposta}"),
              ),
              Padding(
                padding: const ProductPaddings.pmCardPadding(),
                child: _buildAnswerTF(index),
              ),
              _answerButton(index, context, state)
            ],
          ),
        ),
      ),
    );
  }

  Widget _answerButton(
      int index, BuildContext context, PersonalHomeState state) {
    return AnimatedOpacity(
      duration: ProductDurations.imageRowDuration,
      opacity: context.general.isKeyBoardOpen ? 0 : 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(
              onPressed: () {
                if (answerControllers[index].text.isEmpty ||
                    answerControllers[index].text == "") {
                  AlertDialog alertDialog = _buildAnswerAD(context);

                  showDialog(context: context, builder: (_) => alertDialog);
                } else {
                  var model = DoctorAnswerModel(
                      doktorId: state.doctorId.toString(),
                      hastaEposta: state.questions?[index].hastaEposta,
                      poliklinik: state.questions?[index].poliklinik,
                      soru: state.questions?[index].soru,
                      cevap: answerControllers[index].text);

                  context.read<PersonalHomeCubit>().postDoctorAnswer(model);
                }
              },
              child: Row(
                children: [
                  Text(ProductStrings.instance.apqwAnswerBText,
                      style: context.general.textTheme.titleMedium),
                  const Icon(
                    Icons.question_answer,
                    color: Colors.white,
                  ),
                ],
              ))
        ],
      ),
    );
  }

  AlertDialog _buildAnswerAD(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(ProductStrings.instance.apqwADTitleText),
      content: Text(ProductStrings.instance.apqwADContentText),
      actions: [
        FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              ProductStrings.instance.apqwADButtonText,
              style: context.general.textTheme.titleMedium,
            ))
      ],
    );
    return alertDialog;
  }

  Widget _buildAnswerTF(int index) {
    return TextField(
        controller: answerControllers[index],
        maxLines: 4,
        decoration: InputDecoration(
            hintText: ProductStrings.instance.apqwTFHintText,
            border: const OutlineInputBorder(
                borderRadius: ProductBorderRadius.dropdownBRadius())));
  }

  Widget _buildNoQuestionBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          const DividerCloseButton(),
          Padding(
            padding: const ProductPaddings.homeLTileContainerPadding(),
            child: Text("Herhangi Bir Soru Bulunmamaktadır.",
                style: context.general.textTheme.headlineSmall),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionRow(BuildContext context, String message, String name) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card(
        color: ProductColors.instance.seconRed,
        child: Padding(
          padding: const ProductPaddings.appointmentContentExpPadding(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: context.general.textTheme.bodyMedium,
                    ),
                    Text(
                      name,
                      style: context.general.textTheme.titleSmall,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
