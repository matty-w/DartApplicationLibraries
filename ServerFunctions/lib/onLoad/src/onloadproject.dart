library projectApplicationOnLoadFunctions;

import 'dart:html';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class OnLoadProject
{
  void loadPluginsAndDescriptions(String pluginIdentifier, String descriptionIdentifier)
  {
    PortfolioServerRequests.listPluginsAndDescriptions(PortfolioServerRequests.defaultUri(), 
                                          (s) => createPluginList(s, pluginIdentifier, descriptionIdentifier));
  }
  
  void loadPluginDescriptors(String pluginIdentifier, String descriptionIdentifier)
  {  
    PortfolioServerRequests.listPluginsAndDescriptions(PortfolioServerRequests.defaultUri(), 
                                          (s) => createDescriptionList(s, pluginIdentifier, descriptionIdentifier));
  }
  
  void createPluginList(List response, String pluginIdentifier, String desctriptionIdentifier)
  {
    ProjectWebElementValues.selectElementPluginsAndDescriptors(response, pluginIdentifier, desctriptionIdentifier);
  }
  
  void createDescriptionList(List response, String pluginId, String desctriptionIdentifier)
  {
    ProjectWebElementValues.setPluginDescriptors(response, pluginId, desctriptionIdentifier);
  }
  
  void loadSelectElementProjects(String identifier, bool includeProjDetails)
  {
    PortfolioServerRequests.getProjectConfigs(PortfolioServerRequests.defaultUri(), 
                                              (s) => createProjectSelectList(s, identifier, includeProjDetails));
  }
  
  void loadSelectElementProjectsWithFolders(String projectBoxId, String folderBoxId)
  {
    PortfolioServerRequests.getProjectConfigs(PortfolioServerRequests.defaultUri(), 
                                              (s) => createProjectSelectListWithFolders(s, projectBoxId, folderBoxId));
  }
  
  void loadProjectDetails(String titleIdentifier, String descriptionIdentifier)
  {
    SelectElement selectedProjectBox = querySelector("#projectDropDown");
    String selectedProject = selectedProjectBox.value;
    PortfolioServerRequests.getProjectConfigs(PortfolioServerRequests.defaultUri(), 
                                            (s) => createEditProjectDetails(s, titleIdentifier, descriptionIdentifier, selectedProject));
  }
  
  void loadDatasetProjects(String identifier)
  {
    PortfolioServerRequests.listProjectsDatabase(PortfolioServerRequests.defaultUri(),(s) => createProjectDataList(s, identifier));
  }
  
  void createProjectDataList(List response, String identifier)
  {
    ProjectWebElementValues.datasetProjectsDropDown(response, identifier);
  }
  
  void createEditProjectDetails(List response, String titleIdentifier, String descriptionIdentifier, String projectName)
  {
    InputElement projectTitleBox = querySelector(titleIdentifier);
    InputElement projectDescriptionBox = querySelector(descriptionIdentifier);
    projectTitleBox.value = "";
    projectDescriptionBox.value = "";
    
    for(int i = 0; i < response.length; i++)
    {
      List<String> projectConfigs = new List<String>();
      projectConfigs = response[i];
      for(int i = 0; i < projectConfigs.length; i++)
      {
        String configs = projectConfigs[i];
        if(configs == "project.name="+projectName)
        {
          List<String> correctProject = projectConfigs;
          for(int i = 0; i < correctProject.length; i++)
          {
            String correctConfigs = correctProject[i];
            if(correctConfigs.contains("project.title="))
            {
              String projectTitle = correctConfigs.substring(14);
              projectTitleBox.value = projectTitle;
            }
            if(correctConfigs.contains("project.shortDescription="))
            {
              String projectDescription = correctConfigs.substring(25);
              projectDescriptionBox.value = projectDescription;
            }
          }
        }
      }
    }  
  }
  
  void createProjectSelectListWithFolders(List response, String projectBoxId, String folderBoxId)
  {
    List<String> projectTitles = new List<String>();
    for(int i = 0; i < response.length; i++)
    {
      List<String> projectConfigs = new List<String>();
      projectConfigs = response[i];
      for(int i = 0; i < projectConfigs.length; i++)
      {
        String config = projectConfigs[i];
        if(config.contains("project.name"))
        {
          String projectNameFinal = config.substring(13);
          projectTitles.add(projectNameFinal);
        }
      }
    }
    PortfolioServerRequests.getProjectProperty(projectTitles[0], "project.contents", PortfolioServerRequests.defaultUri(), 
                                               (s) => createProjectAndFolderDetails(s, projectTitles, projectBoxId, folderBoxId));
  }
  
  void createProjectAndFolderDetails(String response, List projectTitles, String projectBoxId, String folderBoxId)
  {
    ProjectWebElementValues.selectElementProjectDropDownAndFolder(response, projectTitles, projectBoxId, folderBoxId);
  }
  
  void createProjectSelectList(List response, String identifier, bool includeProjDetails)
  {
    List<String> projectTitles = new List<String>();
    for(int i = 0; i < response.length; i++)
    {
      List<String> projectConfigs = new List<String>();
      projectConfigs = response[i];
      for(int i = 0; i < projectConfigs.length; i++)
      {
        //bool hasTitle = false;
        
        String config = projectConfigs[i];
        if(config.contains("project.name"))
        {
          String projectNameFinal = config.substring(13);
          projectTitles.add(projectNameFinal);
          //hasTitle = false;
        }
        /*if(config.contains("project.title"))
        {
          projectTitles.removeLast();
          String projectNameFinal = config.substring(14);
          projectTitles.add(projectNameFinal);
          hasTitle = true;
        }*/
      }
    }
    if(includeProjDetails == true)
    {
      createEditProjectDetails(response, "#projName", "#projDescription", projectTitles[0]);
    }
    ProjectWebElementValues.selectElementProjectDropDown(projectTitles, identifier);
  }
}