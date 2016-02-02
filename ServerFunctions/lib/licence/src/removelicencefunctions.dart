library removeLicenceFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';

class RemoveLicenceFunctions
{
  void removeLicence(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement licence = querySelector("#licence");
    String licenceValue;
    licenceValue = licence.value;
    
    if(licenceValue == null || licenceValue.trim() == "")
    {
      ps.errorPrompt("No-Licence-Name");
      return;
    }
    
    LicenceServerRequests.removeLicence(licenceValue, window.sessionStorage['username'],window.sessionStorage['password'],
                                LicenceServerRequests.defaultUri(), 
                                (s) => pc.getResult(ps.licenceSuccessPrompt("Remove-Licence"), s),
                                (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
  }
  
  void searchLicences(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement search = querySelector("#licenceSearch");
    String licenceSearch;
    licenceSearch = search.value;
    if(!(licenceSearch.trim() == "") && !licenceSearch.contains(".*"))
    {
      licenceSearch = licenceSearch+".*";
    }
    
    if(licenceSearch == null || licenceSearch.trim() == "")
    {
      ps.errorPrompt("No-Search-Value");
      return;
    }
    
    LicenceServerRequests.searchForLicences(licenceSearch, window.sessionStorage['username'],window.sessionStorage['password'],
                                     LicenceServerRequests.defaultUri(),
                                    (s) => goToSearchResultPage(s), 
                                    (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
  }
  
  goToSearchResultPage(List responseList)
  {
    List<String> keyList = new List<String>();
    List<String> nameList = new List<String>();
    List<String> dateList = new List<String>();
    window.sessionStorage['rows'] = responseList.length.toString();
    for(int i = 0; i < responseList.length; i++)
    {
      String fullResponse = responseList[i];
      int indexName = fullResponse.indexOf("date=");
      String key = fullResponse.substring(4, 33);
      String name = fullResponse.substring(38, indexName);
      String dateFull = fullResponse.substring(indexName);
      String dateTrim = dateFull.substring(5);
      if(dateTrim == "" || dateTrim == null)
      {
        dateTrim = "Unlimited Licence";
      }
      keyList.add(key);
      nameList.add(name);
      dateList.add(dateTrim);
    }
    storeValues(keyList, nameList, dateList);
    window.location.href = "searchResults.html";
  }
  
  storeValues(List key, List name, List date)
  {
    Storage local = window.sessionStorage;
    for(int i = 0; i < key.length; i++)
    {
      local['keyName$i'] = key[i];
      local['licenceName$i'] = name[i];
      local['dateName$i'] = date[i];
    }
  }
}  