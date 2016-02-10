library addFolder;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class AddProjectFolder
{
  PopupConstructor pc = new PopupConstructor();
  PopupSelection ps = new PopupSelection();
  
  void addFolderToProject(String projectNameDropDownId, String folderNameBoxId, String subFolderYesNoBoxId, String existingFoldersBoxId)
  {
    SelectElement projectNameBox = querySelector(projectNameDropDownId);
    InputElement folderNameBox = querySelector(folderNameBoxId);
    SelectElement yesOrNoBox = querySelector(subFolderYesNoBoxId);
    SelectElement existingFoldersBox = querySelector(existingFoldersBoxId);
    
    String projectName = projectNameBox.value;
    String folderName = folderNameBox.value;
    String yesOrNo = yesOrNoBox.value;
    String existingFolder = null;
    for(int i = 0; i < existingFoldersBox.children.length; i++)
    {
      if(existingFoldersBox.options[i].selected == true)
        existingFolder = existingFoldersBox.options[i].innerHtml;
    }
    if(folderName.trim() == "" || folderName == null)
    {
      ps.errorPrompt("No-Folder-Name-Entered");
      return;
    }
    if(yesOrNo == "Yes")
    {
      String scriptCommand = scriptCommandSubFolder(projectName, folderName, existingFolder);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(), 
                                                        (s) => addFolderSuccess(projectName),
                                                        (s) => addFolderFail(s));
    }
    else if(yesOrNo == "No")
    {
      String scriptCommand = scriptCommandNoSubFolder(projectName, folderName);
      PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(), 
                                                        (s) => addFolderSuccess(projectName),
                                                        (s) => addFolderFail(s));
    }
  }
  
  String scriptCommandSubFolder(String projectName, String folderName, String existingFolderName)
  {
    return "add folder "+folderName+" in "+existingFolderName+" to "+projectName;
  }
  
  String scriptCommandNoSubFolder(String projectName, String folderName)
  {
    return "add folder "+folderName+" to "+projectName;
  }
  
  addFolderSuccess(String projectName)
  {
    PortfolioServerRequests.resetAllProjects(PortfolioServerRequests.defaultUri(), null);
    ps.projectSuccessPrompt("Folder-Successfully-Added", projectName, null);
  }
  
  addFolderFail(String response)
  {
    PortfolioServerRequests.resetAllProjects(PortfolioServerRequests.defaultUri(), null);
    pc.getResult(ps.errorPrompt("Server-Error"), response);
  }
}