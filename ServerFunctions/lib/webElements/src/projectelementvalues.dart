library projectWebElementValues;

import 'dart:html';

class ProjectWebElementValues
{
  static void selectElementPluginsAndDescriptors(List response, String pluginIdentifier, String descriptorIdentifier)
  {
    List<String> pluginsList = new List();
    pluginsList = response;
    SelectElement pluginDropDown = querySelector(pluginIdentifier);
    for(int i = 0; i < pluginsList.length; i++)
    {
      String pluginNameInitialTrim = pluginsList[i].substring(5);
      int trim = pluginNameInitialTrim.indexOf("documentation=");
      String pluginName = pluginNameInitialTrim.substring(0,trim);
      OptionElement option = new OptionElement();
      option.id = "plugin"+i.toString();
      option.innerHtml = pluginName;
      pluginDropDown.children.add(option);
    }
  }
  
  static void setPluginDescriptors(List response, String pluginId, String descriptorIdentifier)
  {
    List<String> pluginsList = new List();
    pluginsList = response;
    TextAreaElement textArea = querySelector(descriptorIdentifier);
    for(int i = 0; i < pluginsList.length; i++)
    {
      if(pluginId == "plugin"+i.toString())
      {
        String pluginNameInitialTrim = pluginsList[i].substring(5);
        int trim = pluginNameInitialTrim.indexOf("documentation=");
        String descriptorInitialTrim = pluginNameInitialTrim.substring(trim);
        int descriptionTrim = descriptorInitialTrim.indexOf("version=");
        String pluginDescription = descriptorInitialTrim.substring(14, descriptionTrim);
        String pluginTrim = pluginDescription.trim().replaceAll("\n", "");
        String pluginTrim2 = pluginTrim.trim().replaceAll("   ", "  ");
        String pluginTrim3 = pluginTrim2.trim().replaceAll("  ", " ");
        textArea.innerHtml = "";
        textArea.innerHtml = pluginTrim3;
      }
    }
  }
  
  static void selectElementProjectDropDown(List projects, String htmlIdentifier)
  {
    List<String> projectList = new List();
    projectList = projects;
    
    for(int i = 0; i <= projectList.length; i++)
    {
      SelectElement select = querySelector(htmlIdentifier);
      var option = document.createElement("option");
      option.setAttribute("value", projectList[i]);
      option.id = i.toString();
      option.setInnerHtml(projectList[i]);
      select.children.add(option);
    }
  }
  
  static void selectElementProjectDropDownAndFolder(String serverResponse, List projects, String projectBoxId, String folderBoxId)
  {
    List<String> projectList = new List();
    projectList = projects;
    String folders = serverResponse;
    List folderList = folders.split(",");
    SelectElement projectBox = querySelector(projectBoxId);
    SelectElement folderBox = querySelector(folderBoxId);
    
    for(int i = 0; i < projectList.length; i++)
    {
      var option = document.createElement("option");
      option.setAttribute("value", projectList[i]);
      option.id = i.toString();
      option.setInnerHtml(projectList[i]);
      projectBox.children.add(option);
    }
    for(int i = 0; i < folderList.length; i++)
    {
      OptionElement option = new OptionElement();
      option.innerHtml = folderList[i];
      option.id = folderList[i];
      folderBox.children.add(option);
    }
  }
  
  static void datasetProjectsDropDown(List projects, String htmlIdentifier)
  {
    List<String> projectList = new List();
    projectList = projects;
    
    for(int i = 0; i <= projectList.length; i++)
    {
      DataListElement datalist = querySelector(htmlIdentifier);
      var option = document.createElement("option");
      option.setAttribute("value", projectList[i]);
      option.setInnerHtml(projectList[i]);
      datalist.children.add(option);
    }
  }
}