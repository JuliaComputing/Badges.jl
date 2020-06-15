# Badges

A Julia library to create badges, inspired by https://shields.io

[![Build Status](https://github.com/aviks/Badges.jl/workflows/CI/badge.svg)](https://github.com/aviks/Badges.jl/actions)

### Usage

```
using Badges
b = Badge(label="build", message="passed")
Badges.render(b)  # svg string
```