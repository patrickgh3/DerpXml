/// DerpXml_Init(enableDebugMessages)
//
//  Initializes DerpXml. Call this once at the start of your game.
//
//  enableDebugMessages    true to print info using show_debug_message, false to just be silent
//  Returns true if init was successful; false if something went wrong and init was unsucessful

var edb = argument0

// write
if not instance_exists(objDerpXmlRead) {
    instance_create(0, 0, objDerpXmlRead)
}
with objDerpXmlRead {
    enableDebugMessages = edb
    readMode_String = 0
    readMode_File = 1
    
    readMode = readMode_String
    xmlString = ''
    xmlFile = -1
    
    stringPos = 0
    currentType = DerpXmlType_StartOfFile
    currentValue = ''
    currentRawValue = ''
}

// read
if not instance_exists(objDerpXmlWrite) {
    instance_create(0, 0, objDerpXmlWrite)
}
with objDerpXmlWrite {
    enableDebugMessages = edb
    indentString = '  '
    newlineString = chr(10)
    
    writeString = ''
    currentIndent = 0
    lastWriteType = 'Start'
}

return true
