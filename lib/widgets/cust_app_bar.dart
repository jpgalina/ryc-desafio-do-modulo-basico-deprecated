import 'package:challenge/models/resource_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustAppBar extends StatelessWidget {
  CustAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final rl = Provider.of<ResourceList>(context);

    List<Widget> generateHearts() {
      List<Widget> list = [];
      for (var i = 0; i < rl.lives; i++) {
        list.add(const Icon(
          Icons.favorite,
          color: Colors.red,
          size: 50,
        ));
      }
      for (var j = 0; j < 5 - rl.lives; j++) {
        list.add(const Icon(
          Icons.favorite,
          color: Colors.grey,
          size: 50,
        ));
      }
      return list;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(
              'lib/assets/images/profile-icon.png',
              height: 100,
              width: 100,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: generateHearts(),
            ),
            SizedBox(
              width: 235,
              child: Row(
                children: [
                  Icon(
                    Icons.currency_bitcoin,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 35,
                  ),
                  Text(
                    rl.coins > 0 ? '${rl.coins} Coins' : '0 Coins',
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
