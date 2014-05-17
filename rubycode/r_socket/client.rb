require 'socket'
hostname = 'localhost'
port = 3000
c = TCPSocket.new(hostname, port)
c.write "hi server!"
puts "got back:" + c.recv(2048)
c.close
