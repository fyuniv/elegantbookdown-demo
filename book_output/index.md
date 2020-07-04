--- 
title: "A Demo of Elegantbook Bookdown"
author: "Fei Ye"
date: "2020-07-04"
description: This project demonstrates how to make the [Elegantbookdown](https://github.com/XiangyunHuang/ElegantBookdown) template created by [Xiangyun Huang](https://github.com/XiangyunHuang) work for theorem environments.
documentclass: elegantbook
github-repo: fyemath/elegantbookdown-demo
logo: ''
cover: figs/Spring.jpg
site: bookdown::bookdown_site
classoption: en,11pt
version: '0.90'
---






\mainmatter

\hypersetup{pageanchor=true}

\renewcommand{\baselinestretch}{1.05}\normalsize

\captionsetup[figure]{labelformat=empty}
\captionsetup[subfigure]{labelformat=empty}

# Introduction {-}

ElegantLaTeX Program developers are intended to provide you beautiful, elegant, user-friendly templates. Currently, the ElegantLaTeX is composed of ElegantNote, ElegantBook, ElegantPaper, designed for typesetting notes, books, and working papers respectively. Latest releases are strongly recommended! This guide is aimed at briefly introducing the 101 of this template. For any other question, suggestion or comment, feel free to contact us on GitHub issue or email us.

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).

![by-nc-sa license icon](figs/by-nc-sa.png)

<!--chapter:end:index.Rmd-->

# Some Explanations

The way to make the Bookdown generated TeX files works of the elegantbook class is to use `bookdown.post.latex` option to modify the generated tex file. Due the natural of the fancy definition of theorem environments in elegantbook, the current hack to unnamed theorem environments is to add `{}{}` to the end to `\BeginKnitrBlock{}` . For named theorem environments, the brackets `[` and `]` will be substibuted by braces `{` and `}`. In addition, an empty pair of braces `{}` will be added to the end of `\BeginKnitrBlock{}...`. In elegantbook, the last pair of brackets stores the label of the theorem envirionment which seems unnecessary  for bookdown.

An alternative approach define theorem environments is to use pandoc fence blocks and lua to translate them into tex environments. This is the way how "Think", "Note", and "Tip" environments were defined in this demo.

**In the following Chapter, you will see a demo of how theorem environments work with elegantbook class.**  If you have any suggestions/comments, please submit them to this repo. Thank you!

<!--chapter:end:00-Some-Explanations.Rmd-->

# Examples

## Don't Be Tricked

::: {.rmdthink}

1. A pizza shop sales 12-inches pizza and 8-inches pizza at the price \$12/each and \$6/each respectively.  With \$12, would you like to order one 12-inches and two 8-inches. Why?

2. A sheet of everyday copy paper is about 0.01 millimeter thick. Repeat folding along a different side 20 times. Now, how thick do you think the folded paper is?

:::

## Properties of Exponents

For an integer $n$, and an expression $x$, the mathematical operation of the $n$-times repeated multiplication of $x$  is call exponentiation, written as $x^n$, that is,
$$
x^n=\underbrace{x\cdot x \cdots x}_{n~\text{factors of}~x}.
$$

In the notation $x^n$, $n$ is called ***the exponent***, $x$ is called ***the base***, and $x^n$ is called ***the power***, read as "$x$ raised to the $n$-th power",  "$x$ to the $n$-th power", "$x$ to the $n$-th", "$x$ to the power of $n$" or "$x$ to the $n$".

::: {.rmdnote}

**Order of Basic Mathematical Operations**  

In mathematics, the order of operations reflects conventions about which procedure should be performed first. There are four levels (from the highest to the lowest):

**Parenthesis**; **Exponentiation**; **Multiplication and Division**; **Addition and Subtraction**.  

Within the same level, the convention is to perform from the left to the right.

:::

:::{.exam}

Simplify. **Write with positive exponents.**
$$
\left(\dfrac{2y^{-2}z^{-5}}{4x^{-3}y^6}\right)^{-4}.
$$

:::

:::{.sol}

The idea is to simplify the base first and rewrite using positive exponents only.

$$
\begin{aligned}
    \left(\dfrac{2y^{-2}z^{-5}}{4x^{-3}y^6}\right)^{-4}
=&\left(\dfrac{x^3}{2z^{5}y^8}\right)^{-4}\\
=&\left(\dfrac{2z^{5}y^8}{x^3}\right)^4\\
=&\dfrac{2^4(z^{5})^4(y^8)^4}{(x^3)^4}\\
=&\dfrac{16y^{32}z^{20}}{x^{12}}.\\
\end{aligned}
$$

:::

::: {.rmdtip}

**Simplify (at least partially) the problem first**  
To avoid mistakes when working with negative exponents, it's better to apply the negative exponent rule to change negative exponents to positive exponents and simplify the base first.

:::

\newpage

## Generating Theorem Environments Using R Bookdown Code Chunks

Bookdown theorem environments work great. It will be awesome if it can handle r code chunks within a theorem block.

