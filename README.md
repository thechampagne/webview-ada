# webview-ada

[![](https://img.shields.io/github/v/tag/thechampagne/webview-ada?label=version)](https://github.com/thechampagne/webview-ada/releases/latest) [![](https://img.shields.io/github/license/thechampagne/webview-ada)](https://github.com/thechampagne/webview-ada/blob/main/LICENSE)

Ada binding for a tiny cross-platform **webview** library to build modern cross-platform GUIs.

<p align="center">
<img src="https://raw.githubusercontent.com/thechampagne/webview-ada/main/.github/assets/screenshot.png"/>
</p>

### Requirements
 - Unix
   - [GTK3](https://gtk.org/) and [WebKitGTK](https://webkitgtk.org/)
 - Windows
   - [WebView2 Runtime](https://developer.microsoft.com/en-us/microsoft-edge/webview2/)
 - macOS
   - [WebKit](https://webkit.org/)

### Usage
```ada
with Webview; use Webview;	
with Ada.Text_IO; use Ada.Text_IO;	
with Ada.Exceptions; use Ada.Exceptions;

procedure Main is
	w : Webview_Type;
begin	
	w   := Create;	
	Set_Title(w, "Basic Example");
	Set_Size(w, 480, 320, None);
	Set_Html(w, "Thanks for using webview!");
	Run(w);
	Destroy(w);
exception	
	when E: Webview_Error => Put_Line(Exception_Message(E));
end Main;
```

### References
 - [webview](https://github.com/webview/webview)

### License

This repo is released under the [MIT License](https://github.com/thechampagne/webview-ada/blob/main/LICENSE).
