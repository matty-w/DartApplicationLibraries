library createLicenceFunctions;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';
import 'package:SoapRequestLibrary/SoapRequestLibrary.dart';


class CreateLicenceFunctions
{ 
  
  String isoDate;
  String licenceLength;
  String licenceLengthError;
  
  void disableDateLengthTextBox()
  {
    InputElement specifiedLengthTextbox = querySelector("#specifiedLength");
    specifiedLengthTextbox.disabled = true;
  }
  
  void createDefaultDate()
  {
    DateInputElement date = querySelector("#specifiedLength"); 
    date.value = today(3);
  }
  
  void listenToRadioButtons()
  {
    querySelector("#thirtyDays").onChange.listen(createThirtyDayLicence);
    querySelector("#neverExpires").onChange.listen(createUnlimitedLicence);
    querySelector("#specified").onChange.listen(createUserSpecifiedLicence);
  }
  
  void setRadioButtons()
  {
    (querySelector("#thirtyDays") as RadioButtonInputElement).checked = false;
    (querySelector("#neverExpires") as RadioButtonInputElement).checked = false;
    (querySelector("#specified") as RadioButtonInputElement).checked = false;
  }
  
  void createThirtyDayLicence(Event e)
  { 
    disableTextbox(e);
    createDefaultDate();
    thirtyDayDate();
  }
  
  void createUnlimitedLicence(Event e)
  {
    disableTextbox(e);
    createDefaultDate();
    OutputElement unlimited = querySelector("#expiryDate");
    unlimited.innerHtml = "";
  }
  
  void createUserSpecifiedLicence(Event e)
  {
    enableTextbox(e);
    DateInputElement i = querySelector("#specifiedLength");
    OutputElement specified = querySelector("#expiryDate");
    specified.innerHtml = "";
    licenceLength = i.value;
  }
  
  void enableTextbox(Event e)
  {
    InputElement specifiedLengthTextbox = querySelector("#specifiedLength");
    specifiedLengthTextbox.disabled = false;
  }
  
  void disableTextbox(Event e)
  {
    InputElement specifiedLengthTextbox = querySelector("#specifiedLength");
    specifiedLengthTextbox.disabled = true;
  }
  
  void thirtyDayDate()
  {
    DateTime baseDate = new DateTime.now();
    DateTime licenceDate = baseDate.add(new Duration(days: 30));
    String date = licenceDate.toString();
    isoDate = date.substring(0,10);
    String printedDate = isoDate.split("-").reversed.join("-");
    OutputElement thirtyDays = querySelector("#expiryDate");
    thirtyDays.innerHtml = "The Licence Will Expire On: "+printedDate;
    licenceLength = thirtyDays.value;
  }
  
  String today(int days)
  {
    DateTime baseDate = new DateTime.now();
    DateTime minDate = baseDate.add(new Duration(days: days));
    String baseDateString = minDate.toString();
    String finalDate = baseDateString.substring(0,10);
    return finalDate;
  }
  
