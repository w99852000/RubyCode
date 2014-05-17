require 'socket'
require 'r_database'

hostname = 'localhost'
port = 3000

s = TCPServer.new(hostname , port)

loop{
	connection= s.accept
	get_string = connection.recv(2048)
	db = r_database.new
	if get_string[0] != '('
		if db.db_token_check(get_string) == true
			table = db.db_get_game_table(token)
		end
	else
		while true
			move = connection.recv(1024)
			Round = 1
			x = move[1,1]
			y = move[3,1]
			db.db_Game_insert(Table ,Round, x ,y)
			if Round%2 == 1
				
			if connection.recv(2048) = "end"
				break
			end
		end	

	end
		

}

