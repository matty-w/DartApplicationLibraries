library tagProject;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class TagProjectFolder
{
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  
  void tagProjectFolder(String projectBoxId, String folderNameBoxId, String tagInputBoxId)
  {
    SelectElement projectBox = querySelector(projectBoxId);
    SelectElement folderBox = querySelector(folderNameBoxId);
    InputElement tagBox = querySelector(tagInputBoxId);
    
    String projectName = projectBox.value;
    String tagInput = tagBox.value;
    String folderName = null;
    for(int i = 0; i < folderBox.children.length; i++)
    {
      if(folderBox.options[i].selected == true)
        folderName = folderBox.options[i].innerHtml;
    }
    if(tagInput.trim() == "" || tagInput == null)
    {
      ps.errorPrompt("No-Tag-Input");
      return;
    }
    
    String scriptCommand = createScriptCommand(projectName, folderName, tagInput);
    
    PortfolioServerRequests.runPortfolioScriptCommand(scriptCommand, "String-Response", PortfolioServerRequests.defaultUri(),
                                                      (s) => tagFolderSuccess(projectName, folderName), 
                                                      (s) => tagFolderFail(s));
    
  }
  
  String createScriptCommand(String projectName, String projectFolder, String tagName)
  {
    return "tag folder "+projectFolder+" in "+projectName+" with "+tagName;
  }
  
  void tagFolderSuccess(String projectName, String folderName)
  {
    PortfolioServerRequests.resetAllProjects(PortfolioServerRequests.defaultUri(), null);
    ps.projectSuccessPrompt("Tag-Project-Success", projectName, folderName);
  }
  
  void tagFolderFail(String response)
  {
    PortfolioServerRequests.resetAllProjects(PortfolioServerRequests.defaultUri(), null);
    pc.getResult(ps.errorPrompt("Server-Error"), response);
  }
}