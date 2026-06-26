-- columns.lua
-- Render Pandoc fenced-div columns as a Typst grid for the nmu-typst templates.
--
-- Pandoc's column divs are otherwise ignored by Typst output and collapse into a
-- single vertical stack. This filter maps them onto a native `#grid(...)` so the
-- columns appear side by side, while each column's content is still rendered
-- natively (Markdown, math, lists, and executable code cells all preserved).
--
--   :::: {.columns}
--   ::: {.column width="60%"}
--   left content
--   :::
--   ::: {.column width="40%"}
--   right content
--   :::
--   ::::
--
-- becomes
--
--   #grid(columns: (60%, 40%), column-gutter: ..., align: top, [left], [right])
--
-- Column `width` accepts any Typst length/ratio ("60%", "0.6fr", "4cm"); a
-- column with no width defaults to an equal `1fr` share. The grid gutter can be
-- tuned per document with `column-gutter:` in the front matter (default 1.2em).

-- Only act on Typst output; leave HTML/other writers to their native handling.
if not (FORMAT == "typst" or (FORMAT and FORMAT:match("typst"))) then
  return {}
end

local GUTTER = "1.2em"

-- Pick up an optional front-matter override for the gutter.
function Meta(meta)
  if meta["column-gutter"] ~= nil then
    GUTTER = pandoc.utils.stringify(meta["column-gutter"])
  end
  return nil
end

local function is_column(blk)
  return blk.t == "Div" and blk.classes:includes("column")
end

local function column_width(blk)
  local w = blk.attributes["width"]
  if w == nil or w == "" then return "1fr" end
  return w
end

function Div(el)
  if not el.classes:includes("columns") then
    return nil -- not a columns wrapper: leave every other div untouched
  end

  local widths = {}
  local cells = pandoc.List()
  for _, blk in ipairs(el.content) do
    if is_column(blk) then
      table.insert(widths, column_width(blk))
      cells:insert(blk)
    end
  end

  if #widths == 0 then
    return nil -- nothing column-like inside; render as a normal div
  end

  local out = pandoc.List()
  out:insert(pandoc.RawBlock("typst",
    "#grid(\n  columns: (" .. table.concat(widths, ", ") .. "),\n" ..
    "  column-gutter: " .. GUTTER .. ",\n  align: top,\n"))
  for _, col in ipairs(cells) do
    out:insert(pandoc.RawBlock("typst", "  ["))
    out:extend(col.content)
    out:insert(pandoc.RawBlock("typst", "  ],\n"))
  end
  out:insert(pandoc.RawBlock("typst", ")\n"))
  return out
end
