require 'LuaToXML'

local xml = XmlBuilder()

Person = Class()
function Person:__init__(name, age)
  self.Name = name
  self.Age  = age
  self.Children = {}
  
  xml.register(self, 'Person')
  xml.register(self.Children)
end

function Person:setParent(person)
  self.Parent = person
end

function Person:addChild(person)
  table.insert(self.Children, person)
end

local man = Person('Tom', 30)
man.setParent(Person('Toms Parent', 56))
man.addChild(Person('Lili', 2))
man.addChild(Person('Rose', 4))

man.Money = 23

print(xml.toString(man))
