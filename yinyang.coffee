###
SVG Tiler symbol definition file for Yin-Yang puzzles.
Written in CoffeeScript using JSX notation to represent SVG.

Supported notation:
  X - black circle in cell (can also use x)
  o - white circle in cell (can also use O)
  . - blank cell to be filled in
  % - dotted black circle in cell (to indicate added from initial puzzle)
  0 - dotted white circle in cell (to indicate added from initial puzzle)
  </>/^/v - arrows (for gadgets)
  space - blank space of the size of cell (for aligning gadget arrows)
###

box = (circle, dash) ->
  ## Normally, black circles have white outlines, and vice versa.
  opposite = if circle == 'black' then 'white' else 'black'
  ## However, dashed white circles have a white outline plus a dotted black
  ## outline, and vice versa.
  <symbol viewBox="0 0 20 20" overflowBox="-0.5 -0.5 21 21">
    <rect width="20" height="20" stroke="black" fill="#ddd"/>
    {if circle?
      <>
        <circle cx="10" cy="10" r="7" fill={circle}
         stroke={if dash then circle else opposite}/>
        {if dash
          <circle cx="10" cy="10" r="7" fill="none"
           stroke={if circle == 'black' then 'white' else 'black'}
           stroke-dasharray={dash}/>
        }
      </>
    }
  </symbol>

arrow = (angle) ->
  ## angle = 0 is left arrow
  <symbol viewBox="0 0 20 20" transform={if angle then "rotate(#{angle},10,10)"}>
    <line x1="9" y1="10" x2="20" y2="10" stroke="black" stroke-width="5"/>
    <polygon points="3,10 10,4 10,16"/>
  </symbol>

o: box 'white'
O: box 'white'
x: box 'black'
X: box 'black'
'0': box 'white', '2,2'
'%': box 'black', '2,2'
'.': box()
' ': <symbol viewBox="0 0 20 20"/>
'<': arrow 0
'>': arrow 180
'^': arrow 90
'v': arrow -90
