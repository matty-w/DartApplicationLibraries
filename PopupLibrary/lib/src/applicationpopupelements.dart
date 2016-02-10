
import 'dart:html';
import 'popupactions.dart';

class ApplicationPopupElements extends PopupActions  
{
  void setErrorPicture(bool a)
  {
    if(a == true)
      querySelector("#tick").setAttribute("src", "images/dialogWarning2.png");
    else
      querySelector("#tick").setAttribute("src", "images/ticksmall.png");
  }
  
  void setQuestionMarkPicture(bool a)
  {
    if(a == true)
      querySelector("#tick").setAttribute("src", "images/questionMark.png");
    else
      querySelector("#tick").setAttribute("src", "images/ticksmall.png");
  }
  
  void removePictures(bool a)
  {
    if(a == true)
      querySelector("#pictureDiv").innerHtml = "";
    else if(a == false)
      querySelector("#pictureDiv").innerHtml = '<img id = "tick" src = "images/ticksmall.png"/>';
      return;
  }
  
  void setFailText(String title, String description)
  {
    querySelector("#popupTitle").innerHtml = title;
    OutputElement text = querySelector("#popupText");
    text.innerHtml = description;
  }
  
  void setRegistryText(String option)
  {
    String title;
    String description;
    
    if(option == "Add-Registry")
    {
      ButtonElement buttonText = querySelector("#popupAction");
      buttonText.innerHtml = "Add Registry";
      title = "Add Registry Entry";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = "";
    }
    if(option == "Add-Registry-Success")
    {
      title = "Registry Added";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      description = "The Registry Entry Has Been Successfully Added";
      text.innerHtml = description;
    }
    if(option == "Edit-Registry")
    {
      ButtonElement buttonText = querySelector("#popupAction");
      buttonText.innerHtml = "Edit Registry";
      title = "Edit Registry Entry";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      description = "";
      text.innerHtml = description;
    }
    if(option == "Delete-Registry")
    {
      ButtonElement buttonText = querySelector("#popupAction");
      buttonText.innerHtml = "Delete Registry";
      title = "Delete Registry Entry";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = "";
    }
    if(option == "Delete-Success")
    {
      title = "Delete Completed";
      description = "The Registry Entrties Were Successfully Deleted.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Add-Registry-Confirm")
    {
      title = "Confirm Registry Addition?";
      description = "The Following Will Be Created At: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Edit-Registry-Confirm")
    {
      title = "Confirm Registry Edit?";
      description = "If Yes Is Selected, The Registry Will Be Placed At: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
  }
  
  void setLicenceText(String option)
  {
    String title;
    String description;
    
    if(option == "Create-Licence")
    {
      title = "Licence Created";
      description = "The Licence Is: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Add-Admin")
    {
      title = "Admin Created";
      description = "The Admin Account Was Successfully Created: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Add-Permissions")
    {
      title = "Permission Added";
      description = "The Permission Was Successfully Added: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Remove-Permissions")
    {
      title = "Permission Removed";
      description = "The Permission Was Successfully Removed: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Change-Password")
    {
      title = "Password Changed";
      description = "Your Password Was Successfully Changed: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Regenerate-Licence")
    {
      title = "Licence Regenerated";
      description = "The Licence Has Been Successfully Regenerated: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Remove-Admin")
    {
      title = "Admin Removed";
      description = "The Admin Has Been Successfully Removed: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Remove-Licence")
    {
      title = "Licence Removed";
      description = "The Licence(s) Has Been Successfully Removed: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    } 
    if(option == "Licence-Format")
    {
      title = "Licence Format";
      description = "The Licence You Are About To Create Does Not Adhere To The Common Format (example@zizo.co.uk) Continue?";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
  }
  
  void setProjectText(String option, String projectName, String folderName)
  {
    String title;
    String description;
    
    if(option == "Delete-Project-Success")
    {
      title = "Project Deleted";
      description = "The Project "+"'"+projectName+"'"+" Was Successfully Deleted.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "User-Added-To-Project")
    {
      title = "User Added To Project";
      description = "The User Has Been Successfully Added To The Project: "+projectName;
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Project-Details-Edited")
    {
      title = "Project Details Edited";
      description = "The Project "+"'"+projectName+"'"+" Have Been Successfully Edited";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "User-Removed-From-Project")
    {
      title = "Project User Removed";
      description = "The User Has Successfully Been Removed From The Project '"+projectName+"'";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Secured-Project-Success")
    {
      title = "Project Successfully Secured";
      description = "The Project '"+projectName+"' Has Been Successfully Secured.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Unsecure-Project-Success")
    {
      title = "Project Successfully Unsecured";
      description = "The Project '"+projectName+"' Has Been Successfully Unsecured.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Folder-Successfully-Added")
    {
      title = "Folder Successfully Added";
      description = "The Project '"+projectName+"' Had The Folder Successfully Added.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Tag-Project-Success")
    {
      title = "Folder Successfully Tagged";
      description = "The Folder '"+folderName+"' In The Project '"+projectName+"' Has Been Successfully Tagged";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
  }
  
  void setAddProjectText(String option, String projectName, List helpers)
  {
    String title;
    String description;
    
    if(option == "Add-Project-With-Helpers")
    {
      title = "Project Added";
      description = "The Project "+projectName+" Was Successfully Added. With The Helper(s): "+helpersList(helpers)+".";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Add-Project-Without-Helpers")
    {
      title = "Project Added";
      description = "The Project "+projectName+" Was Successfully Added.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(option == "Add-Helper-Fail")
    {
      title = "Error In Project";
      description = "While The Project "+projectName+" Was Created Successfully. The Helper(s): "+helpersList(helpers)+" Were Not "+
          "Installed Properly. Either Delete The Project And Try Again, Or Try Add The Helpers From The 'Edit' Page";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
  }
  
  String helpersList(List helpers)
  {
    String helpersString = "";
    
    for(int i = 0; i < helpers.length; i++)
    {
      helpersString = helpersString+helpers[i]+", "; 
    }
    int stringLength =  helpersString.length;
    String helpersStringFinal = helpersString.substring(0, stringLength-2);
    return helpersStringFinal;
  }
  
  void setErrorText(String error)
  {
    String title = "Error";
    String description;
    
    if(error == "Server-Error")
    {
      description = "A Server Side Error Has Occured, The Error Reads:";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Licence")
    {
      description = "No Licence Name Entered, Please Enter A Licence Name.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Username")
    {
      description = "No Username Entered, Please Enter A Username.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Password")
    {
      description = "Password Not Entered, Please Enter A Password.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Licence-Name")
    {
      description = "Please Enter A Licence Key To Continue.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Option-Selected")
    {
      description = "No Licence Length Option Selected, Please Pick An Option.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
    }
    if(error == "No-Search-Value")
    {
      description = "No Value Entered Into Search Box, Please Enter The Search Criteria And Try Again";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
    }
    if(error == "No-Licences-Selected")
    {
      description = "No Licences Have Been Selected For Deletion, Please Select At Least One And Try Again";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
    }
    if(error == "Passwords-Dont-Match")
    {
      description = "The Passwords Do Not Match, Please Try Again.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Incorrect-Details")
    {
      description = "The Username and/or Password are invalid, please try again.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
      OutputElement server = querySelector("#serverResponse");
      server.innerHtml = "";      
    }
    if(error == "Invalid-Date")
    {
      description = "The Date Entered Is Invalid";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Too-Many-Selected")
    {
      description = "You Have Selected Too Many Keys For Editing, Please Select Only One Key At A Time";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Entries-Selected-Edit")
    {
      description = "You Haven't Selected A Key For Editing, Please Select A Key.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Entries-Selected")
    {
      description = "You Haven't Selected Any Keys For Deletion, Please Select At Least One And Try Again.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Project-Name")
    {
      description = "There Is No Name Entered For The Project, Please Enter A Name And Try Again";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Project-Location")
    {
      description = "There Is No Location For The Project, Either Type In The Exact Location. Or Use The 'Browse' Button.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Add-Project-Fail")
    {
      description = "There Has Been An Error Attempting TO Create The Project, The Error Reads: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Project-Delete-Fail")
    {
      description = "There Has Been An Error Attempting To Delete This Project, The Error Reads: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Add-User-To-Project-Fail")
    {
      description = "There Has Been An Error Attempting To Add A User To This Project, The Error Reads: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Error-Editing-Project")
    {
      description = "There Has Been An Error Attempting To Edit The Project, The Error Reads: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Remove-User-From-Project-Fail")
    {
      description = "There Has Been An Error Attempting To Remove The User From The Project, The Error Reads: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Error-Adding-User-Project-Permissions")
    {
      description = "While The User Has Been Added To The Project, There Has Been An Error Adding Some User Permissions, Please Delete The "+
          "User And Try Again.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "Project-Security-Fail")
    {
      description = "There Was A Problem Un/Securing The Selected Project, The Error Reads: ";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Folder-Name-Entered")
    {
      description = "No Folder Name Entered In The Folder Name Input Box, Please Enter A Name And Try Again.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
    if(error == "No-Tag-Input")
    {
      description = "No Tag Input Entered. Please Enter A Tag Name For The Folder And Try Again.";
      querySelector("#popupTitle").innerHtml = title;
      OutputElement text = querySelector("#popupText");
      text.innerHtml = description;
    }
  }
  
  void setRegistryTextboxes(bool a)
  {
    if(a == false)
    {
      querySelector("#addBreak").hidden = true;
      querySelector("#addLabel1").style.display = "none";
      querySelector("#addLabel2").style.display = "none";
      querySelector("#browseText").style.display = "none";
      querySelector("#browseButton").style.display = "none";
      querySelector("#keyText").style.display = "none";
    }
    else if(a == true)
    {
      querySelector("#addBreak").hidden = false;
      querySelector("#addRegistry").innerHtml = "Add Registry";
      querySelector("#addLabel1").style.display = "inline-block";
      querySelector("#addLabel2").style.display = "inline-block";
      querySelector("#browseText").style.display = "inline-block";
      querySelector("#browseButton").style.display = "inline-block";
      querySelector("#keyText").style.display = "inline-block";
    }
  }
  
  void hideBreaks(bool a)
  {
    if(a == true)
    {
      querySelector("#addBreak").hidden = true;
    }
    else if(a == false)
    {
      querySelector("#addBreak").hidden = false;
    }
  }
  
  void setList(List filesForDeletion)
  {
    OutputElement text = querySelector("#popupText");
    String endList = "";
    String currentText;
    int num = 1;
    for(int i = 0; i < filesForDeletion.length; i++)
    {
      currentText = "Key "+num.toString()+": "+filesForDeletion[i]+" ";
    
      endList = endList+currentText;
      num++;
    }
    text.innerHtml = endList;
  }
  
  void setXmlResponse(String response)
  {
    String title = "Response";
    String description = "The Server Responds With: ";
    OutputElement server = querySelector("#serverResponse");
    querySelector("#popupTitle").innerHtml = title;
    server.innerHtml = response;
    OutputElement text = querySelector("#popupText");
    text.innerHtml = description;  
  }
  
  void setKeyName(String key)
  {
    InputElement keyBox = querySelector("#keyText");
    keyBox.value = key;
  }
  
  void setKeyTextbox(bool a)
  {
    InputElement box = querySelector("#keyText");
    
    if(a == true)
    {
      querySelector("#addLabel1").style.display = "inline-block";
      querySelector("#keyText").style.display = "inline-block";
      box.disabled = false;
      querySelector("#ulRegKey").style.display = "";
    }
    else if(a == false)
    {
      querySelector("#addLabel1").style.display = "none";
      querySelector("#keyText").style.display = "none";
      querySelector("#ulRegKey").style.display = "none";
    }
  }
  
  void setKeyTextboxEdit(bool a)
  {
    InputElement box = querySelector("#keyText");
    
    if(a == true)
    {
      querySelector("#addLabel1").style.display = "inline-block";
      querySelector("#keyText").style.display = "inline-block";
      box.disabled = true;
      querySelector("#ulRegKey").style.display = "";
    }
    else if(a == false)
    {
      querySelector("#addLabel1").style.display = "none";
      querySelector("#keyText").style.display = "none";
      querySelector("#ulRegKey").style.display = "none";
    }
  }
  
  void setEditKeyText(String registryKey)
  {
    InputElement text = querySelector("#keyText");
    text.value = registryKey;
  }
  
  void setKeysList(List keys)
  {
    int keyLength = keys.length;
    OutputElement text = querySelector("#popupText");
    StringBuffer listOfKeys = new StringBuffer();
    
    for(int i = 0; i < keyLength; i++)
    {
      String key = keys[i]+", ";
      listOfKeys.write(key);
    }
    String stringBuffer = listOfKeys.toString();
    String finishedList = stringBuffer.substring(0, stringBuffer.length-2);
    text.innerHtml = finishedList;
  }
  
  void setSelectPathBox(bool a)
  {
    if(a == true)
    {
      querySelector("#addLabel2").style.display = "inline-block";
      querySelector("#browseText").style.display = "inline-block";
      querySelector("#browseButton").style.display = "inline-block";
      querySelector("#ulConPath").style.display = "";
    }
    else if(a == false)
    {
      querySelector("#addLabel2").style.display = "none";
      querySelector("#browseText").style.display = "none";
      querySelector("#browseButton").style.display = "none";
      querySelector("#ulConPath").style.display = "none";
    }
  }
  
  
  void setServerTextForAddEditRegistry(String regName, String contentPath)
  {
    String regAndPath = regName+" - "+contentPath;
    OutputElement text = querySelector("#serverResponse");
    text.innerHtml = regAndPath;
  }
}