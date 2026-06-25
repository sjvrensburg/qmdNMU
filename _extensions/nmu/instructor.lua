-- Instructor / student toggle for NMU templates.
--
-- Marks lecturer-only material with a native fenced div:
--
--     ::: {.instructor}
--     The proof / worked answer (Markdown, math, code cells all work).
--     :::
--
-- By default the content is REMOVED (the student-safe version). Set
-- `audience: lecturer` (or `instructor-version: true`) in the front matter — or
-- pass `-M audience:lecturer` on the command line — to reveal it, wrapped in a
-- branded "Instructor" box (`#nmu-instructor`, defined in _brand.typ).
--
-- Defaulting to hidden means you can never hand out answers by accident.

local function reveal_instructor(meta)
  local show = false
  if meta.audience ~= nil then
    local a = pandoc.utils.stringify(meta.audience):lower()
    show = (a == "lecturer" or a == "instructor")
  end
  if meta["instructor-version"] == true then
    show = true
  end
  return show
end

function Pandoc(doc)
  local show = reveal_instructor(doc.meta)
  local blocks = doc.blocks:walk({
    Div = function(el)
      if not el.classes:includes("instructor") then
        return nil
      end
      if not show then
        return {} -- student version: drop the material entirely
      end
      -- lecturer version: wrap the (already-rendered) content in a branded box
      local out = pandoc.List()
      out:insert(pandoc.RawBlock("typst", "#nmu-instructor["))
      out:extend(el.content)
      out:insert(pandoc.RawBlock("typst", "]"))
      return out
    end,
  })
  return pandoc.Pandoc(blocks, doc.meta)
end
