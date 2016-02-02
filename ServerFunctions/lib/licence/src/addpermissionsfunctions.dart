library removePermissionFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddPermissionsFunctions
{
  void addPermission(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement usernameInput = querySelector("#username");
    SelectElement permissionChoice = querySelector("#setPermissions");
    String permission;
    String user = usernameInput.value;
    permission = permissionChoice.value;
    
    LicenceServerRequests.addLicencePermission(user, permission, window.sessionStorage['username'],
                                window.sessionStorage['password'],LicenceServerRequests.defaultUri(),
                                (s) => pc.getResult(ps.licenceSuccessPrompt("Add-Permissions"), s),
                                (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
  }
  
  void removePermission(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement usernameInput = querySelector("#username");
    SelectElement permissionChoice = querySelector("#setPermissions");
    String permission;
    String user = usernameInput.value;
    permission = permissionChoice.value;
    
    LicenceServerRequests.removeLicencePermission(user, permission, window.sessionStorage['username'],
        window.sessionStorage['password'], LicenceServerRequests.defaultUri(), 
        (s) => pc.getResult(ps.licenceSuccessPrompt("Remove-Permissions"), s),
        (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
  } 

  void setDescriptionText()
  {
    SpanElement output = querySelector("#permissionDescription");
    output.innerHtml = "User Can Return A String Showing An Entries From Other Administrators."+
                       " Includes A List Of Their Permissions.";
    querySelector("#setPermissions").onChange.listen(setText);
  }

  void setText(Event e)
  {
    SelectElement dropDown = querySelector("#setPermissions");
    int index = dropDown.selectedIndex;
    OptionElement oe = dropDown.options[index];
    SpanElement output = querySelector("#permissionDescription");
    output.innerHtml = oe.attributes['doc'];
  }
}