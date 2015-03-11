# LuaToXML
Auto Convert Lua Table To Xml

额外依赖luaOO，自动把对象的属性，以及子元素转换为XML


对于属性

1 如果为可以转换为XML的对象，转换为名字与属性相同的XML子节点

2 如果不可以转换为XML的对象，转换为XML节点的属性，值为table.concat(field, ',')

3 其他的转换为XML节点的属性，值为toString(field)


对于列表

1 列表项为可以转换为XML的对象，转换为XML子节点，名字为注册时的值

2 其他项全部忽略


已知的BUG

1 没有做字符串转义，使用时候需要额外保证或者修改LuaToXml文件

2 如果对象没有任何属性，没有任何子对象会返回空串(为了空列表作为属性存在时省略掉)


