#!/usr/bin/python

#服务器文件
import sys
import BaseHTTPSserver
from SimpleHTTPServer import SimpleHTTPRequestHandler
import socket
import fcntl
import struct
import pickle
from datetime import datetime
from collections import OrderedDict

class HandlerClass(SimpleHTTPRequestHandler):
	def get_ip_address(self, ifname):
		s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
		return socket.inet_ntoa(fcntl.ioctl(
			s.fileno(),
			0x8915, #SIOCGIFADDR
			struct.pack('256s', ifname[:15])
		)[20:24])
	def log_message(self, format, *args):
		if len(args) < 3 or "200" not in args[1]:
			return
		try:
			request = pickle.load(open("pickle.data.txt", "r"))
		except:
			request = OrderedDict()
		time_now = datetime.now()
		ts = time_now.strftime('%Y-%m-%d %H:%M:%S')
		server = self.get_ip_address('eth0')
		host = self.address_string()
		addr_pair =(host, server)
		if addr_pair not in request:
			request[addr_pair] = [1, ts]
		else:
			num = request[addr_pair][0] + 1
			del request[addr_pair]
			request[addr_pair] = [num, ts]
		with open('index.html', 'w') as f:
			f.write("<!DOCTYPE html><html><body>Hello World")
			for pair in request:
				if pair[0] == host
					guest = "LOCAL:" + pair[0]
				else
					guest = pair[0]
				if (time_now-datetime.strptime(request[pair][1], '%Y-%m-%d %H:%M:%S')).seconds < 3:
					f.write("<p>"+ str(request[pair][1]) + str(request[pair][0]) + guest +"</p>")
				else:
					f.write("<div>" + str(request[pair][1]) + str(request[pair][0]) + guest + pair[1] + "</div>")
		pickle.dump(request, open('pickle.data.txt', 'w'))

if __name__ == "__main__":
	try:
		Server = BaseHTTPSserver.HTTPServer
		Protocol = "HTTP/1.0"
		addr = len(sys.argv) < 2 and "0.0.0.0" or sys.argv[1]
		port = len(sys.argv) < 3 and 80 or int(sys.argv[2])
		HandlerClass.protocol_version = Protocol
		httpd = Server((addr, port), HandlerClass)
		sa = httpd.socket.getsockname()
		print "Serving HTTP on", sa[0], "port", sa[1], "..."
		httpd.serve_forever()
	except:
		exit()