module Badges
using JSON3

global const  gFontFamily = "font-family='Verdana,Geneva,DejaVu Sans,sans-serif'"

function roundUpToOdd(x) 
    x = round(Int, x)
    iseven(x) ? x+1 : x
end

function preferredWidthOf(str) 
    return roundUpToOdd(div(widthOf(str), 10)) 
end

function computeWidths( label, message )
    return (
        preferredWidthOf(label),
        preferredWidthOf(message)
    )
end

function renderLogo(
    logo,
    badgeHeight,
    horizPadding,
    logoWidth = 14,
    logoPadding = 0
    ) 
    if isempty(logo) 
      return (
        false,
        0,
        "",
      )
    end
    logoHeight = 14
    y = (badgeHeight - logoHeight) ÷ 2
    x = horizPadding
    return (
      true,
      logoWidth + logoPadding,
      "<image x='$x' y='$y' width='$logoWidth' height='14' xlink:href='$(escapeXml(logo))'/>"
    )
end

function renderText(
    content,
    leftMargin,
    horizPadding = 0,
    verticalMargin = 0,
    shadow = true ) 
    if (isempty(content))
      return (renderedText="", width=0 )
    end
  
    textLength =  preferredWidthOf(content)
    escapedContent = escapeXml(content)
  
    shadowMargin = 150 + verticalMargin
    textMargin = 140 + verticalMargin
  
    outTextLength = 10 * textLength
    x = 10 * (leftMargin + textLength ÷ 2 + horizPadding)
  
    renderedText = ""
    if (shadow) 
      renderedText = "<text x='$x' y='$shadowMargin' fill='#010101' fill-opacity='.3' transform='scale(.1)' textLength='$outTextLength'>$escapedContent</text>"
    end
    renderedText = renderedText * "<text x='$x' y='$textMargin' transform='scale(.1)' textLength='$outTextLength'>$escapedContent</text>"
    return (
      renderedText,
      textLength,
    )
end

function renderLinks(
    leftLink,
    rightLink,
    leftWidth,
    rightWidth,
    height
  ) 
    
    leftLink = escapeXml(leftLink)
    rightLink = escapeXml(rightLink)
    hasLeftLink = !isempty(leftLink)
    hasRightLink = !isempty(rightLink) 
    leftLinkWidth = hasRightLink ? leftWidth : leftWidth + rightWidth
  
    function render( link, width ) 
      return "<a target='_blank' xlink:href='$link'><rect width='$width' height='$height' fill='rgba(0,0,0,0)'/></a>"
    end
  
    return (
      (hasRightLink ? render( rightLink, leftWidth + rightWidth) : "") *
      (hasLeftLink ? render( leftLink, leftLinkWidth) : "")
    )
end

function renderBadge(main, leftLink, rightLink, leftWidth, rightWidth, height ) 
    width = leftWidth + rightWidth
    return "<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='$width' height='$height'>
      $main
      $(renderLinks(leftLink, rightLink, leftWidth, rightWidth, height ))
      </svg>"
end

function render(this) 
    return stripXmlWhitespace(renderBadge(
      "<linearGradient id='s' x2='0' y2='100%'>
        <stop offset='0' stop-color='#bbb' stop-opacity='.1'/>
        <stop offset='1' stop-opacity='.1'/>
      </linearGradient>
      <clipPath id='r'>
        <rect width='$(this.width)' height='$(this.height)' rx='3' fill='#fff'/>
      </clipPath>
      <g clip-path='url(#r)'>
        <rect width='$(this.leftWidth)' height='$(this.height)' fill='$(this.labelColor)'/>
        <rect x='$(this.leftWidth)' width='$(this.rightWidth)' height='$(this.height)' fill='$(this.color)'/>
        <rect width='$(this.width)' height='$(this.height)' fill='url(#s)'/>
      </g>
      <g fill='#fff' text-anchor='middle' $(this.fontFamily) text-rendering='geometricPrecision' font-size='110'>
        $(this.renderedLogo)
        $(this.renderedLabel)
        $(this.renderedMessage)
      </g>",
      this.leftLink,
      this.rightLink,
      this.leftWidth,
      this.rightWidth,
      this.height,
    ))
