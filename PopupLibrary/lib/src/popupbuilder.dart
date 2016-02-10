library builder;

import 'popupconstructor.dart';
import 'dart:html';

class PopupBuilder
{
  PopupConstructor pc = new PopupConstructor();
  
  void createAddRegistryPrompt() 
  {
    pc.setRegistryText("Add-Registry");
    pc.removePictures(true);
    pc.setKeyTextbox(true);
    pc.setSelectPathBox(true);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, true, false, false);
    pc.basicPopup("#popUpDiv");
  }
  
  void createAddRegistryConfirmPrompt(String regName, String contentPath)
  {
    pc.setRegistryText("Add-Registry-Confirm");
    pc.removePictures(false);
    pc.setQuestionMarkPicture(true);
    pc.setKeyTextbox(false);
    pc.setSelectPathBox(false);
    pc.setServerTextForAddEditRegistry(regName, contentPath);
    pc.hideBreaks(true);
    pc.hideCommandButtons(false, false, true, true, true);
    pc.basicPopup("popUpDiv");
  }
  
  void createEditRegistryConfirmPrompt(String regName, String contentPath)
  {
    pc.setRegistryText("Edit-Registry-Confirm");
    pc.removePictures(false);
    pc.setQuestionMarkPicture(true);
    pc.setKeyTextbox(false);
    pc.setSelectPathBox(false);
    pc.setServerTextForAddEditRegistry(regName, contentPath);
    pc.hideBreaks(true);
    pc.hideCommandButtons(false, false, true, true, true);
    pc.basicPopup("popUpDiv");
  }
  
  void createEditRegistryPrompt(String key)
  {
    pc.setRegistryText("Edit-Registry");
    pc.removePictures(true);
    pc.setKeyTextboxEdit(true);
    pc.setKeyName(key);
    pc.setSelectPathBox(true);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, true, false, false);
    pc.basicPopup("#popUpDiv");
  }
  
  void createDeleteRegistryPrompt(List keys)
  {
    pc.setRegistryText("Delete-Registry");
    pc.removePictures(false);
    pc.setQuestionMarkPicture(true);
    pc.setKeyTextbox(false);
    pc.setSelectPathBox(false);
    pc.setKeysList(keys);
    pc.hideBreaks(false);
    pc.hideCommandButtons(false, false, true, true, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createLicenceSuccessPrompt(String successAction)
  {
    pc.setLicenceText(successAction);
    pc.removePictures(false);
    pc.setErrorPicture(false);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, false, true, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createRegistrySuccessPrompt(String successAction)
  {
    pc.setRegistryText(successAction);
    pc.removePictures(false);
    pc.setErrorPicture(false);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, false, true, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createAddProjectSuccessPrompt(String successAction, String projectName, List helpers)
  {
    pc.setAddProjectText(successAction, projectName, helpers);
    pc.removePictures(false);
    pc.setErrorPicture(false);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, false, true, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createProjectSuccessPrompt(String successAction, String projectName, String folderName)
  {
    pc.setProjectText(successAction, projectName, folderName);
    pc.removePictures(false);
    pc.setErrorPicture(false);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, false, true, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createProjectFailPrompt(String failAction, String projectName, List helpers)
  {
    pc.setAddProjectText(failAction, projectName, helpers);
    pc.removePictures(false);
    pc.setErrorPicture(true);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, true, false, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createErrorPrompt(String errorMessage)
  {
    pc.setErrorText(errorMessage);
    pc.removePictures(false);
    pc.setErrorPicture(true);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, true, false, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createLicenceClipboardPopup(String successAction)
  {
    pc.setLicenceText(successAction);
    pc.removePictures(false);
    pc.setErrorPicture(false);
    pc.hideBreaks(true);
    pc.hideCommandButtons(true, true, true, false, false);
    pc.basicPopup("#popUpDiv");
  }
  
  void createLicenceFormatPopup()
  {
    pc.setLicenceText("Licence-Format");
    pc.removePictures(false);
    pc.setQuestionMarkPicture(true);
    pc.hideBreaks(true);
    pc.hideCommandButtons(false, false, true, true, true);
    pc.basicPopup("#popUpDiv");
  }
  
  void createFilePopup()
  {
    pc.filePopup("#fileBrowserDiv");
  }
}