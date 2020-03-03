-- https://github.com/jgm/pandoc/issues/2106#issuecomment-371355862

-- Convert html environment to latex environment using lua
-- More examples can be found at https://pandoc.org/lua-filters.html

function Span(el)
  if el.classes:includes("todo") then
    return {
      pandoc.RawInline("latex", "\\textcolor{red}{\\textbf{TODO: }"),
      el,
      pandoc.RawInline("latex", "}")
    }
  end
end

function Div(el)
  if el.classes:includes("rmdthink") then
    return {
      pandoc.RawBlock("latex", "\\begin{rmdthink}"),
      el,
      pandoc.RawBlock("latex", "\\end{rmdthink}")
    }
  end
  if el.classes:includes("rmdnote") then
    return {
      pandoc.RawBlock("latex", "\\begin{rmdnote}"),
      el,
      pandoc.RawBlock("latex", "\\end{rmdnote}")
    }
  end
  if el.classes:includes("rmdtip") then
    return {
      pandoc.RawBlock("latex", "\\begin{rmdtip}"),
      el,
      pandoc.RawBlock("latex", "\\end{rmdtip}")
    }
  end
  if el.classes:includes("twocols") then
    return {
      pandoc.RawBlock("latex", "\\begin{multicols}{2}"),
      el,
      pandoc.RawBlock("latex", "\\end{multicols}")
    }
  end
  if el.classes:includes("threecols") then
    return {
      pandoc.RawBlock("latex", "\\begin{multicols}{3}"),
      el,
      pandoc.RawBlock("latex", "\\end{multicols}")
    }
  end
  if el.classes:includes("fourcols") then
    return {
      pandoc.RawBlock("latex", "\\begin{multicols}{4}"),
      el,
      pandoc.RawBlock("latex", "\\end{multicols}")
    }
  end
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

-- Building images with TikZ from https://pandoc.org/lua-filters.html

local function tikz2image(src, filetype, outfile)
    local tmp = os.tmpname()
    local tmpdir = string.match(tmp, "^(.*[\\/])") or "."
    local f = io.open(tmp .. ".tex", 'w')
    f:write("\\documentclass{standalone}\n\\usepackage{xcolor}\n\\usepackage{tikz}\n\\usepackage{pgfplots}\n\\usepackage{pgfmath}\n\\usepackage{pgffor}\\usepackage{tkz-euclide}\n\\usepgfplotslibrary{fillbetween}\n\\usetikzlibrary{\ncalc,\nangles,\nquotes,\narrows.meta,\nmath,\nbackgrounds,\npgfplots.statistics,\nmatrix,\npatterns,\nshapes.geometric,\nspy,\nintersections,\ndecorations.markings,\ndecorations.pathmorphing,\ndecorations.pathreplacing,\ndecorations.shapes\n}\n\\pgfdeclarelayer{ft}\n\\pgfdeclarelayer{bg}\n\\pgfsetlayers{bg,main,ft}\n\\begin{document}\n\\nopagecolor\n")
    f:write(src)
    f:write("\n\\end{document}\n")
    f:close()
    os.execute("pdflatex -output-directory " .. tmpdir  .. " " .. tmp)
    if filetype == 'pdf' then
        os.rename(tmp .. ".pdf", outfile)
    else
        os.execute("pdf2svg " .. tmp .. ".pdf " .. outfile)
    end
    os.remove(tmp .. ".tex")
    os.remove(tmp .. ".pdf")
    os.remove(tmp .. ".log")
    os.remove(tmp .. ".aux")
end

extension_for = {
    html = 'svg',
    html4 = 'svg',
    html5 = 'svg',
    latex = 'pdf',
    beamer = 'pdf' }

local function file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function starts_with(start, str)
   return str:sub(1, #start) == start
end

function RawBlock(el)
    if starts_with("\\begin{tikzpicture}", el.text) then
        local filetype = extension_for[FORMAT] or "svg"
        local fname = pandoc.sha1(el.text) .. "." .. filetype
        if not file_exists(fname) then
            tikz2image(el.text, filetype, fname)
        end
        return pandoc.Para({pandoc.Image({}, fname)})
    else
       return el
    end
end
