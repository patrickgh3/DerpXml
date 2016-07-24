#define DerpXmlWrite_Init
/// DerpXmlWriteInit(enableDebugMessages)
//
//  Initializes DerpXml Write. Call this once at the start of your game.
//
//  enableDebugMessages    true to print info using show_debug_message, false to just be silent
//  Returns true if init was successful; false if something went wrong and init was unsucessful

if not instance_exists(objDerpXmlWrite) {
    instance_create(0, 0, objDerpXmlWrite)
}
with objDerpXmlWrite {
    indentString = '  '
    newlineString = chr(10)
    
    writeString = ''
    currentIndent = 0
    lastWriteType = 'Start'
}
return true

#define DerpXmlWrite_Config
/// DerpXmlWrite_Config(indentString, newlineString)
//
//  Configures options for writing.
//
//  indentString     String used for indents, e.g. "    ". Set to "" to disable indents.
//  newlineString    String used for newlines, e.g. chr(10). Set to "" to disable newlines.

var indentString = argument0
var newlineString = argument1

with objDerpXmlWrite {
    self.indentString = indentString
    self.newlineString = newlineString
}

#define DerpXmlWrite_New
/// DerpXmlWrite_New(filePath)
//
//  Starts a new empty xml string.

with objDerpXmlWrite {
    writeString = ''
    currentIndent = 0
    lastWriteType = 'Start'
}

#define DerpXmlWrite_GetString
/// DerpXmlWrite_GetString()
//
//  Returns the finished xml string.

return objDerpXmlWrite.writeString

#define DerpXmlWrite_OpenTag
/// DerpXmlWrite_OpenTag(value)
//
//  Writes an open tag, e.g. <tagname>
//
//  value    The tag name

var value = argument0;

with objDerpXmlWrite {
    if lastWriteType == 'OpenTag' {
        writeString += newlineString
        currentIndent += 1
    }
    repeat currentIndent {
        writeString += indentString
    }
    writeString += '<'+value+'>'
    lastWriteType = 'OpenTag'
}

#define DerpXmlWrite_CloseTag
/// DerpXmlWrite_CloseTag(value)
//
//  Writes a close tag, e.g. </tagname>
//
//  value    The tag name

var value = argument0;

with objDerpXmlWrite {
    if lastWriteType == 'CloseTag' {
        currentIndent -= 1
    }
    if lastWriteType != 'Text' {
        repeat currentIndent {
            writeString += indentString
        }
    }
    writeString += '</'+value+'>'
    writeString += newlineString
    lastWriteType = 'CloseTag'
}

#define DerpXmlWrite_Text
/// DerpXmlWrite_Text(value)
//
//  Writes text for the middle of an element.
//
//  value    The text

var value = argument0;

with objDerpXmlWrite {
    writeString += value
    lastWriteType = 'Text'
}