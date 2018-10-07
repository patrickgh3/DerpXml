/// @description  DerpXmlRead_CurCloneAttribute()
//
//  Clone and return a ds_map of the current xml node attribute
//  Return undefined when the number of attribute is zore
var source = objDerpXmlRead.attributeMap
if ds_map_size(source) == 0 return undefined	

var clone = ds_map_create()
ds_map_copy(clone, source)
return clone