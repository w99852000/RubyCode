
require 'socket'
require './database'
#require "dbi"

hostname = 'localhost'
port = 3000

s = TCPServer.new(hostname , port)

while true
	G_connection = s.accept
	Game_get = G_connection.recv(2048)
	Db = r_database.new
	
	if  Game_Info[0,1] == 1    #驗證Token
		Token = Game_Info.split(",")[1]
		if Db.db_token_check(Token) == false
			s.write "驗證失敗"
		else
			s.write "驗證成功"
			if Game_Info[0,1] == 2  #寫入棋局資訊
				Room_Name = "Room"+Game_Info.split(",")[1]
				Round = Game_Info.split(",")[2]
				ID = Game_Info.split(",")[3]
				Chess = Game_Info.split(",")[4]
				X = Game_Info.split(",")[5]
				Y = Game_Info.split(",")[6]
				Db.db_Game_insert(Room_Name , Round , ID , Chess , x , y)

			elsif Game_Info[0,1] == 3    #更新遊戲狀態
				Room_Name = "Room"+Game_Info.split(",")[1]
				Round = Game_Info.split(",")[2]
				Game = Db.db_get_game(Room_Name , Round)
				s.write Game

			elsif Game_Info[0,1] == 4     #遊戲結束
				win_player = Game_Info.split(",")[1]
				lose_player = Game_Info.split(",")[2]
				Db.db_win_lose_update(win_player , lose_player)
			else
				s.write "Error"
			end
		end
	else
		s.write "Error"
	end
end

#def Get_Game_Info
#	hostname = 'localhost'
#	port = 3000
#	s = TCPServer.new(hostname , port)
#	G_connection = s.accept
#	Game_get = G_connection.recv(2048)
#	return Game_get
