library projectActionFunctions;

import 'dart:html';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:ServerFunctions/ServerFunctions.dart';

class ProjectActionFunctions
{
  OnLoadProject olp = new OnLoadProject();
  
  void moveToRight(String pluginsLeftBoxId, String pluginsBoxRightId)
  {
    SelectElement helpers = querySelector(pluginsLeftBoxId);
    SelectElement selectedHelpers = querySelector(pluginsBoxRightId);
    for(int i = 0; i < helpers.length; i++)
    {
      if(helpers.options[i].selected)
      {
        String id = helpers.options[i].id;
        OptionElement option = new OptionElement();
        option.text = helpers.options[i].innerHtml;
        option.text = helpers.options[i].innerHtml;
        option.id = id;
        selectedHelpers.add(option,-1);
        helpers.options[i].remove();
      }
    }
  }
  
  void moveToLeft(String pluginsLeftBoxId, String pluginsRightBoxId)
  {
    SelectElement removedHelpers = querySelector("#pluginsLeft");
    SelectElement helpers = querySelector("#pluginsRight");
    for(int i = 0; i < helpers.length; i++)
    {
      if(helpers.options[i].selected)
      {
        String id = helpers.options[i].id;
        OptionElement option = new OptionElement();
        option.text = helpers.options[i].innerHtml;
        option.id = id;
        removedHelpers.add(option,-1);
        helpers.options[i].remove();
      }
    }
  }
  
  void checkForSelectedHelperLeft(String pluginsLeftBoxId, String pluginsRightBoxId, String pluginDescriptionBoxId)
  {
    SelectElement helpers = querySelector(pluginsLeftBoxId);
    SelectElement selectedHelpers = querySelector(pluginsRightBoxId);
    
    for(int i = 0; i < helpers.length; i++)
    {
      if(helpers.options[i].selected)
      {
        displayDescription(helpers.options[i].id, pluginDescriptionBoxId);
        for(int i = 0; i < selectedHelpers.length; i++)
        {
          selectedHelpers.options[i].selected = false;
        }
      }
    }
  }
  
  void checkForSelectedHelperRight(String pluginsLeftBoxId, String pluginsRightBoxId, String pluginDescriptionBoxId)
  {
    SelectElement helpers = querySelector(pluginsLeftBoxId);
    SelectElement selectedHelpers = querySelector(pluginsRightBoxId);
    
    for(int i = 0; i < helpers.length; i++)
    {
      if(helpers.options[i].selected)
      {
        displayDescription(helpers.options[i].id, pluginDescriptionBoxId);
        for(int i = 0; i < selectedHelpers.length; i++)
        {
          selectedHelpers.options[i].selected = false;
        }
      }
    }
  }
  
  void loadProjectFolders(String projectName, String projectFolderBoxId)
  {
    String projectTitle = projectName;
    
    PortfolioServerRequests.getProjectProperty(projectTitle, "project.contents", PortfolioServerRequests.defaultUri(), 
        (s) => createFolderDropdownList(s, projectFolderBoxId));
  }
  
  createFolderDropdownList(String response, String projectFolderBoxId)
  {
    SelectElement projectFolderBox = querySelector(projectFolderBoxId);
    
    while(projectFolderBox.children.length > 0)
    {
      projectFolderBox.children.removeAt(0);
    }
    
    String folderNames = response;
    List folderList = folderNames.split(",");
    for(int i = 0; i < folderList.length; i++)
    {
      OptionElement option = new OptionElement();
      option.innerHtml = folderList[i];
      option.id = folderList[i];
      projectFolderBox.children.add(option);
    }
  }
  
  void displayDescription(String pluginId, String descriptionIdentifier)
  {
    olp.loadPluginDescriptors(pluginId, descriptionIdentifier);
  }

  void test(MouseEvent m)
  {
    window.alert("hi!");
  }
  
  void displayHiddenDropDown(String liId, String dropdownId)
  {
    Element liElement = querySelector(liId);
    SelectElement yesOrNo = querySelector(dropdownId);
    String innerHtml = yesOrNo.value;
    
    if(innerHtml == "Yes")
      liElement.style.display = "block";
    else if(innerHtml == "No")
      liElement.style.display = "none";
  }
}