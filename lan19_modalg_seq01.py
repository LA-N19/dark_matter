#name = "D:/LA-N19/dark_matter/lan19_modalg_seq01"
fname = "/mnt/d/LA-N19/dark_matter/lan19_modalg_seq01"

import time, os, sys, termios, atexit
from select import select

# Save normal terminal settings
fd = sys.stdin.fileno()
old_term = termios.tcgetattr(fd)

def set_normal_term():
    termios.tcsetattr(fd, termios.TCSAFLUSH, old_term)

# Debuffer new terminal until exit
new_term = termios.tcgetattr(fd)
new_term[3] = (new_term[3] & ~termios.ICANON & ~termios.ECHO)

def set_curses_term():
    termios.tcsetattr(fd, termios.TCSAFLUSH, new_term)

atexit.register(set_normal_term)
set_curses_term()

def kbhit():
    dr,dw,de = select([sys.stdin], [], [], 0)
    return dr != []

def getch():
    return sys.stdin.read(1)

st = ""
i = 0
while True:
    i = i + 1
    os.system('clear')
    with open(fname+".log", 'r') as f:
      print(f.read()+ st + (" " if i%2 == 0 else "_"))
    time.sleep(0.1)
    if kbhit():
      key = getch()
      if key == "\x7f" and len(st):
        st = st[0:len(st)-1]
      elif key == "\n":
        with open(fname+".inp", 'w') as f:
           f.write(st)
           st = ""
      else:
        st = st + key
    