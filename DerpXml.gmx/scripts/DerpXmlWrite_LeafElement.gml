/// DerpXMlWrite_LeafElement(tagName, text)
//
//  Writes an element with no children, e.g. <tagname>text</tagname>

var tagName = argument0
var text = argument1

DerpXmlWrite_OpenTag(tagName)
DerpXmlWrite_Text(text)
DerpXmlWrite_CloseTag()
