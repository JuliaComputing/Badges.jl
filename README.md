# Badges

A Julia library to create badges, inspired by https://shields.io

### Usage

```
using Badges
b = Badge(label="build", message="passed")
Badges.render(b)  # svg string
```