-- https://github.com/jgm/pandoc/issues/2106#issuecomment-371355862

-- Convert html environment to latex environment using lua
-- More examples can be found at https://pandoc.org/lua-filters.html



if raw.format == 'latex' then
function RawBlock(el)
    if starts_with("\\begin{todo}", el.text) then
        return {
            pandoc.RawInline("latex", "\\textcolor{red}{\\textbf{TODO: }"),
            el,
            pandoc.RawInline("latex", "}")
        }
    end
    if starts_with("\\begin{thm}", el.text) or starts_with("\\begin{rmdthm}", el.text) or starts_with("\\begin{rmdtheorem}", el.text) then
        return {
            pandoc.RawBlock("latex", table.concat({"\\begin{theorem}", "{", , "}", "{", , "}"})),
            el,
            pandoc.RawBlock("latex", "\\end{theorem}")
        }
    end

    if starts_with("\\begin{lem}", el.text) or starts_with("\\begin{rmdlem}", el.text) or starts_with("\\begin{rmdlemma}", el.text) then
    return {
        pandoc.RawBlock("latex", table.concat({"\\begin{lemma}", "{", , "}", "{", , "}" }) ),
        el,
        pandoc.RawBlock("latex", "\\end{lemma}")
    }
    end

    if starts_with("\\begin{cor}", el.text) or starts_with("\\begin{rmdcor}", el.text) or starts_with("\\begin{rmdcorollary}", el.text) then
    return {
        pandoc.RawBlock("latex", table.concat({"\\begin{corollary}", "{", , "}", "{", , "}" }) ),
        el,
        pandoc.RawBlock("latex", "\\end{corollary}")
    }
    end
    
    if starts_with("\\begin{prop}", el.text) or starts_with("\\begin{rmdprop}", el.text) or starts_with("\\begin{rmdproposition}", el.text) then
    return {
        pandoc.RawBlock("latex", table.concat({"\\begin{proposition}", "{", , "}", "{", , "}" }) ),
        el,
        pandoc.RawBlock("latex", "\\end{proposition}")
    }
    end

    if starts_with("\\begin{defn}", el.text) or starts_with("\\begin{rmddefn}", el.text) or starts_with("\\begin{rmddefinition}", el.text) then
    return {
        pandoc.RawBlock("latex", table.concat({"\\begin{definition}", "{", , "}", "{", , "}" })),
        el,
        pandoc.RawBlock("latex", "\\end{definition}")
    }
    end

    if starts_with("\\begin{exam}", el.text) or starts_with("\\begin{rmdexam}", el.text) or starts_with("\\begin{rmdexample}", el.text) then
    return {
        pandoc.RawBlock("latex", "\\begin{example}"),
        el,
        pandoc.RawBlock("latex", "\\end{example}")
    }
    end

    if starts_with("\\begin{exer}", el.text) or starts_with("\\begin{rmdexer}", el.text) or starts_with("\\begin{rmdexercise}", el.text) then
        return {
            pandoc.RawBlock("latex", "\\begin{exercise}"),
            el,
            pandoc.RawBlock("latex", "\\end{exercise}")
        }
    end

    if starts_with("\\begin{sol}", el.text) or starts_with("\\begin{rmdsol}", el.text) or starts_with("\\begin{rmdsolution}", el.text) then
    return {
        pandoc.RawBlock("latex", "\\begin{solution}"),
        el,
        pandoc.RawBlock("latex", "\\end{solution}")
    }
    end

    if starts_with("\\begin{twocols}", el.text) then
    return {
        pandoc.RawBlock("latex", "\\begin{multicols}{2}"),
        el,
        pandoc.RawBlock("latex", "\\end{multicols}")
    }
    end

    if starts_with("\\begin{threecols}", el.text) then
    return {
        pandoc.RawBlock("latex", "\\begin{multicols}{3}"),
        el,
        pandoc.RawBlock("latex", "\\end{multicols}")
    }
    end

    if starts_with("\\begin{fourcols}", el.text) then
    return {
        pandoc.RawBlock("latex", "\\begin{multicols}{4}"),
        el,
        pandoc.RawBlock("latex", "\\end{multicols}")
    }
    end
end


