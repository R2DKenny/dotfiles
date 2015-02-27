#!/usr/bin/env python2

# Import the email modules we'll need
import urllib, json, socket
import time, datetime

device="VAIO"
target_file = "/home/apo11o/ros_node/VAIO"

looping = True

if __name__ == "__main__":
  f = open(target_file, "w")
  # Wait will internet connection is established
  while (looping):
    try:
      urllib.urlopen("http://www.google.com")
    except:
      time.sleep(5)
    else:
      looping = False

  # Grab external IP address
  data = json.loads(urllib.urlopen("http://ip.jsontest.com/").read())
  # Setup socket to grab local IP address
  s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
  s.connect(('8.8.8.8', 80))

  print("External: " + data['ip'])
  print("Internal: " + s.getsockname()[0])
  f.write(device + "\n")
  f.write("External: " + data['ip'] + "\n")
  f.write("Internal: " + s.getsockname()[0] + "\n")
  f.write(datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
  f.close()

  s.close()
