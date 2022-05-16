import 'package:flutter/material.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: Text('Nenhuma Imagem!'),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera),
                Text('Tirar Foto'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
