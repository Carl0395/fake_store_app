import 'dart:io';

import 'package:fake_store_app/models/product_model.dart';
import 'package:fake_store_app/repository/products_repository.dart';

final repository = ProductsRepository();
void main(List<String> arguments) async {
  runApp();
}

void runApp() async {
  while (true) {
    print("\n=== Menú Principal ===");
    print("1. Obtener productos");
    print("2. Crear producto (Valores por defecto)");
    print("3. Obtener carts");
    print("4. Salir");
    stdout.write("Seleccione una opción: ");

    String? input = stdin.readLineSync();
    if (input == null) {
      print("Entrada no válida, intente de nuevo.");
      continue;
    }

    switch (input) {
      case '1':
        await getProducts();
        break;
      case '2':
        await createProduct();
        break;
      case '3':
        await getCarts();
        break;
      case '4':
        print("Saliendo del programa...");
        return;
      default:
        print("Opción no válida, intente de nuevo.");
    }
  }
}

Future<void> getProducts() async {
  final products = await repository.getProducts();
  products.fold((failure) => print(failure), (data) {
    print(
      "\n::::::::::::::::::::: Lista de productos ::::::::::::::::::::: \n",
    );
    print(products);
  });
}

Future<void> createProduct() async {
  final product = await repository.createProduct(
    ProductModel(
      title: 'Prueba dart',
      category: 'tests',
      description:
          'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500',
      image:
          'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
      price: 40.0,
    ),
  );

  product.fold((failure) => print(failure), (data) {
    print("\n::::::::::::::::::::: Producto creado ::::::::::::::::::::: \n");
    print(product);
  });
}

Future<void> getCarts() async {
  final carts = await repository.getCarts();

  carts.fold((failure) => print(failure), (data) {
    print("\n::::::::::::::::::::: Lista de carts ::::::::::::::::::::: \n");
    print(carts);
  });
}
