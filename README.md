# Badges

A Julia library to create badges, inspired by https://shields.io

Only the *flat* style of badges are available. *Social* badges are not available. 

### Example

```
using Badges
b = Badge(label="build", message="passed")
Badges.render(b)  # svg string
```

### API

```
Badge(; 
    label="",
    message,
    leftLink="",
    rightLink="",
    logo="",
    logoWidth=0,
    logoPadding=0,
    color = "#4c1",
    labelColor = "#555",
    fontFamily = "font-family='Verdana,Geneva,DejaVu Sans,sans-serif'",
    height = 20,
    verticalMargin=0,
    shadow=true)::Badge
```
Create a Badge. Returns a Badges.Badge object, that contains metadata 
and pre-rendered segments. 

---

```
render(b::Badge)::String
```
Fully render a badge to SVG. Returns a String. 

