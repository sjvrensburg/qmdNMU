-- beat.lua
-- Render `.beat` fenced divs as full-bleed narrative-beat slides for the
-- nmu-typst slide templates, calling the `#beat(...)` helper in
-- typst-template.typ.
--
--   ::: {.beat image="images/x.png"}
--   Statement text (Markdown, math, and inline formatting all work).
--   :::
--
-- becomes
--
--   #beat("images/x.png")[Statement text.]
--
-- Optional attributes: `side` ("left" | "right", default "left" — which side
-- the image sits on) and `image-width` (a Typst ratio like "60%", default the
-- helper's own 57%).

if not (FORMAT == "typst" or (FORMAT and FORMAT:match("typst"))) then
  return {}
end

function Div(el)
  if not el.classes:includes("beat") then
    return nil -- not a beat div: leave every other div untouched
  end

  local image = el.attributes["image"]
  if image == nil or image == "" then
    return nil -- no image supplied: nothing sensible to render, leave as-is
  end

  local args = { "\"" .. image .. "\"" }
  if el.attributes["side"] then
    table.insert(args, "side: \"" .. el.attributes["side"] .. "\"")
  end
  if el.attributes["image-width"] then
    table.insert(args, "image-width: " .. el.attributes["image-width"])
  end

  local out = pandoc.List()
  out:insert(pandoc.RawBlock("typst", "#beat(" .. table.concat(args, ", ") .. ")["))
  out:extend(el.content)
  out:insert(pandoc.RawBlock("typst", "]"))
  return out
end
