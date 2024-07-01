
import 'package:flutter/material.dart';



import 'package:image_picker/image_picker.dart';


import '../../consts.dart';

import '../../models/models.dart';
import '../../services.dart';


class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
 // File? _image;
  Category? _selectedCategory;

  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      //if (pickedFile != null) {
       // _image = File(pickedFile.path);
     // }
    });
  }

  void _submitData() async {
    final name = _nameController.text;
    final int price = int.parse(_priceController.text);
    final description = _descriptionController.text;

    if (name.isEmpty || price==0 || description.isEmpty ||  _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields and select a category.')),
      );
      return;
    }
    //
    // final product = Product(
    //   id: 1, // This will be set by the server
    //   name: name,
    //   price: double.parse(price),
    //   description: description,
    //   category: _selectedCategory!.name,
    //   imageUrl: _image!.path,
    //   categoryId:_selectedCategory!.id , // Handle image uploading separately if needed
    // );

    final response = await _apiService.createProduct(name: name, price: price, imageUrl: description, categoryId: _selectedCategory!.id);

    if (response) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add the product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                child: FutureBuilder<List<Category>>(
                  future: categories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error.toString());
                      return const Center(child: Text('Error fetching categories'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No categories found'));
                    }
                    final categories = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = categories[index];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedCategory == categories[index] ? kPrimaryColor : kGrayColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                categories[index].name,
                                style: TextStyle(
                                  color: _selectedCategory == categories[index] ? kWhiteColor : kTextGrayColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Image ',
                  labelStyle: TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
           //   _image == null
             //     ? Text(
               // 'No Image Selected',
               // style: TextStyle(color: kPrimaryColor),
              //)
                //  : Image.file(
               // _image!,
               // height: 200,
             // ),
             // ElevatedButton(
               // onPressed: _pickImage,
               // style: ElevatedButton.styleFrom(
                 // backgroundColor: kPrimaryColor,
                 // shape: RoundedRectangleBorder(
                   // borderRadius: BorderRadius.circular(15),
                  //),
              //  ),
               // child: const Text('Pick Image'),
              //),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
