var xmlstr = '<a><b>derp</b>  </a>'

repeat 2 show_debug_message('')
DerpXmlRead_LoadString(xmlstr)
DerpXmlTests_ReadAndPrint()


repeat 2 show_debug_message('')
var f = file_text_open_write('test1.xml')
file_text_write_string(f, xmlstr)
file_text_close(f)
DerpXmlRead_OpenFile('test1.xml')
DerpXmlTests_ReadAndPrint()
DerpXmlRead_CloseFile()

repeat 2 show_debug_message('')
