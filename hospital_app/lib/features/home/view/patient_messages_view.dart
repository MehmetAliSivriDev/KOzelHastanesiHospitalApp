import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/features/home/cubit/home_cubit.dart';
import 'package:hospital_app/features/home/service/home_service.dart';
import 'package:hospital_app/product/constants/product_colors.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/widgets/info_card.dart';
import 'package:kartal/kartal.dart';

class PatientMessagesView extends StatelessWidget {
  const PatientMessagesView({super.key, required this.eposta});

  final String eposta;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(BaseService(), HomeService()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(ProductStrings.instance.pmViewAppBarText),
        ),
        body: Padding(
          padding: const ProductPaddings.bodyPadding(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.patientMessages == null ||
                  state.patientMessages?.length == 0) {
                return _buildNoMessageText(context);
              } else {
                return _buildMessages(context, state);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNoMessageText(BuildContext context) {
    return Center(
      child: Text(
        ProductStrings.instance.pmViewNoMessageText,
        style: context.general.textTheme.titleLarge,
      ),
    );
  }

  Widget _buildMessages(BuildContext context, HomeState state) {
    return Column(
      children: [
        Padding(
          padding: const ProductPaddings.infoCardPadding(),
          child: InfoCard(
            text: ProductStrings.instance.pmViewInfoCardText,
          ),
        ),
        Expanded(child: _buildMessageCards(state))
      ],
    );
  }

  Widget _buildMessageCards(HomeState state) {
    return ListView.builder(
      itemCount: state.patientMessages?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const ProductPaddings.pmCardPadding(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.black,
              elevation: 10,
              child: Padding(
                padding: const ProductPaddings.appointmentContentExpPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.patientMessages?[index].poliklinik ?? "",
                      style: context.general.textTheme.headlineMedium,
                    ),
                    const Divider(
                      thickness: 0.2,
                    ),
                    Padding(
                      padding:
                          const ProductPaddings.appointmentContentExpPadding(),
                      child: _buildPatientMessageRow(context, state, index),
                    ),
                    Padding(
                      padding:
                          const ProductPaddings.appointmentContentExpPadding(),
                      child: _buildDoctorMessageRow(context, state, index),
                    ),
                    Image.asset(ImagePaths.logo.getLogoPaths())
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctorMessageRow(
      BuildContext context, HomeState state, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Card(
        color: ProductColors.instance.successGreen,
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
                      state.patientMessages?[index].cevap ?? "",
                      style: context.general.textTheme.bodyMedium,
                    ),
                    Text(
                      "-Dr.${state.patientMessages?[index].doktorAdi} ${state.patientMessages?[index].doktorSoyadi}",
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

  Widget _buildPatientMessageRow(
      BuildContext context, HomeState state, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Card(
            color: ProductColors.instance.mainRed,
            child: Padding(
              padding: const ProductPaddings.appointmentContentExpPadding(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          state.patientMessages?[index].hastaSoru ?? "",
                          style: context.general.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_left),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
