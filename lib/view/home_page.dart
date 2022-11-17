import 'package:flutter/material.dart';
import 'package:search_case_project/models/exercise.dart';
import 'package:search_case_project/view_models/general_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  GeneralViewModel generalViewModel = GeneralViewModel();


  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.delete),
          onPressed: () async {
            
            generalViewModel.selectedMuscle = "";
            generalViewModel.selectedType = "";

            searchController.clear();

            setState(() {});
          }),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            collapsedHeight: 100,
            pinned: false,
            snap: false,
            stretch: false,
            floating: true,
            toolbarHeight: 0,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: SizedBox(
                height: 120,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: musclesListView(),
                    ),
                    SizedBox(
                      height: 40,
                      child: typesListView(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.top,
                        controller: searchController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)))),
                        onChanged: (value) async {
                          await generalViewModel.getExercises(
                              muscle: generalViewModel.selectedMuscle,
                              type: generalViewModel.selectedType,
                              name: value);

                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Exercise exercise = generalViewModel.exercises[index];

                return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Text(exercise.name),
                        Container(
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: Text(exercise.type),
                        ),
                        Text(exercise.muscle)
                      ],
                    ));
              },
              childCount: generalViewModel.exercises.length,
            ),
          ),
        ],
      ),
    );
  }

  ListView typesListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: generalViewModel.types.length,
        itemBuilder: (context, index) {
          String type = generalViewModel.types[index];

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilterChip(
                labelPadding: const EdgeInsets.all(2),
                selected: generalViewModel.selectedType ==
                    generalViewModel.types[index],
                label: Text(
                  type,
                  style: const TextStyle(fontSize: 10),
                ),
                onSelected: (val) async {
                  generalViewModel.selectedType = generalViewModel.types[index];

                  await generalViewModel.getExercises(
                      muscle: generalViewModel.selectedMuscle,
                      type: generalViewModel.selectedType);

                  setState(() {});
                }),
          );
        });
  }

  ListView musclesListView() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: generalViewModel.muscles.length,
        itemBuilder: (context, index) {
          String muscle = generalViewModel.muscles[index];

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilterChip(
                labelPadding: const EdgeInsets.all(2),
                selected: generalViewModel.selectedMuscle ==
                    generalViewModel.muscles[index],
                label: Text(
                  muscle,
                  style: const TextStyle(fontSize: 10),
                ),
                onSelected: (val) async {
                  generalViewModel.selectedMuscle =
                      generalViewModel.muscles[index];

                  await generalViewModel.getExercises(
                      muscle: generalViewModel.selectedMuscle,
                      type: generalViewModel.selectedType);

                  setState(() {});
                }),
          );
        });
  }
}