end

function Badge(; 
    label="",
    message,
    leftLink="",
    rightLink="",
    logo="",
    logoWidth=0,
    logoPadding=0,
    color = "#4c1",
    labelColor = "#555",
    fontFamily = gFontFamily,
    height = 20,
    verticalMargin=0,
    shadow=true)

    horizPadding = 5

    hasLogo, totalLogoWidth, renderedLogo  = renderLogo(
        logo,
        height,
        horizPadding,
        logoWidth,
        logoPadding,
    )

    hasLabel = !isempty(label)
    labelColor = hasLabel || hasLogo ? labelColor : color
    labelColor = escapeXml(labelColor)
    color = escapeXml(color)
    labelMargin = totalLogoWidth + 1

    renderedLabel, labelWidth = renderText(
        label,
        labelMargin,
        horizPadding,
        verticalMargin,
        shadow
    )

    leftWidth = hasLabel ? labelWidth + 2 * horizPadding + totalLogoWidth : 0

    messageMargin = leftWidth - (!isempty(message) ? 1 : 0)

    if (!hasLabel) 
        if (hasLogo) 
        messageMargin = messageMargin + totalLogoWidth + horizPadding
        else 
        messageMargin = messageMargin + 1
        end
    end

    renderedMessage, messageWidth  = renderText(
        message,
        messageMargin,
        horizPadding,
        verticalMargin,
        shadow
    )

    rightWidth = messageWidth + 2 * horizPadding

    if (hasLogo && !hasLabel) 
        rightWidth += totalLogoWidth + horizPadding - 1
    end
    width = leftWidth + rightWidth


    return (    
        leftLink = leftLink,
        rightLink = rightLink, 
        leftWidth = leftWidth,
        rightWidth = rightWidth,
        width = width,
        labelColor = labelColor,
        color = color,
        renderedLogo = renderedLogo,
        renderedLabel = renderedLabel,
        renderedMessage = renderedMessage,
        height = height,
        fontFamily = fontFamily
        )

end


function stripXmlWhitespace(xml) 
    xml = replace(xml, r">\s+" => '>')
    xml = replace(xml, r"<\s+" => '<')
    return strip(xml)
end


function escapeXml(s)   
    s |>
    x -> replace(x, '&' => "&amp;")   |>
    x -> replace(x, '<' => "&gt;")    |> 
    x -> replace(x, '>' => "&lt;")    |> 
    x -> replace(x, '\"' => "&quot;") |> 
    x -> replace(x, '\'' => "&apos;") 
end

# Verdana font metrics precalculated from the npm package anafanafo
global const data = Ref{Any}()
global const em = Ref{Float64}()

"""
    `widthOfCharCode(charCode; approx=true)`

Width of one character in Verdana 110 pts. 
If `approx` is true, any unknwon character will be measured as 'm'. Otherwise 0.0
"""
function widthOfCharCode(charCode; approx=true)
    if isControlChar(charCode); return 0.0; end
    res = findfirst(data[]) do x
        charCode >= x[1] && charCode <= x[2]
    end
    if isnothing(res)
        if approx; return em[]; else return 0.0; end
    else 
        return data[][res][3]
    end
end

"""
Width of a String, displayed in Verdana 110 pts
"""
widthOf(text::AbstractString; approx=true) = reduce(+, [widthOfCharCode(Int(x), approx=approx) for x in text])

isControlChar(charCode) = charCode <=31 || charCode == 127


function __init__()
    data[] = JSON3.read(read("src/widths.json", String))
    em[] = widthOfCharCode(Int('m'))
end

end
