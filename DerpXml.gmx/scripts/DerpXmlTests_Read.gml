var xmlstr = '<a cat="bag" cat2="bag"    ><c cat="bag" /><b>derp</b>  </a>'
var f = file_text_open_write('test1.xml')
file_text_write_string(f, xmlstr)
file_text_close(f)


show_debug_message('')
DerpXmlRead_LoadString(xmlstr)
DerpXmlTests_ReadAndPrint()

show_debug_message('')
DerpXmlRead_OpenFile('test1.xml')
DerpXmlTests_ReadAndPrint()
DerpXmlRead_CloseFile()
