/// DerpXmlRead_Read()
//
//  Reads the next XML node from the loaded file.
//
//  Returns true if the next node was read successfully; false if there
//  are no more nodes to read.

with objDerpXmlRead {
    var readString = ''
    var numCharsRead = 0
    var startedWithOpenBracket = false
    var secondCharSlash = false
    var lastType = currentType
    var tagName = ''
    var tagState = ''
    var attrKeyName = ''
    var attrValName = ''
    ds_map_clear(attributeMap)
    
    while true {
        // advance in the document
        stringPos += 1
        
        // file detect end of line (and possibly end of document)
        if readMode == readMode_File and stringPos > string_length(xmlString) {
            file_text_readln(xmlFile)
            if file_text_eof(xmlFile) {
                currentType = DerpXmlType_EndOfFile
                currentValue = ''
                currentRawValue = ''
                return false
            }
            xmlString = file_text_read_string(xmlFile)
            stringPos = 1
        }
        
        // string detect end of document
        if readMode == readMode_String and stringPos > string_length(xmlString) {
            stringPos = string_length(xmlString)
            currentType = DerpXmlType_EndOfFile
            currentValue = ''
            currentRawValue = ''
            return false
        }
        
        // grab the new character
        var currentChar = string_char_at(xmlString, stringPos);
        readString += currentChar
        numCharsRead += 1
        
        // start of tags and slash check
        if numCharsRead == 1 and currentChar == '<' {
            startedWithOpenBracket = true
            tagState = 'tagname'
        }
        else if numCharsRead == 2 and startedWithOpenBracket and currentChar == '/' {
            secondCharSlash = true
        }
        // attributes in middle of tags
        else if numCharsRead >= 3 and startedWithOpenBracket and not secondCharSlash
        and not (currentChar == '>' and (tagState == 'whitespace' or tagState == 'tagname')) {
            if tagState == 'tagname' {
                if currentChar == ' ' {
                    tagState = 'whitespace'
                    tagName = string_copy(readString, 2, string_length(readString)-2)
                }
            }
            else if tagState == 'whitespace' {
                if currentChar != ' ' {
                    tagState = 'attrkey'
                    attrKeyName += currentChar
                }
            }
            else if tagState == 'attrkey' {
                if currentChar == '=' {
                    tagState = 'attrval'
                    stringPos += 1
                }
                else {
                    attrKeyName += currentChar
                }
            }
            else if tagState == 'attrval' {
                if currentChar == '"' {
                    tagState = 'whitespace'
                    attributeMap[? attrKeyName] = attrValName
                    attrKeyName = ''
                    attrValName = ''
                }
                else {
                    attrValName += currentChar
                }
            }
        }
        // end of tags
        else if currentChar == '>' {
            if not secondCharSlash {
                currentType = DerpXmlType_OpenTag
                if tagName == '' tagName = string_copy(readString, 2, string_length(readString)-2)
                currentValue = tagName
                currentRawValue = readString
                return true
            }
            else {
                currentType = DerpXmlType_CloseTag
                currentValue = string_copy(readString, 3, string_length(readString)-3)
                currentRawValue = readString
                return true
            }
        }
        // end of whitespace and text
        else if numCharsRead > 1 and currentChar == '<' {
            if string_char_at(xmlString, stringPos+1) == '/' and lastType == DerpXmlType_OpenTag {
                currentType = DerpXmlType_Text
            }
            else {
                currentType = DerpXmlType_Whitespace
            }
            stringPos -= 1
            currentValue = string_copy(readString, 1, string_length(readString)-1)
            currentRawValue = currentValue
            return true
        }
    }
}
