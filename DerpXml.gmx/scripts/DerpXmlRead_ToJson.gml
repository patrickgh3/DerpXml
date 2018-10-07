/// @description DerpXmlRead_ToJson(xmlFilePath)
/// @param xmlFilePath
//
//  Parser an XML file and return ds_map. it has the following behavior
//	"node" value will be stored as "name" filed
//	"node" attribute will be stored as "attr" field if exists
//  "node" level relationship will be stored as "child" field if exists
//
//  Example:
/*
{
    "child": [
        {
            "child": [
                {
                    "name": "a"
                },
                {
                    "name": "b"
                },
                {
                    "name": "c"
                },
                {
                    "attr": {
                        "cat": "bag"
                    },
                    "name": "d"
                },
                {
                    "attr": {
                        "cat": "bag",
                        "cat2": "bag2"
                    },
                    "name": "e"
                }
            ],
            "name": "root"
        }
    ],
    "name": "root"
	}
}
*/


DerpXml_Init()
DerpXmlRead_OpenFile(argument0)

var root = ds_map_create();
	root[? "name"] = "root"
ds_map_add_list(root, "child", ds_list_create())

var mapStack = ds_stack_create();
ds_stack_push(mapStack, root)

while DerpXmlRead_Read()
{
	var tagType = DerpXmlRead_CurType();
	switch tagType
	{
		case DerpXmlType_OpenTag:
			var curMap = ds_map_create();
			
			// node name
			curMap[? "name"] = DerpXmlRead_CurValue()
			
			// node attribute
			var attr = DerpXmlRead_CurCloneAttribute();
			if !is_undefined(attr)
				ds_map_add_map(curMap, "attr", attr)
			
			// node child-list
			var parent = ds_stack_top(mapStack);
			var parentChildList = parent[? "child"];
			
			// create parent's child-list
			if is_undefined(parentChildList)	{
				parentChildList = ds_list_create()
				ds_map_add_list( parent, "child", parentChildList)		
			}
			// add curMap to parent's child-list
			ds_list_add(parentChildList, curMap); 
			ds_list_mark_as_map(parentChildList, ds_list_size(parentChildList)-1)
				
			// push stack
			ds_stack_push(mapStack, curMap)
			 
		break
		
		case DerpXmlType_CloseTag:
			// pop stack
			ds_stack_pop(mapStack)
		break
	}
}

DerpXmlRead_CloseFile()

return root
