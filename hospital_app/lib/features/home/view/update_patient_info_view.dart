import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/features/home/cubit/home_cubit.dart';
import 'package:hospital_app/features/home/service/home_service.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/widgets/buttons/continue_button.dart';
import 'package:hospital_app/product/widgets/info_card.dart';
import 'package:intl/intl.dart';

class UpdatePatientInfoView extends StatefulWidget {
  const UpdatePatientInfoView({super.key});

  @override
  State<UpdatePatientInfoView> createState() => _UpdatePatientInfoViewState();
}

class _UpdatePatientInfoViewState extends State<UpdatePatientInfoView> {
  String? _selectedValueBlood;
  String? _selectedValueGender;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _birthPlaceController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();

  final List<String> _bloods = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "0+",
    "0-"
  ];
  final List<String> _genders = ["Erkek", "Kız"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(BaseService(), HomeService()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(ProductStrings.instance.upiViewAppBarText),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const ProductPaddings.bodyPadding(),
              child: _buildUpdatePatientInfo(state, context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUpdatePatientInfo(HomeState state, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const ProductPaddings.infoCardPadding(),
            child: InfoCard(text: ProductStrings.instance.upiViewInfoText),
          ),
          Padding(
            padding: const ProductPaddings.pmCardPadding(),
            child: _buildPhoneTF(state),
          ),
          Padding(
            padding: const ProductPaddings.pmCardPadding(),
            child: _buildAdressTF(state),
          ),
          Padding(
            padding: const ProductPaddings.pmCardPadding(),
            child: _buildBirthPlaceTF(state),
          ),
          Padding(
            padding: const ProductPaddings.pmCardPadding(),
            child: _buildBirthDateTF(state, context),
          ),
          Padding(
            padding: const ProductPaddings.pmCardPadding(),
            child: _buildBloodTypeDD(state),
          ),
          Padding(
            padding: const ProductPaddings.pmCardPadding(),
            child: _buildGenderDD(state),
          ),
          Padding(
            padding: const ProductPaddings.pmCardPadding(),
            child: ContinueButton(
              onPressed: () {
                context.read<HomeCubit>().updatePatientInfo(
                    context,
                    state.email!,
                    ((_phoneController.text.isNotEmpty)
                            ? _phoneController.text
                            : state.patientModel?.hastaTelefon) ??
                        "",
                    ((_adressController.text.isNotEmpty)
                            ? _adressController.text
                            : state.patientModel?.hastaAdress) ??
                        "",
                    ((_birthPlaceController.text.isNotEmpty)
                            ? _birthPlaceController.text
                            : state.patientModel?.hastaDogumYeri) ??
                        "",
                    ((_birthDateController.text.isNotEmpty)
                        ? _birthDateController.text
                        : state.patientModel?.hastaDogumTarihi)!,
                    _selectedValueBlood ?? state.patientModel!.hastaKan!,
                    _selectedValueGender ?? state.patientModel!.hastaCinsiyet!);
              },
            ),
          ),
          Image.asset(ImagePaths.logo.getLogoPaths())
        ],
      ),
    );
  }

  Widget _buildGenderDD(HomeState state) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          icon: const Icon(Icons.people),
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.dropdownBRadius()),
          hintText: (state.patientModel?.hastaCinsiyet == null ||
                  state.patientModel?.hastaCinsiyet == "")
              ? "Cinsiyet"
              : (state.patientModel?.hastaCinsiyet == "0")
                  ? "Erkek"
                  : "Kız"),
      value: _selectedValueGender,
      items: _genders.map((gender) {
        return DropdownMenuItem(value: gender, child: Text(gender));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValueGender = value;
        });
      },
    );
  }

  Widget _buildBloodTypeDD(HomeState state) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          icon: const Icon(Icons.bloodtype),
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.dropdownBRadius()),
          hintText: (state.patientModel?.hastaKan == null ||
                  state.patientModel?.hastaKan == "")
              ? "Kan Grubu"
              : state.patientModel?.hastaKan),
      value: _selectedValueBlood,
      items: _bloods.map((blood) {
        return DropdownMenuItem(value: blood, child: Text(blood));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValueBlood = value;
        });
      },
    );
  }

  Widget _buildBirthDateTF(HomeState state, BuildContext context) {
    return TextField(
      controller: _birthDateController,
      readOnly: true,
      decoration: InputDecoration(
          icon: const Icon(Icons.calendar_today),
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.dropdownBRadius()),
          hintText: (state.patientModel?.hastaDogumTarihi == null ||
                  state.patientModel?.hastaDogumTarihi == "")
              ? "Doğum Tarihi"
              : state.patientModel?.hastaDogumTarihi),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            _birthDateController.text = formattedDate;
          });
        } else {}
      },
    );
  }

  Widget _buildBirthPlaceTF(HomeState state) {
    return TextField(
      controller: _birthPlaceController,
      decoration: InputDecoration(
          icon: const Icon(Icons.person_pin_circle_sharp),
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.dropdownBRadius()),
          hintText: (state.patientModel?.hastaDogumYeri == null ||
                  state.patientModel?.hastaDogumYeri == "")
              ? "Doğum Yeri (İsteğe Bağlı)"
              : state.patientModel?.hastaDogumYeri),
    );
  }

  Widget _buildAdressTF(HomeState state) {
    return TextField(
      controller: _adressController,
      decoration: InputDecoration(
          icon: const Icon(Icons.place),
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.dropdownBRadius()),
          hintText: (state.patientModel?.hastaAdress == null ||
                  state.patientModel?.hastaAdress == "")
              ? "Adres Bilgileri (İsteğe Bağlı)"
              : state.patientModel?.hastaAdress),
    );
  }

  Widget _buildPhoneTF(HomeState state) {
    return TextField(
        keyboardType: TextInputType.phone,
        controller: _phoneController,
        decoration: InputDecoration(
          icon: const Icon(Icons.phone),
          border: const OutlineInputBorder(
              borderRadius: ProductBorderRadius.dropdownBRadius()),
          hintText: (state.patientModel?.hastaTelefon == null ||
                  state.patientModel?.hastaTelefon == "")
              ? "Telefon Numarası (İsteğe Bağlı)"
              : state.patientModel?.hastaTelefon,
        ));
  }
}
