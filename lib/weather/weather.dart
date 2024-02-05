import 'package:flutter/material.dart';
import 'package:projects/weather/locale_provider.dart';
import 'package:projects/weather/models.dart';
import 'package:projects/weather/service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../app/all_locales.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleProvider>(
      create: (_) => LocaleProvider(),
      builder: (context, child) {
        return MaterialApp(
            title: 'weather',
            supportedLocales: AllLocales.all,
            locale: Provider.of<LocaleProvider>(context).locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: const ColorScheme.dark(),
              useMaterial3: true,
            ),

            home: const MyHomePage(
              title: Text('Погодник',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  )),
            ));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final Widget title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cityTextController = TextEditingController();
  final dataService = DataService();

  WeatherResponse? _response;

  void search() async{
    try {
      final response =
          await dataService.getWeather(cityTextController.text, context);

      setState(() => _response = response);
    } catch(e){
      throw ("Here's an error: ", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.appname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: const Alignment(-0.9, 0.9),
                      child: FloatingActionButton(
                        child: const Text("EN"),
                        onPressed: () => {
                          Provider.of<LocaleProvider>(context, listen: false)
                              .setLocale(AllLocales.all[0])
                        },
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.9, 0.9),
                      child: FloatingActionButton(
                        child: const Text("RU"),
                        onPressed: () => {
                          Provider.of<LocaleProvider>(context, listen: false)
                              .setLocale(AllLocales.all[1])
                        },
                      ),
                    ),
                  ],
                ), // Localisation
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_response != null)
                        Column(
                          children: [
                            Text(
                              cityTextController.text,
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              '${_response!.tempInfo.temperature}°',
                              style: const TextStyle(
                                  fontSize: 40, color: Colors.white),
                            ),
                            Text(
                              _response!.weatherInfo.description,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            Image.network(_response!.iconUrl),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: SizedBox(
                          width: 150,
                          child: TextField(
                              controller: cityTextController,
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!
                                      .city
                                      .toString(),
                                  labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: search,
                        child: Text(
                            AppLocalizations.of(context)!.search.toString()),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
