import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ottopolis/cubit/internet_cubit.dart';
import 'package:ottopolis/repo/show_repo.dart';
import 'package:ottopolis/model/show_model.dart';
import 'package:ottopolis/bloc/show_bloc.dart';
import 'package:ottopolis/bloc/show_event.dart';
import 'package:ottopolis/bloc/show_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config_reader.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowBloc(
            ShowRepo(),
            internetCubit: InternetCubit(connectivity: Connectivity()),
          ),
        ),
        BlocProvider(
          create: (context) => InternetCubit(connectivity: Connectivity()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: Provider.of<bool>(context),
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(),
          primarySwatch: Provider.of<MaterialColor?>(context),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final showBloc = BlocProvider.of<ShowBloc>(context);
    var showNameController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          log(state.toString());
          if (state is InternetConnectionLost) {
            return Center(
              child: Icon(
                Icons.signal_wifi_connected_no_internet_4_outlined,
                size: 45,
                color: Provider.of<MaterialColor?>(context),
              ),
            );
          } else {
            if (state is ShowIsNotSearched) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "OTTOPOLIS",
                          style: GoogleFonts.rubikGlitch(fontSize: 65, color: Provider.of<MaterialColor?>(context)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            ConfigReader.getSecretMesssage(),
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: showNameController,
                                  decoration: const InputDecoration(
                                    // prefixIcon: Icon(
                                    //   Icons.search,
                                    //   color: Colors.white70,
                                    // ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(color: Colors.white70, style: BorderStyle.solid)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid)),
                                    hintText: "Search",
                                    hintStyle: TextStyle(color: Colors.white70),
                                  ),
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      log(showNameController.text);
                                      showBloc.add(FetchShows(showNameController.text));
                                    },
                                    child: const Icon(Icons.search)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Lottie.asset('assets/ottopolis-movie-animation.json')
                ],
              );
            } else if (state is ShowIsLoading) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Lottie.asset('assets/ottopolis-loading-animation.json'),
                ),
              );
            } else if (state is ShowIsLoaded) {
              log("inside ShowIsLoaded state");
              return ShowTemplates(shows: state.getShowDetails, showName: showNameController.text);
            } else {
              return const Icon(Icons.error);
            }
          }
        },
      ),
    );
  }
}

class ShowTemplates extends StatelessWidget {
  final List<ShowModel>? shows;
  final String? showName;

  const ShowTemplates({Key? key, this.shows, this.showName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shows != null) {
      if (shows!.isNotEmpty) {
        inspect(shows);
        log("inside widget: ${shows?[0].show?.img?.original.toString()}");
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Row(
                children: [
                  Icon(Icons.search, color: Provider.of<MaterialColor?>(context), size: 70,),
                  const Text("Search Results", style: TextStyle(color: Colors.white, fontSize: 35,),
                  textAlign: TextAlign.start,)
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: ListTile(
                        leading: shows?[index].show?.img?.original.toString() != null
                            ? SizedBox(
                                height: 200,
                                width: 80,
                                child: Image.network(
                                  shows![index].show!.img!.original.toString(),
                                  fit: BoxFit.cover,
                                  scale: 1,
                                ),
                              )
                            : const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(shows?[index].show?.name.toString() ?? "null",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.fade),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Rating: ", style: TextStyle(color: Colors.white)),
                                Expanded(
                                  child: Text(shows?[index].show?.rating?.average.toString() ?? "null",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.fade),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Genres: ", style: TextStyle(color: Colors.white)),
                                Expanded(
                                  child: Text(shows?[index].show?.genres?.join(",") ?? "null",
                                      style: const TextStyle(color: Colors.white),
                                      softWrap: false,
                                      overflow: TextOverflow.fade),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text("Streaming On: ", style: TextStyle(color: Colors.white)),
                                Expanded(
                                  child: Text(
                                      shows?[index].show?.webChannel?.officialSite.toString() ??
                                          (shows?[index].show?.network?.name.toString() ?? "null"),
                                      style: const TextStyle(color: Colors.white),
                                      softWrap: false,
                                      overflow: TextOverflow.fade),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 1,
                      ),
                  itemCount: shows!.length),
            ),
          ],
        );
      } else {
        log("${shows}here in else");
        return const Center(
            child: Text(
          ":( Uh-Oh! No results found",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ));
      }
    }
    return Container();
  }
}
