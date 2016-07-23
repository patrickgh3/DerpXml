#define DerpXmlSax_Init
/// DerpXmlSax_Init(enableDebugMessages)
//
//  Initializes DerpXml. Call this once at the start of your game.
//
//  enableDebugMessages    true to print info using show_debug_message, false to just be silent
//  Returns true if init was successful; false if something went wrong and init was unsucessful


var enableDebugMessages = argument0

if not instance_exists(objDerpXml) {
    instance_create(0, 0, objDerpXml)
}
with objDerpXml {
    self.enableDebugMessages = enableDebugMessages
    xmlString = ''
    stringPos = 0
    currentType = DerpXml_STStart
    currentValue = ''
    currentRawValue = ''
}
return true

#define DerpXmlSax_LoadFromString
/// DerpXmlSax_LoadFromString(xmlString)
//
//  Loads XML contained in a string.
//
//  Returns whether load was successful

var xmlString = argument0

if not is_string(xmlString) {
    
}
objDerpXml.xmlString = xmlString
return true

#define DerpXmlSax_Read
/// DerpXmlSax_Read()
//
//  Reads the next XML node from the loaded file.
//
//  Returns true if the next node was read successfully; false if there
//  are no more nodes to read.

with objDerpXml {
    var readString = ''
    var numCharsRead = 0
    var startedWithOpenBracket = false
    var secondCharSlash = false
    var lastType = currentType
    while true {
        // advance in the document
        stringPos += 1
        
        // detect end of document
        if stringPos > string_length(xmlString) {
            stringPos = string_length(xmlString)
            currentType = DerpXml_STEnd
            currentValue = ''
            currentRawValue = ''
            return false
        }
        
        // grab the new character
        var currentChar =  string_char_at(xmlString, stringPos);
        readString += currentChar
        numCharsRead += 1
        
        // start of tags and slash check
        if numCharsRead == 1 and currentChar == '<' {
            startedWithOpenBracket = true
        }
        else if numCharsRead == 2 and startedWithOpenBracket and currentChar == '/' {
            secondCharSlash = true
        }
        // end of tags
        else if currentChar == '>' {
            if not secondCharSlash {
                currentType = DerpXml_STOpenTag
                currentValue = string_copy(readString, 2, string_length(readString)-2)
                currentRawValue = readString
                return true
            }
            else {
                currentType = DerpXml_STCloseTag
                currentValue = string_copy(readString, 3, string_length(readString)-3)
                currentRawValue = readString
                return true
            }
        }
        // end of whitespace and text
        else if numCharsRead > 1 and currentChar == '<' {
            if string_char_at(xmlString, stringPos+1) == '/' and lastType == DerpXml_STOpenTag {
                currentType = DerpXml_STText
            }
            else {
                currentType = DerpXml_STWhitespace
            }
            stringPos -= 1
            currentValue = string_copy(readString, 1, string_length(readString)-1)
            currentRawValue = currentValue
            return true
        }
    }
}

#define DerpXmlSax_CurType
/// DerpXmlSax_CurType()
//
//  Returns the type of the current node, as a Sax Type ("ST") macro.
//
//      DerpXML_STOpenTag       Opening tag
//      DerpXML_STCloseTag      Closing tag
//      DerpXML_STText          Text inside an element
//      DerpXML_STWhitespace    Whitespace between elements
//      DerpXML_STStart         Start of document, no reads performed yet
//      DerpXML_STEnd           End of document

return objDerpXml.currentType

#define DerpXmlSax_CurValue
/// DerpXmlSax_CurValue()
//
//  Returns the content value of the current node.
//
//  Examples:
//      Tags: returns "tagname"
//      Text: returns "texttext"
//      Whitespace: returns "    "

return objDerpXml.currentValue

#define DerpXmlSax_CurRawValue
/// DerpXmlSax_CurRawValue()
//
//  Returns the raw text that was read for this node, with nothing stripped out.
//
//  Examples:
//      Tags: returns "<tagname>"

return objDerpXml.currentRawValue