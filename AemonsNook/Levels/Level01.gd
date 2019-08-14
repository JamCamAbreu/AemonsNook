extends Node

const WIDTH = 50
const HEIGHT = 35

func GetAscii():
	var output = String(ascii)
	output = output.replace(" ", "")
	output = output.replace("\n", "")
	return output

const ascii = """
TTTTTTTTTTTTTTTTTTTTTTTTWWWWWWWWWWWWWWWWWWWWWWWWWW 
TTTTTTTTTTTTTTTTTTTTTTWWWWWWWWWWWWWWWWWWWWWWWWWWWW 
TTTTTTTTTTTTTTWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW 
TTTTTTTTTTWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWT 
TTTTTWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWTTTTT 
TTWWWWWWWWWWWWWWWWWWWW---------W-W-WWTTTTTTTTTTTTT 
WWWWWWWWWWWWWWWWWWWWW-------------TTTTTTTTTTTTTT-- 
WWWWWWWWWWWWWWW--------------TTTTTTTTTTTTTTTT----- 
WWWWWWWWWWWWWWW----------TTTTTTTTTTTTTTTTTTTTT---- 
WWWWWWWWWWWWWWWW---------TTTTTTTTTTT-------------- 
WWWWWWWWW---------------TTTTTTTTT----------------- 
WWWWWW-------------------------------------------- 
WWW----------------------------------------------- 
-------------------------------------------------- 
-----------TTT------------------------------------ 
---------TTTTTTTT--------------------------------- 
-----TTTTTTTTTTT---------------------------------- 
---TTTTTTTTTTT------------------------------------ 
-------------------------------------------------- 
-------------------------------------------------- 
-------------------------------------------------- 
-------------------------------------------------- 
-------------------------------------------------- 
-------------------------------------------------- 
-------------------------------------------------- 
-------------------------------------------------- 
-------------------------------------------------- 
--------------------------------------------------  
-------------------------------------------------- 
----------------------------TTTT-----------TTTTTTT 
-----------------------TTTTTTTTTT-----WWWWWTTTTTTT 
----------TTTTTTTTTTTTTTTTTTTTTT----WWWWWWWWWWWTTT 
TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT-----WWWWWWWWWTTTT 
TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT-----WWWWWWWTTTT 
TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT 
TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"""



