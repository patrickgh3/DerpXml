/// DerpXmlRead_CurGetAttribute(keyString)
//
//  Returns the value of the attribute with the given key for the current node.
//  For example, in <a cat="bag">, the key is cat, and the returned value is bag.
//
//  If there is no attribute with that key, then
//  calling is_undefined() on the return value will return true.
//
//  keyString       The key to look for in the node's attributes.

/* Example usage:

var val = DerpXmlRead_CurGetAttribute('cat')
if not is_undefined(val) {
    show_debug_message(val)
}
else {
    show_debug_message('attribute doesn't exist :(')
}
*/

var keyString = argument0

return objDerpXmlRead.attributeMap[? keyString]
