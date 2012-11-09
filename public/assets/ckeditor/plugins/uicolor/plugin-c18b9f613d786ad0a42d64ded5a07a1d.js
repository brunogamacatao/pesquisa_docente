/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.plugins.add("uicolor",{requires:["dialog"],lang:["en","he"],init:function(e){if(CKEDITOR.env.ie6Compat)return;e.addCommand("uicolor",new CKEDITOR.dialogCommand("uicolor")),e.ui.addButton("UIColor",{label:e.lang.uicolor.title,command:"uicolor",icon:this.path+"uicolor.gif"}),CKEDITOR.dialog.add("uicolor",this.path+"dialogs/uicolor.js"),CKEDITOR.scriptLoader.load(CKEDITOR.getUrl("plugins/uicolor/yui/yui.js")),e.element.getDocument().appendStyleSheet(CKEDITOR.getUrl("plugins/uicolor/yui/assets/yui.css"))}});