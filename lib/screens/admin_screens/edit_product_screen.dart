import 'package:Deco_store_app/providers/product.dart';
import 'package:Deco_store_app/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _prixFocusNode = FocusNode(); // to manage which input is Focused
  final _descriptionFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _quantiteFocusNode = FocusNode();
  final _imageurlController = TextEditingController();
  // Create a contoller for editable Field (bach ta3raf fayda ta3ha chof win utilisinaha l ta7ta)
  final _imageurlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  //we use GlobalKey when we need to interect with a widget from inside your code.w nakhadmo bih m3a Form
  var _editedProduct = Product(
    id: null,
    description: '',
    nom: '',
    prix: 0,
    imageurl: '',
    quantite: 0,
    type: '',
  );

  var _initValues = {
    'nom': '',
    'prix': '',
    'description': '',
    'imageurl': '',
    'quantite': '',
    'type': ''
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageurlFocusNode.addListener(_updateimageurl); //pointeur to the function
    //zadna had Listner en cas yassra changement f _imageurlFocusNode (Focus state change) n executo la fonction _updateimageurl

    super.initState();
  }

  @override
  void didChangeDependencies() {
    //darnaha bach n9ado nakhadmo b context (f init state man9adoch ndiro.of(context))
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        //findById function 7na declarinaha f class Products
        _initValues = {
          'nom': _editedProduct.nom,
          'type': _editedProduct.type,
          'quantite': _editedProduct.quantite.toString(),
          'description': _editedProduct.description,
          'prix': _editedProduct.prix.toString(),
          'imageurl': '',
        };
        _imageurlController.text = _editedProduct.imageurl;
        //f Field ta3 image Url kayan controller sama lokan ndiro kima fog hadi yasra probleme
      }
    }
    //darna if psq didChangeDependencies tat executa ch7al m khatra
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateimageurl() {
    //Lose Focus ma3natha nro7o l Field wa7dakhra (Lose Focus == !_imageurlFocusNode.hasFocus )   sama yassra unselect f TextForm ta3 image Url
    if (!_imageurlFocusNode.hasFocus) {
      if ((!_imageurlController.text.startsWith('http') &&
              !_imageurlController.text.startsWith('https')) ||
          (!_imageurlController.text.endsWith('.png') &&
              !_imageurlController.text.endsWith('.jpg') &&
              !_imageurlController.text.endsWith('jpeg'))) {}

      return; //hna ta7bass function w matkamalch
    }
    setState(() {});
  }

  @override
  void dispose() {
    _imageurlFocusNode.removeListener(
        _updateimageurl); // nagal3o Listner psq yab9a ga3 w yasra problem f la Ram
    _prixFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _typeFocusNode.dispose();
    _quantiteFocusNode.dispose();

    _imageurlController.dispose();
    _imageurlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final _isValid = _form.currentState.validate();
    //it will trigger all validators and it will return True if they all return null (no error).and will return false if at least one validator returns a String (error)
    if (!_isValid) {
      return; //if is not valid tama ta7bass function w lib9a mayat executach
    }

    _form.currentState.save();
    // Saves every [FormField] that is a descendant of this [Form].
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<Products>(
        context,
        listen: false,
      ).updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(
          context,
          listen: false,
        ).addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
          //kayan video 11 yfaham hado
          //zadnaha bach l rodo Future w moraha then t7abass hadak indicator li ydor
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Une erreur s'est produite !"),
            content:
                Text('Peut être un produit du même nom et type existe déja !'),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Votre produit'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                //when we do that we can use Form propriety to interect we the state manage by the Form widget

                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['nom'],
                      decoration: InputDecoration(labelText: 'nom'),
                      textInputAction: TextInputAction.next,
                      //pass to next field and don't submitted
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_typeFocusNode);
                        // we tell Fluter that when this first input is submitted,we go to the TextField that has _prixFocusNode like Focus Node
                      },
                      onSaved: (value) {
                        //hado yakhadmo ki ndiro  _form.currentState.save();
                        _editedProduct = Product(
                          nom: value,
                          // had TextFiel ta3tina nom li rahi f parametre value
                          //man9adoch ndiro direct _editedProduct.nom = value psq rana dayrin had les proprietes final
                          prix: _editedProduct.prix,
                          //man9adoch ndiro direct.
                          type: _editedProduct.type,
                          quantite: _editedProduct.quantite,
                          description: _editedProduct.description,
                          imageurl: _editedProduct.imageurl,
                          id: _editedProduct.id,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez fournir un nom'; //Error message
                        }
                        return null; //sayi raha nichen (not empty)
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['type'],
                      decoration: InputDecoration(labelText: 'Type'),
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _typeFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_quantiteFocusNode);
                        // we tell Fluter that when this first input is submitted,we go to the TextField that has _prixFocusNode like Focus Node
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          nom: _editedProduct.nom,
                          prix: _editedProduct.prix,
                          type: value,
                          quantite: _editedProduct.quantite,
                          description: _editedProduct.description,
                          imageurl: _editedProduct.imageurl,
                          id: _editedProduct.id,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez saisir le type.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_quantiteFocusNode);
                        // we tell Fluter that when this first input is submitted,we go to the TextField that has _descriptionFocusNode like Focus Node
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          nom: _editedProduct.nom,
                          prix: _editedProduct.prix,
                          type: _editedProduct.type,
                          quantite: _editedProduct.quantite,
                          description: value,
                          imageurl: _editedProduct.imageurl,
                          id: _editedProduct.id,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez saisir une description.';
                        }
                        if (value.length < 10) {
                          return 'Doit comporter au moins 10 caractères';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['quantite'],
                      decoration: InputDecoration(labelText: 'Quantite'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _quantiteFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_prixFocusNode);
                        // we tell Fluter that when this first input is submitted,we go to the TextField that has _descriptionFocusNode like Focus Node
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          nom: _editedProduct.nom,
                          type: _editedProduct.type,
                          quantite: int.parse(value), //convert to double
                          prix: _editedProduct.prix,
                          description: _editedProduct.description,
                          imageurl: _editedProduct.imageurl,
                          id: _editedProduct.id,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer la quantite';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un numéro valide.'; // exemple ndakhlo String sama man9adoch n convertoh l double using double.parse(value)
                        }
                        if (double.parse(value) <= 0) {
                          return 'Veuillez saisir un nombre supérieur à zéro.';
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['prix'],

                      decoration: InputDecoration(labelText: 'prix'),
                      textInputAction: TextInputAction.next,
                      //pass to next input and don't submitted  ,we actually want to focus the element with the prix focus node '_prixFocusNode' and we assign that prix focus node to the second text form field here.
                      keyboardType: TextInputType.number,
                      focusNode: _prixFocusNode,
                      // _prixFocusNode kichrol pointeur l had input
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageurlFocusNode);
                        // we tell Fluter that when this first input is submitted,we go to the TextField that has _descriptionFocusNode like Focus Node
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          nom: _editedProduct.nom,
                          prix: int.parse(value), //convert to double
                          type: _editedProduct.type,
                          quantite: _editedProduct.quantite,
                          description: _editedProduct.description,
                          imageurl: _editedProduct.imageurl,
                          id: _editedProduct.id,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer le prix.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un numéro valide.'; // exemple ndakhlo String sama man9adoch n convertoh l double using double.parse(value)
                        }
                        if (double.parse(value) <= 0) {
                          return 'Veuillez saisir un nombre supérieur à zéro.';
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageurlController.text.isEmpty
                              ? Text('Entez un URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageurlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            //initialValue: _initValues['imageurl'],   hadi sayi mandirohach psq sayi darna initialValue f controller
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            //when we press enter we try to submit this Form
                            controller: _imageurlController,
                            // mchi bssif dirha ida tas7a9 la valeur ta3ha kindiro submit.chawa hna nass7a9o la valeur ta3ha 9bal mandiro submit bach n afficho la photo(_imageurlController is ubdated when we press TextFormField)
                            focusNode: _imageurlFocusNode,
                            // zadna had Focus bach en cas  yasra Lose Focus(ma3natha nro7o l Field wa7dakhra.sama yassra unselect f TextForm ta3 image Url ) l'image yasralha update
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                nom: _editedProduct.nom,
                                prix: _editedProduct.prix,
                                description: _editedProduct.description,
                                type: _editedProduct.type,
                                quantite: _editedProduct.quantite,
                                imageurl: value,
                                id: _editedProduct.id,
                              );
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'SVP entez un image URL ';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'SVP entez un URL valide ';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('jpeg')) {
                                return 'SVP entez un image URL valide';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
