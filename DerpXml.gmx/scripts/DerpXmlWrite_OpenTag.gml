/// DerpXmlWrite_OpenTag(value)
//
//  Writes an open tag, e.g. <tagname>
//
//  value    The tag name

var value = argument0;

with objDerpXmlWrite {
    if lastWriteType == DerpXmlType_OpenTag {
        writeString += newlineString
        currentIndent += 1
    }
    repeat currentIndent {
        writeString += indentString
    }
    writeString += '<'+value+'>'
    lastWriteType = DerpXmlType_OpenTag
    ds_stack_push(tagNameStack, value)
}