  void submitForm(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    InputElement un = querySelector("#username");
    InputElement fe = querySelector("#filter");
    InputElement url = querySelector("#url");
    RadioButtonInputElement specifiedChoice = querySelector("#specified");
    RadioButtonInputElement thirtyDay = querySelector("#thirtyDays");
    RadioButtonInputElement unlimited = querySelector("#neverExpires");
    String userValue; 


    if(!(specifiedChoice.checked) && !(thirtyDay.checked) && !(unlimited.checked))
    {
      ps.errorPrompt("No-Option-Selected");
      return;
    }
    
    if(un.value == null || un.value.trim() == "")
    {
      ps.errorPrompt("No-Licence");
      return;
    }
    
    if(specifiedChoice.checked)
      if(checkDateValue() == false)
      {  
        pc.getResult(ps.errorPrompt("Invalid-Date"), licenceLengthError);
        return;
      }    
    
    if(checkUsername() == true)
    {
      ps.licenceFormatPopup();
      return;
    } 
    else
    {
      String shortDate = licenceLengthValue();
        
      if (un.value.length==0)
        return;
      if (!hasButtonSet())
        return;
        
      userValue = un.value;
      if (url.value.length>0)
        userValue = userValue+"("+url.value+")";
      
      LicenceServerRequests.addLicence(userValue,shortDate,fe.value, window.sessionStorage['username'],
                                        window.sessionStorage['password'], LicenceServerRequests.defaultUri(),
                                        (s) => pc.getResult(ps.licenceClipboardPopup("Create-Licence"), s),
                                        (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
      un.value = "";
      fe.value = "";
      }
  }
  
  void completeLicence(MouseEvent m)
  {
    PopupSelection ps = new PopupSelection();
    PopupConstructor pc = new PopupConstructor();
    ps.licenceClipboardPopup("Create-Licence");
    InputElement un = querySelector("#username");
    InputElement fe = querySelector("#filter");
    InputElement url = querySelector("#url");
    String userValue;
    
    String shortDate = licenceLengthValue();
          
    if (un.value.length==0)
      return;
    if (!hasButtonSet())
      return;
          
    userValue = un.value;
    if (url.value.length>0)
      userValue = userValue+"("+url.value+")";
    
    LicenceServerRequests.addLicence(userValue,shortDate,fe.value,window.sessionStorage['username'],
                                     window.sessionStorage['password'],LicenceServerRequests.defaultUri(),
                                     (s) => pc.getResult(ps.licenceClipboardPopup("Create-Licence"), s),
                                     (s) => pc.getResult(ps.errorPrompt("Server-Error"), s));
    un.value = "";
    fe.value = "";
  }
  
  String chosenDate()
  {
    DateInputElement date = querySelector("#specifiedLength");
    String baseChoice = date.value;
    String dateChoice = baseChoice.split("-").reversed.join("-");
    return dateChoice;
  }
  
  String licenceLengthValue()
  {
    if((querySelector("#thirtyDays") as RadioButtonInputElement).checked)
      return isoDate;
    else if((querySelector("#specified") as RadioButtonInputElement).checked)
      return chosenDate();
    else
      return "";
  }
  
  bool checkDateValue()
  {
    DateInputElement dateInput = querySelector("#specifiedLength");
    DateTime shortDate = DateTime.parse(dateInput.value);
    DateTime now = new DateTime.now();
    int day = now.day+2;
    DateTime nowWithoutTime = new DateTime(now.year,now.month,now.day,1,0,0,0);
    DateTime nowPlusThree = new DateTime(now.year,now.month,day,1,0,0,0);
    
    if(shortDate == nowWithoutTime)
    {  
      licenceLengthError = "Invalid Date : Licence Cannot Expire On Current Day";
      return false;
    }  
    else if(shortDate == null)
    {  
      licenceLengthError = "Please Enter A Date";
      return false;
    }  
    else if(!(shortDate.isAfter(nowWithoutTime)))
    {  
      licenceLengthError = "Invalid Date: Licence Cannot Be Set Before Current Day";
      return false;
    }  
    else if(!(shortDate.isAfter(nowPlusThree)))
    {  
      licenceLengthError = "Invalid Date: Licence Must Have Minimum Length Of Three Days";
      return false;
    }  
    else
    return true;
  }
  
  bool hasButtonSet()
  {
    return (querySelector("#thirtyDays") as RadioButtonInputElement).checked ||
    (querySelector("#neverExpires") as RadioButtonInputElement).checked ||
    (querySelector("#specified") as RadioButtonInputElement).checked;
  }
  
  bool checkUsername()
  {
    InputElement input = querySelector("#username");
    String username = input.value;
      
    RegExp exp = new RegExp("[a-zA-Z0-9][a-zA-Z0-9-_\s]+@[a-zA-Z0-9-\s].+\.[a-zA-Z]{2,5}");
         
    if(!(exp.hasMatch(username)))
    {  
      return true;  
    }
    else  
      return false;
  }
}