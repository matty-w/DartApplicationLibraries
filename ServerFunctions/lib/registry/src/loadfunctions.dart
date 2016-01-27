library loadFunctions;

import 'dart:html';
import 'elementvalues.dart';
import 'package:ServerFunctions/ServerFunctions.dart';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class LoadFunctions
{
  NavigationFunctions nav = new NavigationFunctions();
  PopupSelection ps = new PopupSelection();
  PopupConstructor pc = new PopupConstructor();
  List<String> projectList = new List();
  
  setFoldersList(List folderList)
  {
    int folderLength = folderList.length;
    List<String> folders = new List<String>();
    for(int i = 0; i < folderList.length; i++)
    {
      String responseFull = folderList[i];
      int endIndex = folderList.elementAt(i).indexOf("helper=");
      int startIndex = folderList.elementAt(i).indexOf("Tables");
      String folder = responseFull.substring(startIndex, endIndex);
      folders.add(folder);
    }
    ElementValues.setProjectFoldersList(folderLength, folders);
  }
  
  void showConfirmPrompt(MouseEvent m)
  {
    ButtonElement title = querySelector("#popupAction");
    String titleName = title.innerHtml;
    InputElement registryNameBox = querySelector("#keyText");
    registryNameBox.style.backgroundColor = "#FFFFFF";
    InputElement contentPathBox = querySelector("#browseText");
    contentPathBox.style.backgroundColor = "#FFFFFF";
    
    if((registryNameBox.value.trim() == "" || registryNameBox.value == null) 
        && contentPathBox.value.trim() == "" || contentPathBox.value == null)
    {
      registryNameBox.style.backgroundColor = "#802A2A";
      contentPathBox.style.backgroundColor = "#802A2A";
      return;
    }
    
    if(registryNameBox.value.trim() == "" || registryNameBox.value == null)
    {
      registryNameBox.style.backgroundColor = "#802A2A";
      return;
    }
    if(contentPathBox.value.trim() == "" || contentPathBox.value == null)
    {
      contentPathBox.style.backgroundColor = "#802A2A";
      return;
    }
    String regName = registryNameBox.value;
    String contentPath = contentPathBox.value;

    if(titleName == "Add Registry")
    {
      ps.addRegistryConfirmPrompt(regName, contentPath);
    }
    else if(titleName == "Edit Registry")
    {
      ps.editRegistryConfirmPrompt(regName, contentPath);
    }
  }
  
  createRegistryTable(List registries)
  {
    ElementValues.getRegistryEntries(registries);
  }
  
  void loadPreviousTable(Event e)
  {
    TableElement table = querySelector("#registryTable");
    table.innerHtml = "";
    setProject();
    if(window.sessionStorage['username'] == "" || window.sessionStorage['password'] == "")
    {
      nav.goToIndexPage();
    }
    ServerRequest.getRegistryFiles(window.localStorage['project'], ServerRequest.defaultUri(),
                                  (s) => createRegistryTable(s));
  }
  
  void loadChosenFiles(Event e)
  {
    InputElement selectedFileType = querySelector("#fileTypeDropDown");
    String fileTypeValue = selectedFileType.value;
    presentTableChoices(fileTypeValue);
  }
  
  void presentTableChoices(String fileType)
  {
    TableElement table = querySelector("#projectFolders");
    
    if(fileType == "All Files (.zzdb, .zzmf, .csv)")
    {
      for(int i = 0; i < table.rows[0].cells.length; i++)
      {
        TableCellElement file = querySelector("#file$i");
        file.style.display = "inline-block";
      }
    }
    if(fileType == "*.zzdb")
    {
      searchTableValues(".zzdb");
    }
    if(fileType == "*.zzmf")
    {
      searchTableValues(".zzmf");
    }
    if(fileType == "*.csv")
    {
      searchTableValues(".csv");
    }
  }
  
  void loadProjectsDropdownAndExplorer(String selectIdentifier, String tableIdentifier)
  {
    ServerRequest.listProjects(ServerRequest.defaultUri(),(s) => createProjectAndExplorerList(s, selectIdentifier, tableIdentifier));
  }
  
  void loadDatasetProjects(String identifier)
  {
    ServerRequest.listProjects(ServerRequest.defaultUri(),(s) => createProjectDataList(s, identifier));
  }
  
  void loadSelectElementProjects(String identifier)
  {
    ServerRequest.getProjectConfigs(ServerRequest.defaultUri(), (s) => createProjectSelectList(s, identifier));
  }
  
  void loadPluginsAndDescriptions(String pluginIdentifier, String descriptionIdentifier)
  {
    ServerRequest.listPluginsAndDescriptions(ServerRequest.defaultUri(), (s) => createPluginList(s, pluginIdentifier, descriptionIdentifier));
  }
  
  void loadPluginDescriptors(String pluginIdentifier, String descriptionIdentifier)
  {
    ServerRequest.listPluginsAndDescriptions(ServerRequest.defaultUri(), (s) => createDescriptionList(s, pluginIdentifier, descriptionIdentifier));
  }
  
  void selectFolderDestination(String folderName)
  {
    OutputElement output = querySelector("#projectSelected");
    String projectName = output.innerHtml;
    InputElement folderPathBox = querySelector("#folderPath");
    String projectPath = projectName+"/"+folderName;
    folderPathBox.value = projectName+"/"+folderName;
    window.sessionStorage['filePath'] = projectPath;
    ServerRequest.showProjectFiles(projectPath, "*", ServerRequest.defaultUri(), (s) => setFileList(s));
  }
  
  setFileList(List files)
  {
    SelectElement fileFilter = querySelector("#fileTypeDropDown");
    fileFilter.disabled = false;
    List<String> fileList = new List<String>();
    for(int i = 0; i < files.length; i++)
    {
      int endIndex = files.elementAt(i).indexOf("entity.path");
      int startIndex = files.elementAt(i).indexOf("entity.name");
      String fileTrim1 = files[i];
      String fileTrim2 = fileTrim1.substring(startIndex, endIndex);
      String file = fileTrim2.substring(12);
      fileList.add(file);
    }
    ElementValues.setProjectFilesList(fileList);
  }
  
  void searchTableValues(String fileExtension)
  {
    TableElement table = querySelector("#projectFolders");

    for(int i = 0; i < table.rows[0].cells.length; i++)
    {
      TableCellElement file = querySelector("#file$i");
      if(file.innerHtml.contains(fileExtension))
      {
        file.style.display = "inline-block";
      }
      else
      {
        file.style.display = "none";
      }
    }
  }
  
  void selectFileDestination(int fileNum, int fileLength, String fileName)
  {
    TableCellElement clickedcell = querySelector("#file$fileNum");
    InputElement folderPathBox = querySelector("#folderPath");
    ButtonElement ok = querySelector("#okExplorer"); 
    String path = window.sessionStorage['filePath'];
    for(int i = 0; i < fileLength; i++)
    {
      if(i == fileNum)
      {
        clickedcell.style.backgroundColor = "#CDE7F0";
        folderPathBox.value = path+"/"+fileName;
        window.sessionStorage['finishedFilePath'] = folderPathBox.value;
        ok.disabled = false;
      }
      else if(i != fileNum)
      {
        TableCellElement unclickedFile = querySelector("#file$i");
        unclickedFile.style.backgroundColor = "";
      }
    }
  }
  
  void setProject()
  {
    SelectElement dropDown = querySelector("#projectDropDown");
    for(int i = 0; i < dropDown.length; i++)
    {
      if(dropDown.options[i].text == window.localStorage['project'])
      {
        dropDown.options[i].selected = true;
      }
    }
  }
  
  void storeProjects(List projects)
  {
    projectList = projects;
  }
  
  void createProjectAndExplorerList(List response, String selectIdentifier, String tableIdentifier)
  {
    for(int i = 0; i < response.length; i++)
    {
      window.sessionStorage['projects$i'] = response[i];
    }
    ElementValues.selectElementAndExplorer(response, selectIdentifier, tableIdentifier);
  }
  
  void createProjectDataList(List response, String identifier)
  {
    ElementValues.datasetProjectsDropDown(response, identifier);
  }
  
  void createProjectSelectList(List response, String identifier)
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
    ElementValues.selectElementProjectDropDown(projectTitles, identifier);
  }
  
  void createPluginList(List response, String pluginIdentifier, String desctriptionIdentifier)
  {
    ElementValues.selectElementPluginsAndDescriptors(response, pluginIdentifier, desctriptionIdentifier);
  }
  
  void createDescriptionList(List response, String pluginId, String desctriptionIdentifier)
  {
    ElementValues.setPluginDescriptors(response, pluginId, desctriptionIdentifier);
  }
}