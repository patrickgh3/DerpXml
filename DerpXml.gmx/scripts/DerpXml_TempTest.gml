DerpXmlSax_Init(false)

DerpXmlSax_LoadFromString('<a><b>derp</b>  </a>')

show_debug_message(DerpXmlSax_CurType()+', '+DerpXmlSax_CurValue())
while DerpXmlSax_Read() {
    show_debug_message(DerpXmlSax_CurType()+', '+DerpXmlSax_CurValue())
}
show_debug_message(DerpXmlSax_CurType()+', '+DerpXmlSax_CurValue())
