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
TTTTTTTTTTTTTTTTTTTTTT--------------------DDDDDDDD
TTTTTTTTTTTTTTTT-TT------------------DDDDDDDDDDDDD
TTTTTTTTTTTTTT-----------------DDDDDDDD-----------
TTTTTTTTT-----------------DDDDDDDDD---------------
TTTTTTT---------------DDDDDDDD--------------------
-----------------DDDDDDDDDD-----------------------
--------------DDDDDD------------------------------
-----------DDDDD----------------------------------
---------DDDD------------------WWWWWW-------------
------DDDD-----------------WWWWWWWWWW-------------
----DDDD--------------WWWWWWWWWWWWWWW-------------
DDDDD----------------WWWWWWWWWWWWWWWW-------------
DDD-----------------WWWWWWWWWWWWWWWW--------------
D------------------WWWWWWWWWWWWWWWW---------------
-------------------WWWWWWWWWWWWWWW----------------
------------------WWWWWWWWWWWWWW------------------
---------------------WWWWWWWWWW---------TTTTT-----
--------------------------W------------TTTTTT-----
---------------------------------------TTTTT------
--------------------------------------------------
--------------------------------------------------
------------------------WWWWWWWWWW----------------
-----------------WWWWWWWWWWWWWWWWWW---------------
------------WW-WWWWWWWWWWWWWWWWWW-----------------
----------WWWWWWWWWWWWWWWWW-----------------------
-------WWWWW--------------------------------------
-------W------------------------------------------
--------------------------------------TTTT--------
------------------------------------TTTTTTT-------
-----------------------------------TTTTTTTTT------
----------------------------------TTTTTTTTTTTT----
--------------------------------------------------
--------------------------------------------------
"""



