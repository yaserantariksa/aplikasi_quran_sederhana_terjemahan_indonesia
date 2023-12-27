import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplikasi_quran/models/surah_model.dart';
import 'package:aplikasi_quran/themes/themes.dart';

class SurahPage extends StatelessWidget {
  final int id;

  const SurahPage({super.key, required this.id});

  Future<SurahModel> getSurah() async {
    String res = await rootBundle.loadString('assets/quran_data/$id.json');
    dynamic surahObject = await jsonDecode(res);
    SurahModel surahData = SurahModel.fromJson(surahObject);

    return surahData;
  }

  @override
  Widget build(BuildContext context) {
    MyThemes myThemes = MyThemes();

    return Scaffold(
      body: FutureBuilder(
        future: getSurah(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: myThemes.primaryColor,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  floating: true,
                  pinned: true,
                  title: Text(
                    snapshot.data!.name,
                    style: myThemes.arabText.copyWith(fontSize: 38),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'Surat : ${snapshot.data!.transliteration} (${snapshot.data!.translation}) | ${snapshot.data!.totalVerses.toString()} ayat',
                            style: myThemes.bodyText
                                .copyWith(fontSize: 14, color: Colors.white),
                          ),
                        )),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 18,
                  ),
                ),
                if(snapshot.data!.id != 1) SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيم',
                      textAlign: TextAlign.center,
                      style: myThemes.arabText.copyWith(
                        color: myThemes.primaryColor,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                if(snapshot.data!.id != 1) const SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                SliverList.builder(
                  itemCount: snapshot.data!.verses.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: myThemes.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              snapshot.data!.verses[index].id.toString(),
                              style: myThemes.headerText
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data!.verses[index].text,
                                  style: myThemes.arabText.copyWith(
                                    color: myThemes.primaryColor,
                                    fontSize: 35,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                Text(
                                  '"${snapshot.data!.verses[index].translation}"',
                                  style: myThemes.bodyText.copyWith(
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 18,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
