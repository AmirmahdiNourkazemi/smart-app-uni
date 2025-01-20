import 'package:flutter/material.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';

Widget buildInfoContainer(
    BuildContext context, bool isDesktop, Project project) {
  List<Widget> propertyWidgets = [];

  // Add a divider between each property
  void addDivider() {
    propertyWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Divider(
          color: Colors.grey.shade200,
          thickness: 0.4,
        ),
      ),
    );
  }

  // Iterate through the "properties" and add corresponding widgets
  for (var property in project.properties ?? []) {
    //addDivider();
    // Add a divider before each property
    propertyWidgets.addAll([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              property['value'].toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              property['key'].toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    ]);
    addDivider();
  }

  // Add a divider after the last property

  return Column(
    children: [
      // ... existing code
      if (project.properties!.isNotEmpty) ...{
        Padding(
          padding: const EdgeInsets.only(top: 0, right: 20, bottom: 10),
          child: Text(
            'سایر اطلاعات',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          width: isDesktop ? MediaQuery.of(context).size.width * 0.2 : null,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.grey.shade300),
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ... existing code

              // Replace static properties with dynamic ones
              ...propertyWidgets,

              // ... existing code
            ],
          ),
        ),
      }
    ],
  );
}
