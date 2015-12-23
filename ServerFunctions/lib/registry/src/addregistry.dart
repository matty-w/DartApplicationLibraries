library addRegistry;

import 'dart:html';
import 'package:PopupLibrary/PopupLibrary.dart';

class AddRegistry
{
  PopupSelection ps = new PopupSelection();
  
  void addButton(MouseEvent m)
  {
    ps.addRegistryPrompt();
  }
}