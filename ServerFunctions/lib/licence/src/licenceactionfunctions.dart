library licenceActionFunctions;

import 'dart:html';
import 'dart:js';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';

class LicenceActionFunctions
{
  void saveToClipboard(MouseEvent e)
  {
    clipboardPrompt(window.sessionStorage['licenceName']);
  }
  
  void clipboardPrompt(String licence)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    var result = context.callMethod('prompt', ["Copy to clipboard: Ctrl+C, Enter", licence]);
    print(result);
    ps.licenceClipboardPopup("Add-Licence");
    pc.dismiss("#popUpDiv");
  }
  
  void clearTable(Event e)
  {
    TableElement table = querySelector("#searchTable");
    table.hidden = true;
  }
}