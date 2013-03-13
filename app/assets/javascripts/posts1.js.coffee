# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  tinyMCE.init
    "mode": "specific_textareas"
    "editor_selector": "tinymce"
    "theme": "advanced"
    "theme_advanced_buttons1" : "newdocument,|,bold,italic,underline,|,justifyleft,justifycenter,justifyright,|,cut,copy,paste,|,bullist,numlist,|,outdent,indent,|"
    "theme_advanced_buttons2" : "undo,redo,|,link,unlink,anchor,image,|,code,preview,|,forecolor,backcolor,insertdate,inserttime,|,spellchecker,advhr,,removeformat,|,sub,sup,|,charmap,emotions"
    "theme_advanced_buttons3" : ""
    "language": "en"
