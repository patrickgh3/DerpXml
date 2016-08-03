show_debug_message(DerpXmlRead_CurType()+', '+DerpXmlRead_CurValue())
while DerpXmlRead_Read() {
    show_debug_message(DerpXmlRead_CurType()+', '+DerpXmlRead_CurValue())
    if DerpXmlRead_CurType() == DerpXmlType_OpenTag {
        var val = DerpXmlRead_CurGetAttribute('cat2')
        if not is_undefined(val) {
            show_debug_message('val: '+val)
        }
        else {
            show_debug_message('val: undefined')
        }
    }
}
show_debug_message(DerpXmlRead_CurType()+', '+DerpXmlRead_CurValue())
