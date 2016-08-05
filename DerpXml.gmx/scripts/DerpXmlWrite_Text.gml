/// DerpXmlWrite_Text(value)
//
//  Writes text for the middle of an element.
//
//  value    The text

var value = argument0;

with objDerpXmlWrite {
    writeString += value
    lastWriteType = DerpXmlType_Text
    lastWriteEmptyElement = false
}
