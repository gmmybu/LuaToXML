require 'luaOO'

local StringBuilder = Class()
function StringBuilder:appendString(text)
  if #text > 0 then
    table.insert(self, text)
  end
end

function StringBuilder:toString(sep)
  return table.concat(self, sep)
end
--------------------------------------------------------------------
XmlBuilder = Class()
function XmlBuilder:__init__()
  self.registries = {}
  setmetatable(self.registries, {__mode='k'})
end

function XmlBuilder:register(obj, name)
  if type(obj) == 'table' then
    name = name or 'Null'
    self.registries[obj] = name
  end
end

function XmlBuilder:serialize(obj, name, space)
  local head = StringBuilder()
  local body = StringBuilder()
  local flag = true    --检测是否为空

  head.appendString(space..'<'..name)
  for k, v in pairs(obj) do
    if type(k) == 'string' then
      if type(v) == 'table' then
        flag = false
        if self.registries[v] then
          body.appendString(self.serialize(v, k, space..'  '))
        else
          head.appendString(' '..k..'="'..table.concat(v, ',')..'"')
        end
      elseif type(v) ~= 'function' then
        flag = false
        head.appendString(' '..k..'="'..tostring(v)..'"')
      end
    end
  end
  
  for _, v in ipairs(obj) do
    if type(v) == 'table' and self.registries[v] then
      flag = false
      body.appendString(self.serialize(v, self.registries[v], space..'  '))
    end
  end
  
  if flag then return '' end
  
  if #body == 0 then
    head.appendString('/>\n')
    return head.toString()
  else
    head.appendString('>\n')
    body.appendString(space..'</'..name..'>\n')
    return head.toString()..body.toString()
  end
end

function XmlBuilder:toString(obj)
  return self.registries[obj] and self.serialize(obj, self.registries[obj], '')
end
