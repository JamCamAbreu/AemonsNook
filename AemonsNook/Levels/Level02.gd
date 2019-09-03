extends Node

const WIDTH = 50
const HEIGHT = 35

func GetAscii():
	var output = String(ascii)
	output = output.replace(" ", "")
	output = output.replace("\n", "")
	return output

const ascii = """
TTTTTTTTTTTTTTTTTTTTTTTTT-------------------------
TTTTTTTTTTTTTTTTTTTTTTTTT-------------------------
TTTTTTTTTTTTTTTTTTTTTTTT--------------------------
TTTTTTTTTTTTTTTTTTTTTT--------------------DDDDDDD2
TTTTTTTTTTTTTTTT-TT------------------DDDDDDDDDDDD2
TTTTTTTTTTTTTT-----------------DDDDDDDD-----------
TTTTTTTTT-----------------DDDDDDDDD---------------
TTTTTTT---------------DDDDDDDD--------------------
-----------------DDDDDDDDDD-----------------------
--------------DDDDDD------------------------------
-----------DDDDD----------------------------------
---------DDDD------------------WWWWWW-------------
------DDDD-----------------WWWWWWWWWW-------------
----DDDD--------------WWWWWWWWWWWWWWW-------------
1DDDD----------------WWWWWWWWWWWWWWWW-------------
1DD-----------------WWWWWWWWWWWWWWWW--------------
1------------------WWWWWWWWWWWWWWWW---------------
------------------WWWWWWWWWWWWWWWW----------------
------------------WWWWWWWWWWWWWW------------------
---------------------WWWWWWWWWW---------TTTTT-----
-------------------------WW------------TTTTTT-----
---------------------------------------TTTTT------
--------------------------------------------------
--------------------------------------------------
------------------------WWWWWWWWWW----------------
-----------------WWWWWWWWWWWWWWWWWW---------------
------------WW-WWWWWWWWWWWWWWWWWW-----------------
----------WWWWWWWWWWWWWWWWW-----------------------
-------WWWWW--------------------------------------
-------WW-----------------------------------------
--------------------------------------TTTT--------
------------------------------------TTTTTTT-------
-----------------------------------TTTTTTTTT------
----------------------------------TTTTTTTTTTTT----
--------------------------------------------------
--------------------------------------------------
"""



