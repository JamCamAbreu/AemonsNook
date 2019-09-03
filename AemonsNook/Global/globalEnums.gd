extends Node

enum CLICK_TYPE { TREE, STONE }

enum TILETYPE { GRASS, WATER, TREE, DIRT}

const TILE_SIZE_PIXELS = 32

const NUM_TREE_SPRITES = 6

enum TILE_SHAPE { EMPTY, HORIZONTAL, VERTICAL, UP_LEFT, UP_RIGHT, 
                  DOWN_RIGHT, DOWN_LEFT, RIGHT_T, DOWN_T, LEFT_T, 
                  UP_T, INTERSECTION }

enum MODE { NORMAL, BUILD }

enum MOUSE_STATE { NONE, INSIDE, OUTSIDE }



enum PEEP_TYPE { HOMELESS, THIEF, FARMER, TRADER, KNIGHT, BARD, 
                 LORD, LADY, QUESTER, WIZARD, KING, MONK, WITCH,
                 NUN, FOREIGNER, ELDER }

enum SEX { MALE, FEMALE }

enum TASK_TYPE { EXPLORE, SEEK_FOOD, SEEK_REST, EXIT, SEEK_BRAWL, POOP, SEEK_TAVERN, 
                 SEEK_BATHROOM, SEEK_BLACKSMITH}



func GetEnumName(whichEnum):
	var index = randi() % whichEnum.size()
	return whichEnum[index]

const PEEP_MALE_FNAMES = [ "Merek", "Carac", "Ulric", "Tybalt", "Borin", "Sadon", "Terrowin", "Rowan", "Forthwind", "Fendrel", "Brom", "Hadrian", "Walter", "Earl", "John", "Oliver", "Justice", "Clifton", "Walter", "Roger", "Joseph", "Geoffrey", "William", "Francis", "Simon", "John", "William", "Edmund", "Charles", "Benedict", "Gregory", "Peter", "Henry", "Frederick", "Walter", "Thomas", "Arthur", "Bryce", "Donald", "Letholdus", "Lief", "Barda", "Rulf", "Robin", "Gavin", "Terrin", "Ronald", "Jarin", "Cassius", "Leo", "Cedric", "Gavin", "Peyton", "Josef", "Doran", "Asher", "Quinn", "Zane  ", "Destrian", "Dain", "Falk", "Berinon", "Tristan", "Gorvenal" ]
const PEEP_FEMALE_FNAMES = [ "Alys", "Ayleth", "Anastas", "Alianor", "Cedany", "Ellyn", "Helen", "Eliose", "Peronell", "Sibyl", "Esme", "Thea", "Jacquelyn", "Amelia", "Gloriana", "Bess", "Catherine", "Anne", "Mary", "Arabella", "Elizabeth", "Hildegard", "Brunhild", "Adelaide", "Alice", "Beatrix", "Cristiana", "Eleanor", "Emeline", "Isabel", "Juliana", "Margaret", "Matilda", "Mirabelle", "Rose", "Helena", "Guinevere", "Isolde", "Maerwynn", "Muriel", "Winifred", "Godiva", "Catrain", "Jasmine", "Josselyn", "Maria", "Victoria", "Gwendolynn", "Janet", "Luanda", "Atheena", "Dimia", "Phrowenia", "Aleida", "Ariana", "Alexia", "Katelyn", "Katrina", "Loreena", "Kaylein", "Seraphina", "Duraina", "Ryia", "Farfelee", "Benevolence", "Brangian", "Elspeth" ]
const SIRNAMES_COMMON = [ "Mason", "Carpenter", "Cheeseman", "Cook", "Fisher", "Fletcher", "Forester", "Shepherd", "Baker", "Wood", "Belcher", "Meeger", "Potter", "Wrinkle", "Plump" ]
const SIRNAMES_MIDDLE = [ "Braun", "Baxter", "Bennett", "Granger", "Hayward", "Lister", "Mannering", "Sawyer", "Ward", "Webb", "Wright", "Williams", "McCloy", "Duncan" ]
const SIRNAMES_ROYAL = [ "Nook", "Bonaparte", "Valentine", "Wales", "Windsor", "Hanover", "Grimm" ]
const TITLES_MALE = [ "Mountain", "Rock", "Quick and Nimble", "Rich in Wisdom", "Swift as the Wind", "Slayer of Dragons" ]
const TITLES_FEMALE = [ "Bringer of Joy", "Fairest of Ladies", "Envy of the North", "Delicate as Rain", "Blossom of Peace" ]