require 'dbi'


dbh = DBI.connect("DBI:Mysql:Sqa:4500", "w99852000", "as71011699852000")
def  db_search()
begin
	dbh = DBI.connect("DBI:Mysql:Sqa:4500", "w99852000", "as71011699852000")	
end	

def db_Game_insert(Table_Name ,Round, x ,y)
begin
	
	table = Table_Name +"(Round , X , Y)"
	value = "VALUES (Round, x, y)"
	sql = "insert into" + table + value
	dbh.do(sql , x ,y)
end

def db_token_check(token)
begin
	if dbh.do("select token from account where token = "+token) == false
		return false

	else
		return true
	end
end

def db_get_game(Round , Room)
begin
	chess =dbh.do("seleck X from room where Round = " +Round)+","+dbh.do("seleck Y from room where Round = " +Round)
	return chess
end

def db_get_game_table(token)
begin
	table = dbh.do("select room from room_list where player1_token = token OR player2 = token")
	return table
end