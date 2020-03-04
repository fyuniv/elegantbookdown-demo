--[[
     A Pandoc 2 lua filter converting Pandoc native divs to LaTeX environments
     Author: Romain Lesur and Yihui Xie
     License: Public domain
--]]
local pandocList = require 'pandoc.List'

Div = function (div)
  local options = div.attributes['data-latex']
  if options == nil then return nil end

  -- if the output format is not latex, the object is left unchanged
  if FORMAT ~= 'latex' and FORMAT ~= 'beamer' then
    div.attributes['data-latex'] = nil
    return div
  end

  local env = div.classes[1]
  -- if the div has no class, the object is left unchanged
  if not env then return nil end

  -- build the returned list of blocks
  local beginEnv = pandocList:new{pandoc.RawBlock('tex', '\\begin' .. '{' .. env .. '}' .. options)}
  local endEnv = pandocList:new{pandoc.RawBlock('tex', '\\end{' .. env .. '}')}
  local returnedList = beginEnv .. div.content .. endEnv

  return returnedList
end

function Image (el)
    if el.classes:includes("center") then
    return {
      pandoc.RawInline('latex', '\\hfill\\break{\\centering'),
      el,
      pandoc.RawInline('latex', '\\par}')
    }
  end
end

-- ThmDiv = function (div)
--     if FORMAT:match 'html' then
--         local options = div.attributes['data-latex']
--         if options == nil then return nil end
--     -- if the output format is html, add a theorem title.
--         local env = div.classes[1]
--         -- if the div has no class, the object is left unchanged
--         if not env then return nil end

--         env = env:gsub("^%l", string.upper)
--         -- build the returned list of blocks
--         return pandoc.RawBlock('html', '<p><span><strong>' .. env .. options .. '</strong></span></p>')}
--   end
-- end
