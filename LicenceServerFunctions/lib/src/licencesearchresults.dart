library licenceSearchResultsFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';
import 'package:TableCreationLibrary/TableCreationLibrary.dart';

class LicenceSearchResults
{
  int checkboxLength = null;
  int nullRows = 0;
  int deletedRows = 0;
  int deletedRows2 = 0;
  
  void loadTable(Event e)
  {
    TableElement table = querySelector("#searchTable");
    int rows = int.parse(window.sessionStorage['rows']);
    
    for(int i = 0; i < rows; i++)
    {
      TableRowElement row = table.insertRow(-1);
      TableCellElement checkboxCell = row.insertCell(0);
      TableCellElement lName = row.insertCell(1);
      TableCellElement lKey = row.insertCell(2);
      TableCellElement lDate = row.insertCell(3);
      checkboxCell.innerHtml = "<input id=checkbox$i type='checkbox'>";
      lName.text = window.sessionStorage["licenceName$i"];
      lKey.text = window.sessionStorage["keyName$i"];
      lDate.text = window.sessionStorage["dateName$i"];
    }
    LicenceTable.createTable();
  }
  
  void returnToPage(MouseEvent m)
  {
    Storage local = window.sessionStorage;
    int rows = int.parse(local['rows']);
    TableElement table = querySelector("#searchTable");
    table.innerHtml = "";
    for(int i = 0; i < rows; i++)
    {
      local['licenceDate$i'] = "";
      local['licenceName$i'] = "";
      local['licenceKey$i'] = "";
    }
    local['rows'] = "";
    checkboxLength == null;
    window.location.href = "removeLicence.html";
  }
  
  void deleteLicences(MouseEvent m)
  {
    List<String> licencesForDeletion = new List<String>();
    PopupSelection ps = new PopupSelection();
    licencesForDeletion = listLicences();

    if(licencesForDeletion.length == 0 || licencesForDeletion.length == null)
    {
      ps.errorPrompt("No-Licences-Selected");
    }
    if(licencesForDeletion.length > 0)
    {
      completeDeletion();
    }
  }
  
  void completeDeletion()
  {
    TableElement table = querySelector("#searchTable");
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    
    for(int i = 0; i < checkboxLength-1; i++)
    {
      CheckboxInputElement checkbox = querySelector("#checkbox$i");
         
      if(checkbox == null)
      {
        deletedRows = deletedRows+1;
        continue;
      }
        
      if(checkbox.checked == true)
      {
        String innerHtmlFull = table.rows[i+1-deletedRows].innerHtml;
        String key = getKeyValue(innerHtmlFull);
        ServerRequest.removeLicence(key, window.sessionStorage['username'],window.sessionStorage['password'],
                      ServerRequest.defaultUri(), moveToNext(), (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
      }
    }
    removeRows();
    pc.getResult(ps.licenceSuccessPrompt("Remove-Licence"), "");
    nullRows = 0;
    deletedRows = 0;
    deletedRows2 = 0;
  }
  
  
  List listLicences()
  {
    TableElement table = querySelector("#searchTable");
    List<String> licences = new List<String>();
    if(checkboxLength == null)
    {
      checkboxLength = table.rows.length;      
    }
    
    for(int i = 0; i < checkboxLength-1; i++)
    {
      CheckboxInputElement checkbox = querySelector("#checkbox$i");
      
      if(checkbox == null)
      {
        nullRows = nullRows+1;
        continue;
      }
      
      if(checkbox.checked == true && nullRows  != 0)
      {
        String licenceName = getKeyValue(table.rows[i+1-nullRows].innerHtml);
        licences.add(licenceName);
      }
      
      if(checkbox.checked == true && nullRows == 0)
      {
        String licenceName = getKeyValue(table.rows[i+1].innerHtml);
        licences.add("LICENCE NAME: "+licenceName);
      }
    }
    return licences;
  }
  
  
  removeRows()
  {
    TableElement table = querySelector("#searchTable");
    int deletedRows1 = 0;
     
    for(int i = 0; i < checkboxLength-1; i++)
    {
      CheckboxInputElement checkbox = querySelector("#checkbox$i");
       
      if(checkbox == null)
      {
        deletedRows2 = deletedRows2+1;
        continue;
      }
         
      if(checkbox.checked == true && i == 0 && deletedRows2 == 0)
      {
        table.rows[i+1].remove();
        deletedRows1++;
        continue;
      }
      if(checkbox.checked == true && i-deletedRows1 == 0 && deletedRows2 == 0)
      {
        table.rows[1].remove();
        deletedRows1++;
        continue;
      }
      if(checkbox.checked == true && i != 0 && deletedRows2 == 0)
      {
        int row = i-deletedRows1;
        table.rows[row+1].remove();
        deletedRows1++;
        continue;
      }
      if(checkbox.checked == true && i == 0 && deletedRows2 != 0)
      {
        table.rows[1].remove();
        deletedRows1++;
        continue;
      }
      if(checkbox.checked == true && i != 0 && deletedRows2 != 0)
      {
        int row = i-deletedRows1-deletedRows2;
        table.rows[row+1].remove();
        deletedRows1++;
        continue;
      }
    }
  }
  
  moveToNext()
  {
    return;
  }
  
  String getKeyValue(String rowInnerHtml)
  {
    String innerHtmlFull = rowInnerHtml;
    int trim1 = innerHtmlFull.indexOf("</td>");
    String key1 = innerHtmlFull.substring(trim1);
    String key2 = key1.substring(5);
    int trim2 = key2.indexOf("</td>");
    String key3 = key2.substring(trim2);
    String key4 = key3.substring(9);
    String key5 = key4.substring(0, 29);
    return key5;
  } 
}