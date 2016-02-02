library deleteRegistry;

import 'dart:html';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'elementvalues.dart';

class DeleteRegistry
{
  int deletionFailCount = 0;
  PopupSelection ps = new PopupSelection();
  
  void completeDeletion(MouseEvent m)
  {
    List catalogueKeys = RegistryWebElementValues.deleteKeys();

    for(int i = 0; i < catalogueKeys.length; i++)
    {
      DatabaseServerRequests.deleteRegistryFile(catalogueKeys[i], DatabaseServerRequests.defaultUri(), failFunction(), passFunction());
    }
    if(deletionFailCount == 0)
    {
      ps.registrySuccessPopup("Delete-Success");
    }
  }
  
  void deleteButton(MouseEvent m)
  {
    List catalogueKeys = RegistryWebElementValues.deleteKeys();
    if(catalogueKeys.length == 0 || catalogueKeys == null)
    {
      ps.errorPrompt("No-Entries-Selected");
    }
    if(catalogueKeys.length > 0)
    { 
      ps.removeRegistryPrompt(catalogueKeys);
    }
  }
  
  failFunction()
  {
  }
  
  passFunction()
  {
    deletionFailCount++;
  }
}