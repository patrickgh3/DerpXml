/// DerpXmlRead_OpenFile(xmlFilePath)
//
//  Opens an XML document from file. Be sure to call DerpXmlRead_CloseFile when you're done.
//
//  xmlFilePath    Path to a .xml file
//  Returns whether load was successful

var xmlFilePath = argument0

var file = file_text_open_read(xmlFilePath)
if file == -1 {
    return false
}
with objDerpXmlRead {
    xmlFile = file
    readMode = readMode_File
    xmlString = file_text_read_string(xmlFile)
    
    stringPos = 0
    currentType = DerpXmlType_StartOfFile
    currentValue = ''
    currentRawValue = ''
    lastReadEmptyElement = false
}

return true
