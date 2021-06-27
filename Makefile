all:
	svgtiler -m -j 4 yinyang.coffee */*.asc
pdf:
	svgtiler -m -p -j 4 yinyang.coffee */*.asc
test:
	coffee --nodejs --stack-size=100000 test.coffee puzzles/*_solved.asc
