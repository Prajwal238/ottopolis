import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ottopolis/cubit/internet_cubit.dart';
import 'package:ottopolis/repo/show_repo.dart';
import 'package:ottopolis/model/show_model.dart';
import 'package:ottopolis/bloc/show_bloc.dart';
import 'package:ottopolis/bloc/show_event.dart';
import 'package:ottopolis/bloc/show_state.dart';
import 'package:provider/provider.dart';

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
        title: 'Flutter Demo',
        theme: ThemeData(
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
            return const Center(
              child: Icon(
                Icons.signal_wifi_connected_no_internet_4_outlined,
                size: 45,
                // color: Colors.blue,
              ),
            );
          } else {
            if (state is ShowIsNotSearched) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ConfigReader.getSecretMesssage(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: showNameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white70,
                            ),
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
                  )
                ],
              );
            } else if (state is ShowIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
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
      inspect(shows);
      log("inside widget: ${shows?[0].show?.img?.original.toString()}");
      return ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return ListTile(
              title: shows?[index].show?.img?.original.toString() != null
                  ? Image.network(shows![index].show!.img!.original.toString())
                  : const Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Title: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(shows?[index].show?.name.toString() ?? "null", style: const TextStyle(color: Colors.white))
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Rating: ", style: TextStyle(color: Colors.white)),
                      Text(shows?[index].show?.rating?.average.toString() ?? "null",
                          style: const TextStyle(color: Colors.white))
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Genres: ", style: TextStyle(color: Colors.white)),
                      Text(shows?[index].show?.genres?.join(",") ?? "null", style: const TextStyle(color: Colors.white))
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Streaming On: ", style: TextStyle(color: Colors.white)),
                      Text(shows?[index].show?.webChannel?.officialSite.toString()  ?? (shows?[index].show?.network?.name.toString() ?? "null"),
                          style: const TextStyle(color: Colors.white))
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: shows!.length);
    }
    return Container();
  }
}
