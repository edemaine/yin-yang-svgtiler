fs = require 'fs'

load = (filename) ->
  fs.readFileSync filename, encoding: 'utf8'
  .split '\n'             # split into lines
  .filter (line) -> line  # remove final blank line
  .map (line) ->
    line
    .replace /%/g, 'X'    # unify symbols
    .replace /0/g, 'o'
    .split ''             # split line into characters

check2x2 = (grid) ->
  for row, y in grid
    continue unless y
    for cell, x in row
      continue unless x
      if grid[y-1][x-1] == grid[y-1][x] == grid[y][x-1] == grid[y][x]
        return "INVALID at #{x},#{y}"
  'OK'

dfs = (grid) ->
  cc = {}
  recurse = (x,y,c) ->
    cc[[x,y]] = c
    for [x2,y2] in [[x-1,y], [x+1,y], [x,y-1], [x,y+1]]
      continue unless 0 <= y2 < grid.length
      continue unless 0 <= x2 < grid[y].length
      continue if cc[[x2,y2]]?
      continue unless grid[y2][x2] == grid[y][x]  # stay within color
      recurse x2,y2,c
    undefined
  count = 0
  for row, y in grid
    for cell, x in row
      continue if cc[[x,y]]?
      recurse x, y, count++
  console.log count, 'connected components'
  console.log (for row, y in grid
    (for cell, x in row
      "#{cc[[x,y]]}"
    ).join ''
  ).join '\n'
  console.log count, 'connected components'

check = (filename) ->
  console.log()
  console.log '*', filename
  grid = load filename
  console.log grid.length, 'x', grid[0].length
  console.log '2x2 check:', check2x2 grid
  dfs grid

main = ->
  for filename in process.argv[2..]
    check filename

main() if require.main == module
