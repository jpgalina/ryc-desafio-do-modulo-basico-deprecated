import 'package:challenge/models/resource_list.dart';
import 'package:challenge/widgets/cust_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resourceList = Provider.of<ResourceList>(context);
    bool maxlives = resourceList.lives < 5 ? false : true;

    Future<dynamic> confirmPurchase() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            maxlives ? 'Health points full' : 'Are you sure?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            maxlives
                ? 'You can\'t purchase another health point'
                : 'Would you like to buy this?',
          ),
          actions: [
            if (!maxlives)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
            TextButton(
              onPressed: () {
                if (!maxlives) {
                  resourceList.buyLife();
                }
                Navigator.of(context).pop(true);
              },
              child: Text(maxlives ? 'Close' : 'Yes'),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
        child: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 40),
            child: CustAppBar(),
          ),
        ),
      ),
      body: Card(
        margin: EdgeInsets.all(15),
        child: Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    'lib/assets/images/Potion.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Potion',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Restores 1 Health Point')
                ],
              ),
              VerticalDivider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      confirmPurchase();
                    },
                    icon: Icon(
                      Icons.shopping_cart_checkout,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 35,
                    ),
                  ),
                  Text('5 coins'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
