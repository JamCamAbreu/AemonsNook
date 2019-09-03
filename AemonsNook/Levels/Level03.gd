extends Node

const WIDTH = 50
const HEIGHT = 35

func GetAscii():
	var output = String(ascii)
	output = output.replace(" ", "")
	output = output.replace("\n", "")
	return output

const ascii = """
TTT--TT-TTTTTTT---WWW--TTTTTTTTTTTTTTTTTTTTTTTTTTT
WW--TTTT---TTT---WWW--TTTTTTTTTTTTTTTTTTTTTTTTTTTT
WWWW------WWWWWWWWW-TTTTTTTTTTTTTTTTTT-----TTTTTTT
-WWWWWWWWWWWWWWWWW--TTTTTTTTTTTTTTTT----------TTTT
------WWWWWWWW------TTTT-----TTTTTTT----WWW---TTTT
------------------------------TTTTTTT---WWWW---TTT
-------------------------------TTTTTT---WWWWW---TT
-----DDDDDDDDDDDDDDDDDDD--------TTTTTT----WWW---TT
1DDDDD-----------------DDDD-------TTTTT---------TT
1D------------------------DD------TTTTTTTTT------T
---------------------------DD---------TTTTTT----TT
----------------------------DD---------TTTTT----TT
-----------------------------DD--------TTTTTTTTTTT
---------TTT------------------DD--------TTTTTTTTTT
--------TTTTTTT----------------D---------TTTTTTTTT
--------TTTTTTTTTT-------------D---------TTTT-TTTT
-------------------------------D---------TTTTTTTTT
-------------------------------D--------TTTTTTTTTT
-------------------------------D-------TTTTTTTTTTT
------TTTTT-------------------DD-------TTTTTTTTTTT
------TTTTTTTTTTTTTT---------DD-------TTTTTTTTTTTT
--------TT--------TTT--------D---------TTTTTTT-TTT
-------------------TT--------D-----------TTTTTTTTT
-----TTTTTT------------------D--------TTTTTTTTTTTT
-----TTTTTT------------------D-------TTTTTTTTT-TTT
--------T-------------------DD-------TTTTTTTTTTTTT
---------------------------DD--------TTTTTTTTTTTTT
--------------------------DD------------TTTTTTTTTT
-----------------------DDDD----------------TTTTTTT
2D----------------DDDDDD--------------TTTTTTTTTTTT
-DDDDDDDDDDDDDDDDDD--------------TTTTTTTTTTTTTTTTT
--------------------------------TTTTTTTTTTTTTTTTTT
------------------------TTTT---TTTTTTTTTTTTTTTTTTT
TTTTT-TTTTTT-TTT------TTTTTTTTTTTTTTTTTTTTTTTTTTTT
TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT-TTTTTTTTTT
TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
"""



