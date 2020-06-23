using Badges
using Test

@testset "Badges" begin
    shields_build_passing="<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='88' height='20'><linearGradient id='s' x2='0' y2='100%'><stop offset='0' stop-color='#bbb' stop-opacity='.1'/><stop offset='1' stop-opacity='.1'/></linearGradient><clipPath id='r'><rect width='88' height='20' rx='3' fill='#fff'/></clipPath><g clip-path='url(#r)'><rect width='37' height='20' fill='#555'/><rect x='37' width='51' height='20' fill='#4c1'/><rect width='88' height='20' fill='url(#s)'/></g><g fill='#fff' text-anchor='middle' font-family='Verdana,Geneva,DejaVu Sans,sans-serif' text-rendering='geometricPrecision' font-size='110'><text x='195' y='150' fill='#010101' fill-opacity='.3' transform='scale(.1)' textLength='270'>build</text><text x='195' y='140' transform='scale(.1)' textLength='270'>build</text><text x='615' y='150' fill='#010101' fill-opacity='.3' transform='scale(.1)' textLength='410'>passing</text><text x='615' y='140' transform='scale(.1)' textLength='410'>passing</text></g></svg>"
    b = Badges.Badge(label="build", message="passing");
    my_build_passing = Badges.render(b)
    @test my_build_passing == shields_build_passing
end


@testset "Badges with Logo" begin
    shields_appveyor="<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='81' height='20'><linearGradient id='s' x2='0' y2='100%'><stop offset='0' stop-color='#bbb' stop-opacity='.1'/><stop offset='1' stop-opacity='.1'/></linearGradient><clipPath id='r'><rect width='81' height='20' rx='3' fill='#fff'/></clipPath><g clip-path='url(#r)'><rect width='54' height='20' fill='#555'/><rect x='54' width='27' height='20' fill='#97ca00'/><rect width='81' height='20' fill='url(#s)'/></g><g fill='#fff' text-anchor='middle' font-family='Verdana,Geneva,DejaVu Sans,sans-serif' text-rendering='geometricPrecision' font-size='110'><image x='5' y='3' width='14' height='14' xlink:href='data:image/svg+xml;base64,PHN2ZyBmaWxsPSIjMDBCM0UwIiByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QXBwVmV5b3IgaWNvbjwvdGl0bGU+PHBhdGggZD0iTSAxMiwwIEMgMTguNiwwIDI0LDUuNCAyNCwxMiAyNCwxOC42IDE4LjYsMjQgMTIsMjQgNS40LDI0IDAsMTguNiAwLDEyIDAsNS40IDUuNCwwIDEyLDAgWiBtIDIuOTQsMTQuMzQgQyAxNi4yNiwxMi42NiAxNi4wOCwxMC4yNiAxNC40LDkgMTIuNzgsNy43NCAxMC4zOCw4LjA0IDksOS43MiA3LjY4LDExLjQgNy44NiwxMy44IDkuNTQsMTUuMDYgYyAxLjY4LDEuMjYgNC4wOCwwLjk2IDUuNCwtMC43MiB6IG0gLTYuNDIsNy44IGMgMC43MiwwLjMgMi4yOCwwLjYgMy4wNiwwLjYgbCA1LjIyLC03LjU2IGMgMS42OCwtMi41MiAxLjI2LC01Ljk0IC0xLjA4LC03LjggLTIuMSwtMS42OCAtNS4wNCwtMS42MiAtNy4xNCwwIGwgLTcuMjYsNS41OCBjIDAuMTgsMS45MiAwLjcyLDIuODggMC43MiwyLjk0IGwgNC4xNCwtNC41IGMgLTAuMywxLjk4IDAuNDIsNC4wMiAyLjEsNS4yOCAxLjQ0LDEuMTQgMy4xOCwxLjQ0IDQuODYsMS4wOCB6Ii8+PC9zdmc+'/><text x='365' y='150' fill='#010101' fill-opacity='.3' transform='scale(.1)' textLength='270'>style</text><text x='365' y='140' transform='scale(.1)' textLength='270'>style</text><text x='665' y='150' fill='#010101' fill-opacity='.3' transform='scale(.1)' textLength='170'>flat</text><text x='665' y='140' transform='scale(.1)' textLength='170'>flat</text></g></svg>"
    logo = "data:image/svg+xml;base64,PHN2ZyBmaWxsPSIjMDBCM0UwIiByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+QXBwVmV5b3IgaWNvbjwvdGl0bGU+PHBhdGggZD0iTSAxMiwwIEMgMTguNiwwIDI0LDUuNCAyNCwxMiAyNCwxOC42IDE4LjYsMjQgMTIsMjQgNS40LDI0IDAsMTguNiAwLDEyIDAsNS40IDUuNCwwIDEyLDAgWiBtIDIuOTQsMTQuMzQgQyAxNi4yNiwxMi42NiAxNi4wOCwxMC4yNiAxNC40LDkgMTIuNzgsNy43NCAxMC4zOCw4LjA0IDksOS43MiA3LjY4LDExLjQgNy44NiwxMy44IDkuNTQsMTUuMDYgYyAxLjY4LDEuMjYgNC4wOCwwLjk2IDUuNCwtMC43MiB6IG0gLTYuNDIsNy44IGMgMC43MiwwLjMgMi4yOCwwLjYgMy4wNiwwLjYgbCA1LjIyLC03LjU2IGMgMS42OCwtMi41MiAxLjI2LC01Ljk0IC0xLjA4LC03LjggLTIuMSwtMS42OCAtNS4wNCwtMS42MiAtNy4xNCwwIGwgLTcuMjYsNS41OCBjIDAuMTgsMS45MiAwLjcyLDIuODggMC43MiwyLjk0IGwgNC4xNCwtNC41IGMgLTAuMywxLjk4IDAuNDIsNC4wMiAyLjEsNS4yOCAxLjQ0LDEuMTQgMy4xOCwxLjQ0IDQuODYsMS4wOCB6Ii8+PC9zdmc+"
    b = Badges.Badge(label="style", message="flat", logo=logo, logoWidth=14, logoPadding=3, color="#97ca00");
    my_appveyor = Badges.render(b)
    @test shields_appveyor == my_appveyor
end