-- function Div(el)
    -- local chapnum=0
    -- local thmnum=0
    -- local thmname=""
    -- local thmlabel=""
    -- local thmid=""
    -- local text=""
    -- if el.attributes.name then
    --     thmname=el.attributes.name
    -- end
    -- if el.attributes.label then
    --     thmlabel=el.attributes.label
    -- end
    -- if el.classes:includes("section" and "level1") then
    --     chapnum = chapnum + 1
    -- end
--     if el.classes:includes("thm" or "rmdthm" or "rmdtheorem") then
--         -- thmnum = thmnum + 1
--         -- thmid=table.concat{"thm:",thmlable}
--         -- text = table.concat({"Theorem ",chapnum,".",thmnum, thmname})
--         return {
--             -- pandoc.Span(pandoc.Strong(text), {id=thmid}),
--             pandoc.Span("Theorem A"),
--             el
--         }
--     end
-- end

-- function Div(el)
--     local thmname=""
--     local thmlabel=""

--     if el.attributes.name then
--         thmname=el.attributes.name
--     end

--     if el.attributes.label then
--         thmlabel=el.attributes.label
--     end

--     if el.classes:includes("thm" or "rmdthm" or "rmdtheorem") then
--         return {
--             pandoc.RawBlock("latex", table.concat({"\\begin{theorem}", "{", , "}", "{", , "}"})),
--             el,
--             pandoc.RawBlock("latex", "\\end{theorem}")
--         }
--     end

--     if el.classes:includes("lem" or "rmdlem" or "rmdlemma") then
--     return {
--         pandoc.RawBlock("latex", table.concat({"\\begin{lemma}", "{", , "}", "{", , "}" }) ),
--         el,
--         pandoc.RawBlock("latex", "\\end{lemma}")
--     }
--     end

--     if el.classes:includes("cor" or "rmdcor" or "rmdcorollary") then
--     return {
--         pandoc.RawBlock("latex", table.concat({"\\begin{corollary}", "{", , "}", "{", , "}" }) ),
--         el,
--         pandoc.RawBlock("latex", "\\end{corollary}")
--     }
--     end
    
--     if el.classes:includes("prop" or "rmdprop" or "rmdproposition") then
--     return {
--         pandoc.RawBlock("latex", table.concat({"\\begin{proposition}", "{", , "}", "{", , "}" }) ),
--         el,
--         pandoc.RawBlock("latex", "\\end{proposition}")
--     }
--     end

--     if el.classes:includes("defn" or "rmddefn" or "rmddefinition") then
--     return {
--         pandoc.RawBlock("latex", table.concat({"\\begin{definition}", "{", , "}", "{", , "}" })),
--         el,
--         pandoc.RawBlock("latex", "\\end{definition}")
--     }
--     end

--     if el.classes:includes("exam" or "rmdexam" or "rmdexample") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{example}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{example}")
--     }
--     end

--     if el.classes:includes("exer" or "rmdexer" or "rmdexercise") then
--         return {
--             pandoc.RawBlock("latex", "\\begin{exercise}"),
--             el,
--             pandoc.RawBlock("latex", "\\end{exercise}")
--         }
--     end

--     if el.classes:includes("sol" or "rmdsol" or "rmdsolution") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{solution}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{solution}")
--     }
--     end

--     if el.classes:includes("rmdthink") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{rmdthink}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{rmdthink}")
--     }
--     end

--     if el.classes:includes("rmdnote") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{rmdnote}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{rmdnote}")
--     }
--     end

--     if el.classes:includes("rmdtip") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{rmdtip}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{rmdtip}")
--     }
--     end

--     if el.classes:includes("twocols") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{multicols}{2}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{multicols}")
--     }
--     end

--     if el.classes:includes("threecols") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{multicols}{3}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{multicols}")
--     }
--     end

--     if el.classes:includes("fourcols") then
--     return {
--         pandoc.RawBlock("latex", "\\begin{multicols}{4}"),
--         el,
--         pandoc.RawBlock("latex", "\\end{multicols}")
--     }
--     end
-- end

-- function Image (el)
--     if el.classes:includes("center") then
--     return {
--         pandoc.RawInline('latex', '\\hfill\\break{\\centering'),
--         el,
--         pandoc.RawInline('latex', '\\par}')
--     }
--     end
-- end

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
