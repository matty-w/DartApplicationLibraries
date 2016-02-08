library registryActionFunctions;

import 'dart:html';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';

class RegistryActionFunctions
{
  //LoadFunctions lf = new LoadFunctions();
  OnLoadRegistry olr = new OnLoadRegistry();
  
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  
  void showFolders(int i)
  {
    SelectElement fileFilter = querySelector("#fileTypeDropDown");
    fileFilter.disabled = true;
    TableElement table = querySelector("#projectFolders");
    OutputElement title = querySelector("#projectSelected");
    InputElement folderPathBox = querySelector("#folderPath");
    ButtonElement ok = querySelector("#okExplorer");
    ok.disabled = true;
    title.innerHtml = "  "+window.sessionStorage['projects$i'];
    table.innerHtml = "";
    folderPathBox.value = "";
    String projectName = window.sessionStorage['projects$i'];
    PortfolioServerRequests.showProjectFolders(projectName, "BuildTables", PortfolioServerRequests.defaultUri(), (s) => olr.setFoldersList(s), 
                                    (s) => blankTable());
  }
  
  void blankTable()
  {
    return;
  }
  
  void completeTask(MouseEvent m)
  {
    pc.dismiss("#popUpDiv");
    OutputElement server = querySelector("#serverResponse");
    ButtonElement title = querySelector("#popupAction");
    InputElement registryNameBox = querySelector("#keyText");
    InputElement contentPathBox = querySelector("#browseText");
    server.innerHtml = "";
    String titleName = title.innerHtml;
    
    if(titleName == "Add Registry")
    {
      String regName = registryNameBox.value;
      String contentPath = contentPathBox.value;
      
      DatabaseServerRequests.addRegistryFile(regName, contentPath, DatabaseServerRequests.defaultUri(), 
          (s) => ps.registrySuccessPopup("Add-Registry-Success"),
          (s) => ps.errorPrompt("Server-Error"));
    }
    
    if(titleName == "Edit-Registry")
    {
      String regName = registryNameBox.value;
      String contentPath = contentPathBox.value;
      
      DatabaseServerRequests.editRegistryFile(regName, contentPath, DatabaseServerRequests.defaultUri(),
          (s) => ps.registrySuccessPopup("Edit-Registry-Success"),
          (s) => ps.errorPrompt("Server-Error"));
    }
  }
  
  void listenToBox(MouseEvent m)
  {
    TableElement table = querySelector("#registryTable");
    table.innerHtml = "";
    table.hidden = true;
    InputElement selectedProject = querySelector("#projectDropDown");
    window.sessionStorage['project'] = selectedProject.value;
    window.localStorage['project'] = window.sessionStorage['project'];
    DatabaseServerRequests.getRegistryFiles(window.sessionStorage['project'], DatabaseServerRequests.defaultUri(),
                                  (s) => olr.createRegistryTable(s));
  }
  
  void setItem(MouseEvent m)
  {    
    SelectElement fileFilter = querySelector("#fileTypeDropDown");
    fileFilter.disabled = true;
    String popup = querySelector("#popupTitle").innerHtml;
    InputElement contentPath = querySelector("#browseText");
    InputElement pathBox = querySelector("#folderPath");
    String path = pathBox.value;
    contentPath.value = path.trim();
    pc.dismiss("#fileBrowserDiv");
    
    if(popup == "Add Registry Entry")
      ps.addRegistryPrompt();
    else
      ps.editRegistryPrompt("");
  }
}