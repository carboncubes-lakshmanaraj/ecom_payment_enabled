import 'package:flutter/material.dart';

class SelectableImageContainers extends StatefulWidget {
  @override
  _SelectableImageContainersState createState() =>
      _SelectableImageContainersState();
}

class _SelectableImageContainersState extends State<SelectableImageContainers> {
  int selectedIndex = -1;

  final List<Map<String, String>> items = [
    {'image': 'assets/visa.png', 'label': 'Item 1'},
    {'image': 'assets/apple.png', 'label': 'Item 2'},
    {'image': 'assets/paypal.png', 'label': 'Item 3'},
    {'image': 'assets/maestro.png', 'label': 'Item 4'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(items.length, (index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 600,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color:
                            selectedIndex == index
                                ? Colors.red
                                : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            item['image']!,
                            width: 40,
                            height: 40,
                            errorBuilder:
                                (_, __, ___) => Icon(Icons.broken_image),
                          ),
                          Spacer(),
                          Text(
                            item['label']!,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
