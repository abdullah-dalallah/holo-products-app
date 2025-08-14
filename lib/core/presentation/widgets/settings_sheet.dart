import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_products_app/constants/const_dimensions.dart';
import 'package:holo_products_app/constants/const_font_weights.dart';
import 'package:holo_products_app/constants/my_colors.dart';
import 'package:holo_products_app/core/presentation/widgets/base_text_widget.dart';
import 'package:holo_products_app/core/presentation/widgets/flutter_rating_bar.dart';
import 'package:holo_products_app/data/translation.dart';
import 'package:holo_products_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/presntation/bloc/theme_bloc.dart';
import 'package:holo_products_app/main.dart';

class SettingsSheet extends StatefulWidget{
  const SettingsSheet({super.key});

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {



  @override
  Widget build(BuildContext context) {
    return  StatefulBuilder(
      builder: (context, setState1,) {
        return  BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Container(
                    decoration:  BoxDecoration(
                        color: state.themeEntity?.themeType==ThemeType.dark?Colors.grey.shade800:MyColors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          elevation: 5,
                          // backgroundColor: Colors.white,
                          // surfaceTintColor: MyColors.white,
                          // shadowColor: Colors.transparent,
                          // shadowColor: MyColors.grey100.withOpacity(0.5),
                          automaticallyImplyLeading: false,
                          centerTitle: false,
                          title: BasicTextWidget(text: translation(context).settings, fontWeight: ConstFontWeights.semiBold, fontSize: ConstDimensions.semiBold16,),
                          actions: [
                            IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close)),
                          ],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(0),
                              top: Radius.circular(10), // Adjust this value for the curve size
                            ),
                          ),
                        ),
                        body:SafeArea(child: buildBody(context, state))
                    )
                );
        },
);

      },
    );
  }

  Widget buildBody(BuildContext context, ThemeState state){
    return Ink(
      // color: MyColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Ink(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: state.themeEntity?.themeType==ThemeType.dark?MyColors.grey400:MyColors.grey100 /* color-background-container */,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 0.50,
                    color: const Color(0xFFD4D4D8) /* color-stroke-divider */,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicTextWidget(text: translation(context).language,
                    fontWeight: ConstFontWeights.bold,
                    fontSize: ConstDimensions.bold14,
                    color: MyColors.grey900,
                    height: 1.33,
                  ),
                  RadioListTile<String>(
                    title: const BasicTextWidget(text: 'English',
                      fontWeight: ConstFontWeights.regular,
                      fontSize: ConstDimensions.regular14,
                      color: MyColors.black,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      height: 1.33,
                    ),
                    value: 'en',

                    groupValue: _selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value;
                        MyApp.of(context)?.setLocale(const Locale('en')); // Switch to English
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const BasicTextWidget(text: 'Arabic',
                      fontWeight: ConstFontWeights.regular,
                      fontSize: ConstDimensions.regular14,
                      color: MyColors.black,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      height: 1.33,
                    ),
                    value: 'ar',
                    groupValue: _selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value;
                        MyApp.of(context)?.setLocale(const Locale('ar')); // Switch to Arabic
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasicTextWidget(text: translation(context).appearance, fontWeight: ConstFontWeights.bold, fontSize: ConstDimensions.bold14,),
                    BasicTextWidget(text: translation(context).toggleToSwitchAppearance, fontWeight: ConstFontWeights.regular, fontSize: ConstDimensions.regular12,),
                  ],

                ),
                IconButton(onPressed: (){
                  context.read<ThemeBloc>().add(ToggleTheme());
                },icon: state.themeEntity?.themeType==ThemeType.dark?Icon(Icons.light_mode, ):Icon(Icons.dark_mode),)
              ],
            ),
          ),


          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [

                /// - Done Button
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.grey900,
                        foregroundColor: MyColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8),),

                        ),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: BasicTextWidget(text: translation(context).done,
                        fontWeight: ConstFontWeights.bold,
                        fontSize: ConstDimensions.regular14,
                        color: MyColors.white,
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        height: 1.33,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  String? _selectedLanguage;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedLanguage = translation(context).localeName;
      });
    });
  }
}