\BeginKnitrBlock{theorem}\iffalse{-91-80-121-116-104-97-103-111-114-101-97-110-32-84-104-101-111-114-101-109-93-}\fi{}<div class="theorem"><span class="theorem" id="thm:ggThm"><strong>(\#thm:ggThm)  \iffalse (Pythagorean Theorem) \fi{} </strong></span>
If $c$ denotes the length of the hypotenuse and $a$ and $b$ denote the lengths of the other two sides, the Pythagorean theorem can be expressed as the Pythagorean equation:
$$a^2+b^2=c^2.$$
</div>\EndKnitrBlock{theorem}

\BeginKnitrBlock{corollary}<div class="corollary"><span class="corollary" id="cor:unnamed-chunk-1"><strong>(\#cor:unnamed-chunk-1) </strong></span>
For any angle $\theta$, we have
$$
\sin^2\theta+\cos^2\theta=1
$$
</div>\EndKnitrBlock{corollary}

\newpage

## Generating Theorem Environments Using Pandoc Fence Code Blocks

Bookdown has a lua filter called "latex-div.lua" which handles theorem environments for latex.

::: {.thm title="Pythagorean Theorem" label="pyThm"}

If $c$ denotes the length of the hypotenuse and $a$
 and $b$ denote the lengths of the other two sides,
 the Pythagorean theorem can be expressed as the Pythagorean equation:
$$a^2+b^2=c^2.$$

:::

::: {.cor}

For any angle $\theta$, we have
$$
\sin^2\theta+\cos^2\theta=1
$$

:::

::: {.lem}

Pandoc use `::: {#Id .Div_attributes}` to start and `:::`
 to end a Div block. Such a block can be converted
  to LaTeX environment using lua.

:::

::: {.exam}
Find the hypotenuose for the right triangle whose legs are 4 and 3.
:::

:::{.sol}
By \@ref(thm:pyThm) or \@ref(thm:ggThm), the hypothenuose is
$$
\sqrt{3^2+4^2}=5.
$$
:::

[Exponential functions](http://passyworldofmathematics.com/exponents-in-the-real-world/)


\newpage

## Practice

:::{.exer}

Simplify. **Write with positive exponents.**

1. $(3a^2b^3c^2)(4abc^2)(2b^2c^3)$
2. $\dfrac{4y^3z^0}{x^2y^2}$
3. $(-2)^{-3}$

:::

:::{.exer}

Simplify. **Write with positive exponents.**

1. $\dfrac{-u^0v^{15}}{v^{16}}$
1. $(-2a^3b^2c^0)^3$
1. $\dfrac{m^5 n^{2}}{(mn)^3}$

:::

:::{.exer}

Simplify. **Write with positive exponents.**

1. $(-3a^2x^3)^{-2}$
1. $\left(\dfrac{-x^0y^3}{2wz^2}\right)^3$
1. $\dfrac{3^{-2}a^{-3}b^5}{x^{-3}y^{-4}}$

:::

:::{.exer}

Simplify. **Write with positive exponents.**

1. $\left(-x^{-1}(-y)^2\right)^3$
2. $\left(\dfrac{6x^{-2}y^5}{2y^{-3}z^{-11}}\right)^{-3}$
3. $\dfrac{(3 x^{2} y^{-1})^{-3}(2 x^{-3} y^{2})^{-1}}{(x^{6} y^{-5})^{-2}}$

:::

:::{.exer}

A store has large size and small size watermelons. A large one cost \$4 and a small one \$1. Putting on the same table, a smaller watermelons has only half the height of the larger one. Given \$4, will you buy a large watermelon or 4 smaller ones? Why?

:::

<!--chapter:end:01-integer-exponents.Rmd-->

# Another Chapter

## Generating Theorem Environments Using Pandoc Fence Code Blocks

Bookdown has a lua filter called "latex-div.lua" which handles theorem environments for latex.

::: {.thm title="Pythagorean Theorem"}

If $c$ denotes the length of the hypotenuse and $a$
 and $b$ denote the lengths of the other two sides,
 the Pythagorean theorem can be expressed as the Pythagorean equation:
$$a^2+b^2=c^2.$$

:::

::: {.rmdtheorem}

If $c$ denotes the length of the hypotenuse and $a$
 and $b$ denote the lengths of the other two sides,
 the Pythagorean theorem can be expressed as the Pythagorean equation:
$$a^2+b^2=c^2.$$

:::

::: {.rmdthm}

If $c$ denotes the length of the hypotenuse and $a$
 and $b$ denote the lengths of the other two sides,
 the Pythagorean theorem can be expressed as the Pythagorean equation:
$$a^2+b^2=c^2.$$

:::

::: {.cor}

For any angle $\theta$, we have
$$
\sin^2\theta+\cos^2\theta=1
$$

:::

::: {.rmdcor title="Corollary A"}

For any angle $\theta$, we have
$$
\sin^2\theta+\cos^2\theta=1
$$

:::

::: {.rmdcor label="corB"}

For any angle $\theta$, we have
$$
\sin^2\theta+\cos^2\theta=1
$$

:::

By \@ref(cor:corB), we know that .... \@ref(thm:pyThm)

::: {.lem}

Pandoc use `::: {#Id .Div_attributes}` to start and `:::`
 to end a Div block. Such a block can be converted
  to LaTeX environment using lua.

:::

::: {.rmdprop}

Let $f$ be a function differentiable over $(a, b)$. If $f'(x)>0$ for any $x$ in $(a, b)$, then $f(a)<f(x)<f(b)$$ for any $x$ in $(a,b)$.

:::

::: {.exam}
Find the hypotenuose for the right triangle whose legs are 4 and 3.
:::

:::{.sol}
By \@ref(thm:pyThm), the hypothenuose is
$$
\sqrt{3^2+4^2}=5.
$$
:::

\newpage

## Practice

:::{.exer}

Simplify. **Write with positive exponents.**

1. $(3a^2b^3c^2)(4abc^2)(2b^2c^3)$
2. $\dfrac{4y^3z^0}{x^2y^2}$
3. $(-2)^{-3}$

:::

<!--chapter:end:02-anotherSection.Rmd-->

