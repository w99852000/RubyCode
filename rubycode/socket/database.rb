#!/usr/bin/ruby -w

require 'dbi'
begin
	class Database
		def dbGameInsert(room_name, round, id, chess, x, y)	
			dbh = DBI.connect("DBI:Mysql:Sqa:localhost", "root", "as71011699852000")
			room = room_name + "( round, id, chess, x, y)"
			values = "(?,?,?,?,?)"
			sql = "insert into " + room + values
			dbh.do(sql ,  round , id, chess, x, y)
		end

		def db_token_check(token)
			dbh = DBI.connect("DBI:Mysql:Sqa:localhost", "root", "as71011699852000")
			if dbh.select_one("select token from account where token = " + token) == false
				return false
			else
				return true
			end
		end

		def db_get_game(room_name , round)
			dbh = DBI.connect("DBI:Mysql:Sqa:localhost", "root", "as71011699852000")
			chess = dbh.select_one("seleck Chess from " + room_name + "where Round = " + round)
			x = dbh.select_one("seleck Chess from " + room_name + "where Round = " + round)
			y = dbh.select_one("seleck Chess from " + room_name + "where Round = " + round)
			move = chess + "," + x + "," + y
			return move
		end

		def db_get_game_room(token)
			dbh = DBI.connect("DBI:Mysql:Sqa:localhost", "root", "as71011699852000")
			table = dbh.select_one("select room from room_list where player1_token =" + token + "OR player2 =" + token)
			return table
		end

		def db_win_lose_update(win_player , lose_player)
			dbh = DBI.connect("DBI:Mysql:Sqa:localhost", "root", "as71011699852000")
			dbh.do("update Win_Lose set win = win+1 where ID="+win_player)
			dbh.do("update Win_Lose set lose = lose+1 where ID="+lose_player)
		end
	end
end