library loadElements;

import 'dart:html';
import 'actionfunctions.dart';
import 'loadfunctions.dart';
import 'package:TableCreationLibrary/TableCreationLibrary.dart';

class ElementValues
{
  static void getProjects(List projects)
  {
    ActionFunctions af = new ActionFunctions();
    List<String> projectList = new List();
    projectList = projects;
    
    for(int i = 0; i <= projectList.length; i++)
    {
      SelectElement select = querySelector("#projectDropDown");
      var option = document.createElement("OPTION");
      option.setAttribute("value", projectList[i]);
      option.setInnerHtml(projectList[i]);
      select.append(option);
      OptionElement o = option;
      TableElement table = querySelector("#projectNames");
      TableRowElement row = table.insertRow(-1);
      TableCellElement projectName = row.insertCell(0);
      TableCellElement pictureCell = row.insertCell(0);
      pictureCell.id = "folderPic$i";
      pictureCell.style.verticalAlign = "top";
      pictureCell.style.maxWidth = "8px";
      pictureCell.style.display = "inline-table";
      pictureCell.innerHtml = '<img alt="folderSmall" src="images/folderSmall.png">';
      projectName.id = "projectName$i";
      pictureCell.onClick.listen((MouseEvent m) => af.showFolders(i));
      projectName.onClick.listen((MouseEvent m) => af.showFolders(i));
      projectName.innerHtml = projectList[i];
      
      if(o.value == window.localStorage['project'])
      {
        o.selected = true;
      }
    }
  }
  
  static void datasetProjectsDropDown(List projects)
  {
    List<String> projectList = new List();
    projectList = projects;
    
    for(int i = 0; i <= projectList.length; i++)
    {
      DataListElement datalist = querySelector("#projectNames");
      var option = document.createElement("option");
      option.setAttribute("value", projectList[i]);
      option.setInnerHtml(projectList[i]);
      datalist.children.add(option);
    }

  }
  
  static void setProjectExplorerList(int projectLength)
  {   
    ActionFunctions af = new ActionFunctions();
    
    for(int i = 0; i < projectLength; i++)
    {
      TableElement table = querySelector("#projectNames");
      TableRowElement row = table.insertRow(-1);
      TableCellElement projectName = row.insertCell(0);
      TableCellElement pictureCell = row.insertCell(0);
      pictureCell.id = "folderPic$i";
      pictureCell.style.verticalAlign = "top";
      pictureCell.style.maxWidth = "8px";
      pictureCell.style.display = "inline-table";
      pictureCell.innerHtml = '<img alt="folderSmall" src="images/folderSmall.png">';
      projectName.id = "projectName$i";
      pictureCell.onClick.listen((MouseEvent m) => af.showFolders(i));
      projectName.onClick.listen((MouseEvent m) => af.showFolders(i));
      projectName.innerHtml = window.sessionStorage['projects$i'];
    }
  }
  
  static void setProjectFoldersList(int folderLength, List folderName)
  {
    LoadFunctions lf = new LoadFunctions();
    TableElement table = querySelector("#projectFolders");
    TableRowElement row = table.insertRow(0);
    for(int i = 0; i < folderLength; i++)
    {
      TableCellElement folder = row.insertCell(0);
      folder.id = "folder$i";
      folder.style.display = "inline-table";
      folder.style.margin = "0 40px";
      folder.innerHtml = '<div id="folderAndTitle"><img alt="folderLarge"'+
                         'src="images/folderLarge.png"><p>'+folderName[i]+'</p></div>';
      folder.onClick.listen((MouseEvent m) => lf.selectFolderDestination(folderName[i]));    
    }
  }
  
  static void setProjectFilesList(List files)
  {
    LoadFunctions lf = new LoadFunctions();
    TableElement table = querySelector("#projectFolders");
    table.innerHtml = "";
    TableRowElement row =  table.insertRow(0);
    for(int i = 0; i < files.length; i++)
    {
      TableCellElement file = row.insertCell(0);
      file.id = "file$i";
      file.style.display = "inline-table";
      file.style.margin = "0 30px";
      file.innerHtml = '<div id="folderAndTitle"><img alt="databasePic"'+
          '              src="images/databasePic.png"><p>'+files[i]+'</p></div>';
      file.onClick.listen((MouseEvent m) => lf.selectFileDestination(i, files.length, files[i]));
    }
  }
  
  static void getRegistryEntries(List registries)
  {
    List<String> registryNames = new List();
    Set<String> paths = new Set<String>();
    TableElement table = querySelector("#registryTable");
    for(int i = 0; i < registries.length; i++)
    {
      int index = registries.elementAt(i).indexOf("entry.path");
      String r = registries[i];
      String reg1 = r.substring(11, index);
      if(!(reg1.indexOf(".", reg1.toString().indexOf(".") + 1) != -1))
      {
        registryNames.add(reg1);
      }
    }
    for(int i = 0; i < registries.length; i++)
    {
      int index = registries.elementAt(i).indexOf("entry.path");
      String r = registries[i];
      String reg1 = r.substring(index);
      String reg2 = reg1.substring(11);
      paths.add(reg2);
    }
    for(int i2 = 0; i2 < registryNames.length; i2++)
    {
      TableRowElement row = table.insertRow(i2);
      TableCellElement checkboxCell = row.insertCell(-1);
      TableCellElement name = row.insertCell(-1);
      TableCellElement path = row.insertCell(-1);
      checkboxCell.innerHtml = "<input id=checkbox$i2 type='checkbox'>";
      name.text = registryNames[i2];
      path.text = paths.elementAt(i2);
    }
    RegistryTable.createTable();
  }
  
  static List deleteKeys()
  {
    TableElement table = querySelector("#registryTable");
    List<String> catalogueKeys = new List();
    int checkboxLength = table.rows.length;
    for(int i = 0; i < checkboxLength-1; i++)
    {
      CheckboxInputElement checkbox = querySelector("#checkbox$i");
      if(checkbox.checked == true)
      {
        String fileName = parseFileName(table.rows[i+1].innerHtml);
        catalogueKeys.add(fileName);
      }
    }
    return catalogueKeys;
  }
  
  static String parseFileName(String fileName)
  {
    int startTrim = fileName.indexOf("</td>");
    String fileName2 = fileName.substring(startTrim);
    String fileName3 = fileName2.substring(9);
    int endTrim = fileName3.indexOf("</td>");
    String fileName4 = fileName3.substring(0, endTrim);
    String finishedFileName = fileName4;
    return finishedFileName;
  }
}