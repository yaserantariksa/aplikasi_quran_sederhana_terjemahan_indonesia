import 'dart:convert';
import 'package:aplikasi_quran/pages/surah_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplikasi_quran/models/quran_model.dart';
import 'package:aplikasi_quran/themes/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MyThemes myThemes = MyThemes();

    Future<List<QuranModel>> getQuranData() async {
      String res = await rootBundle.loadString('assets/quran_data/index.json');
      List<dynamic> quranObject = await jsonDecode(res);
      List<QuranModel> quranData =
          quranObject.map((s) => QuranModel.fromJson(s)).toList();
      return quranData;
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          "Qur'an Terjemahan Indonesia",
          style: myThemes.headerText,
        ),
        backgroundColor: myThemes.primaryColor,
        foregroundColor: Colors.white,
        shadowColor: myThemes.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: FutureBuilder(
          future: getQuranData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 18),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahPage(
                          id: snapshot.data![index].id,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: myThemes.primaryColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                snapshot.data![index].id.toString(),
                                style: myThemes.headerText.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].transliteration,
                                  style: myThemes.headerText.copyWith(
                                    color: myThemes.primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data![index].type} | ${snapshot.data![index].totalVerses} ayat',
                                  style: myThemes.bodyText
                                      .copyWith(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                        Text(
                          snapshot.data![index].name,
                          style: myThemes.arabText.copyWith(
                            fontSize: 35,
                            color: myThemes.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
