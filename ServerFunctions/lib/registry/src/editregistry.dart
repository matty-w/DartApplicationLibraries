library editRegistry;

import 'dart:html';
import 'elementvalues.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class EditRegistry
{
  PopupSelection ps = new PopupSelection();
  
  void editButton(MouseEvent m)
  {
    List catalogueKeys = RegistryWebElementValues.deleteKeys();
    if((catalogueKeys.length == 0 || catalogueKeys == null))
    {
      ps.errorPrompt("No-Entries-Selected-Edit");
    }
    if(catalogueKeys.length > 1)
    {
      ps.errorPrompt("Too-Many-Selected");
    }
    else if(catalogueKeys.length == 1)
    {
      String a = catalogueKeys[0];
      ps.editRegistryPrompt(a);
    }
  }
}