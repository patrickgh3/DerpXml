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
                currentType = DerpXmlType_OpenTag
                currentValue = string_copy(readString, 2, string_length(readString)-2)
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
