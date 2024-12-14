"""
  SoniCalc - Sonic Calculater

  Sonic Calculater is synthizer, drum machine, sequenzer and much more

  It can be used as a calculater, which can be d
  the computer, handy or the device it self is 


(>OP()[iio=0..1])   iOP()
                    sOP()
                    oOP()  (OP>()[0..1])

 inpVAL[]           eOP()

BUS
  
  a  attack
  b
  c  copy, clone
  d  decay, default
  e  element
  f
  g
  h
  i
  j
  k
  l
  m
  n
  o
  p
  q quantice
  r release, record
  s sustain, sequenze / slide
  t
  u
  v volume
  w
  x effect, cut
  y
  z
  d    


r>recording overdup track 1 (quantized), length(4*8: 32), instument: drum
 > ..#n...|...n...|...n...|...n...|
1> ...1...|...n...|...n...|...n...| 
2> ...1...2...n...|...n...|...n...|
1> ...1...2...1.1.2...n...|...n...|
1> ...1...2...1.1.2...n...|...n...|
2> ...1...2...1.1.2...n...|...n...|
...1...2...1.1.2> 
t1=...1...2...1.1.2...1...2...1.1.2
r recording off
v=b%4==0 ? 8 : 4 # set the volume to 0.8 on /4-beats and to 0.4 else 
t2 set to track 2 (quantized), length(4*8: 32), instument: drum
i p - [i]nstrument set to [p]iano
r recording overdup track 2 (quantized), length(4*8: 32), instument: piano
 >...x..x.c.x.b...n...b...v.c.d.x.
  ...x..x.c.x.b...n...b...v.c.d.x.

s


"""

def = {
   'setOP': {
      '|': ['OR', 'min', 'takes the biggest value'],
      '&': ['AND', 'max', 'takes the smallest value'],
      'X': []
      '+': ['ADD', ]
      '-': ['SUB', ]
   },
   'io_OP': {
      '-': ['', ],
      '+', 
      '*',
      '-',
      '%', 'MOD', ' mod I', "Mudulo / thus digital "
      '2',
      '~', 'DELAY', 
   }
}


IO_OP = { '_', '-', '01' }