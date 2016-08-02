/// DerpXmlWrite_CloseTag(value)
//
//  Writes a close tag, e.g. </tagname>
//
//  value    The tag name

var value = argument0;

with objDerpXmlWrite {
    if lastWriteType == DerpXmlType_CloseTag {
        currentIndent -= 1
    }
    if lastWriteType != 'Text' {
        repeat currentIndent {
            writeString += indentString
        }
    }
    writeString += '</'+value+'>'
    writeString += newlineString
    lastWriteType = DerpXmlType_CloseTag
}
