# dm3v06 L.A. N19 - ambient coder - edur pentatiano v7


# https://www.youtube.com/watch?v=9MvEUA6ZqLY
# https://www.youtube.com/watch?v=H3-E8krDpIA
# https://www.youtube.com/watch?v=l1ZnWc-sFd0
# https://www.youtube.com/watch?v=Zd_UcjMusUA
# https://www.youtube.com/watch?v=OX8JWjf5998
'
System Of A Down

https://www.youtube.com/watch?v=Y9UdrctkzbQ
# goosebombs, billie, Do You Feel Like We Do, a whiter shade of pale, hey joe, Stairway to Heaven

Frusciante 
'

stop_all=false

$gfx_piano="""
 o    |~~~| 
/\\_  _|   | 
\\__`[_    |
][ \\,/|___|
""".split("\n")

$gfx_keyboard = """    _______________________________________________________
   |:::::: o o o o . |..... . .. . | [45]  o o o o o ::::::|
   |:::::: o o o o   | ..  . ..... |       o o o o o ::::::|
   |::::::___________|__..._...__._|_________________::::::|
   | # # | # # # | # # | # # # | # # | # # # | # # | # # # |
   | # # | # # # | # # | # # # | # # | # # # | # # | # # # | 
   | # # | # # # | # # | # # # | # # | # # # | # # | # # # |
   | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
   |_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|
"""
$gfx_keyboard_dup=$gfx_keyboard.dup



$s = 0
#$f && $f.close()
#$f = File.open("C:\\Users\\Mulacke\\Google Drive\\Proj\\2021_sonic_pi\\ambient coder\\ac04_pentaiano_"+Time.new.strftime("%Y%m%d_%H%M%S")+".log", "w")
#    0  , 1    2    3    4    5    6    7           8           9
p  = [:d3, :e3, :g3, :a3, :b3, :d4, :e4, [:e3, :g3], [:a3, :b3]] # d-dur? print s=scale(:d2, :major, num_octave: 2)
po = [:d4, :e3, :g4, :a4, :b4, :d5, :e5, [:e3, :g4], [:a3, :b4]]
pw = [[p[3], p[4], p[3]+12, p[4]+12], [p[1], p[2], p[1]+12, p[2]+12]]
puts p[0..6].map { |pi| pi.to_s+"/"+pi.to_i.to_s } # + str(pi.to_i) }

use_debug false
use_bpm 10

#$file='C:/Users/Mulacke/Google Drive/Proj/2021_sonic_pi/dv.txt'
$d = [" | |   | | |  "*4+" "*15]*30
def draw_piano(aNote)
  #p ",", aNote.class
  s=" | |   | | |  "*4
  def get_pos(note)
    n = note.to_i
    p = n/12*14+n%12+(n%12>4?1:0)+(n%12>10?1:0)
    return p-14*3
  end
  if aNote.class == Array then
    aNote.each { |n| s[get_pos(n)] = "*" }
  else
    s[get_pos(aNote)]="*"
  end
  s+=aNote.to_s.gsub(/(\[|\])/,"").ljust(15)
  
  $d.shift 1# if $d.length > 10
  $d.push s
  
  if rand_i(10)==0 then
    $gfx_keyboard_dup=$gfx_keyboard.dup
    (rand_i(50)+50).times {
      z = rand_i(60*4)
      $gfx_keyboard_dup[z] = '.' if $gfx_keyboard_dup[z] == ':'
      $gfx_keyboard_dup[z] = '*' if $gfx_keyboard_dup[z] == 'o'
      $gfx_keyboard_dup[z] = ' ' if $gfx_keyboard_dup[z] == '.'
    }
  end
end

live_loop :drawer do
  s12 = lambda { |x2| (x2.times.map { " "*(r=rand_i 10) + ["* "," ."," °", "+ "].choose + " "*(10-r) }).join }
  swin = lambda { |x2| (x2.times.map { "|"*(r=rand_i 10) + ["* "," ."," °", "+ "].choose + " "*(10-r) }).join }
  File.open($file, "w+") { |f|
    $d_dup = $d.dup
    $d_dup.length.times { |i|
      $d_dup[i] += s12[9] if i < 20
      $d_dup[i] += s12[1]+"-"*12*8 if i == 20 or i== 29
    }
    $gfx_piano.length.times { |i| $d_dup[i+24] += s12[1]+"       "+ $gfx_piano[i] }
    k = $gfx_keyboard_dup.split("\n").map { |s| s+" "*15+s12[9] }
    f.write("    "+$d_dup.join(+"\n    ")+"\n")
    f.write(k.join("\n"))
  }
  sleep 0.05
  stop if stop_all
end

#print "1s".chars;stop

def play_fpat1(aNotes, aMelody, aEffects="", a7=0)
  a = aMelody.scan(/(\d)([^\d]*)/)
  a.each_with_index do |x, i|
    c = x[1].chars
    e = aEffects.ljust(a.length).chars[i]
    n = x[0].chars[0].to_i
    l = (1 + x[1].length)# * 0.025
    play aNotes[n], decay: x[1].count("d")*0.05, vel: (e=="v" ? 0.25 : nil), amp: (e=="l" ? 0.25 : 1)
    draw_piano(aNotes[n])
    cue "e" if a7>0 and n == 7
    cue "ae" if a7==1 and n == 8
    cue "ad" if a7==2 and n == 8
    sample :drum_bass_hard, amp: 0.25 if e == "d" # the drum sounds well within the same effects, as the piano
    l.times { |i|
      #print c[i]
      #sample :tabla_te2, amp: 0.025 if c[i] == "s"
      #sample :tab, amp: 0.125 if c[i] == "k"
      sleep 0.025
      draw_piano([])
      
    }
  end
end
#                 1.2.1.2.1.2.1.2.1.2.1.2.1.2.1.2.1.2.1.2.1.2.1.2.
$pats={ "a1p"  => "....0d......2.3.....s...s...ss.ss437ddd......", #stroll around
        #"a_" => "...................................7.........",
        "b10p"  => "5.5.643.0.........7dd........4....", #start a litle bit
        "b11p"  => "8d..................",
        "b12p"  => "4.5.4...8...7dd.....", #start a little bit
        #"b2d" => "................s.s",
        "b13p"  => "5.5.643...7dd.............",
        "c10p"  => "5.5.643.0dd.....7...",
        "c11p"  => "4.4.3.3.7dd.........",
        "c12p"  => "4.5.4...8...7ddd....",
        #"c2b" => "........1...........",
        "c13p" => "5.5.643.7ddd1d3d..........",
        
        "r10p" => "22.1.8.8...7....",
        "r11p" => "17.1.3.4...7....",
        "r12p" => "77.1.4.3...7....",
        "r13p" => "11.7.3.4...7....", #oct-pitch
        
        "break10p"   => "5643210...8dd......", #downstairs
        #"break0b" => "..........1........",
        "break1p"  => "564321073...8...743..8...7.1...7...", #stumbling
        "break2p"  => "0.........1.........", #crahs
        
        "a2p"  => "....0d......2.3...3.. 3.4.34 34 3437ddd7.7 77", #stroll around
        "b20p"  => "5.5.64.64.43.3.3.37ddd7.7 77.4.4d.", #start a litle bit
        "b21p"  => "8ddd8.88...4 5.45 45",
        "b22p"  => "4.5.4...8...7dd.7 77", #start a litle bit
        #"b2d" => "................s.s",
        "b23p"  => "5.5.643.437dd.7 7707dd.7 77",
        "c20p"  => "5.5.643.0dd.0 007.77",
        "c21p"  => "4.4.3.3.7dd.7 77.45.",
        "c22p"  => "4.5.4...8...7dd.7 77",
        #"c2b" => "........1...........",
        "c23p" => "5.5.643.7ddd1d3ddddd....33",
        "r20p" => "22.1.8.8...7..77",
        "r21p" => "17.1.3.4...7..77",
        "r22p" => "77.1.4.3...7..77",
        "r23p" => "11.7.3.4...7..77", #oct-pitch
        "break20p"  => "5643210.008dd8...88", #downstairs
        }
print $arr = "a,3.b,a,3.c,3.break".split(',').flat_map { |e|
  
  ea=e.split(".")
  (ea.length > 1 ? (0..ea[0].to_i).map { |i| ea[1]+i.to_s } : e) #*ea[1]) : e
}
$tick=0

def piano(aNotes, aMelodyName, aE: "", a7: 1, aInfo: "")
  pat =  $pats[aMelodyName+"p"]
  print "piano: %d/%s: %s (a7: %d, aE: %s)" % [$tick, aMelodyName, pat, a7, aE]
  $tick += pat.length
  play_fpat1(aNotes, pat, aEffects=aE, a7=a7)
end

live_loop :b do
  use_synth :bnoise
  n = play 60, amp: 0.01, sustain: 1000, attack: 2
  sleep 1000
  stop
end
live_loop :tick2n3 do
  sync 1
  with_fx :hpf do
    [0.1, 0.1, 0.05, 0.05, 0.05].each { |sleepy| sample :elec_tick; sleep sleepy }
  end
end
live_loop :wum_e1 do
  with_fx :gverb, mix: 0.25, release: 2 do
    use_synth :beep
    sync "e"
    play  (chord :e2, :minor), release: 0.75
end end
live_loop :wum_ae do
  with_fx :gverb, mix: 0.25, release: 2, amp: 0.5 do
    use_synth :beep
    sync "ae"
    n = play  (chord :a4, :minor), attack: 0.25, release: 0.5, note_slide: 0.05
    sleep 0.25 # next chord starts .275 later, but we start slide at .25
    control n, note: (chord :e4, :minor)#[1..2]
    play :e4, release: 0.25, amp: 0.25 # a little attack
    #play  (chord :e4, :minor), release: 0.275
end end

live_loop :wum_ad do
  with_fx :gverb, mix: 0.25, release: 2, amp: 0.5 do
    use_synth :beep
    sync "ad"
    n = play  (chord :a4, :minor), attack: 0.25, release: 0.5, note_slide: 0.05
    sleep 0.25 # next chord starts .275 later, but we start slide at .25
    control n, note: (chord :d4, :minor)#[1..2]
    #play :e4, release: 0.25
    #play  (chord :e4, :minor), release: 0.275
end end
'
live_loop :x do
  2.times { |intro|
    cue 1
    use_synth_defaults release: 0.25, pan: 0.75
    with_fx :slicer, phase: 0.025 do #, mix: 0.25 do
      piano po, "a", a7: intro
    end

    #ts_amp=0.05*intro
    with_fx :bitcrusher, mix: 0.05 do
      with_synth :saw do
        4.times { |i| piano p, (intro == 0 ? "b%d" : "c%d") % i , a7: intro*2 }
    end end
  }
end
live_loop :y do
  2.times { |intro|
    cue 1
    use_synth_defaults release: 0.25 , pan: -0.75  #with_fx :slicer, phase: 0.025 do #, mix: 0.25 do
    piano po, "a", a7: intro
    #end


    #ts_amp=0.05*intro
    4.times { |i| piano p, (intro == 0 ? "b%d" : "c%d") % i , a7: intro*2 }
  }
end
'

# 'TODO: cymbal 4 refrain
live_loop :r_cymbal do
  sync 111
  ("  s.s s sss ssc "+"31s.s s sss ssc "+"31s.s s s2s ssc "*2).chars.each do |c|
    
    sample :drum_cymbal_pedal, rate: 2, amp: 0.05 if c=="3" or c=="2" or c=="1"
    sleep 0.01 # do later
    sample :drum_cymbal_pedal, rate: 2, amp: 0.125 if c=="s" or c=="3" or c=="2"
    sample :drum_cymbal_closed, rate: 1, amp: 0.25 if c=="c"
    sleep 0.01
    sample :drum_cymbal_pedal, rate: 2, amp: 0.05 if c=="3"
    sleep 0.005
  end
end
'
with_synth :blade do
  sleep 0.01
  play (chord p[2]+12, :minor), decay: 0, sustain: 0, attack: 0, release: 0.025
  sleep 0.01
end
'

with_synth :piano do
  with_fx :gverb, mix: 0.5, amp: 0.5 do
    with_fx :echo, decay: 0.05, phase: 0.05, amp: 0.5 do # let it bounce half beat onto the melody
      play_fpat1 po, "5d..5d..", "v...v..."
    end
    piano po, "break10"
end end





#sample :elec_fuzz_tom
#stop
#sample :drum_splash_soft, rate: -1
#sleep 0.25

ts_amp=0.025
live_loop :tststs do
  #use_sample_defaults
  if ts_amp > 0 then
    with_fx :bpf do
      8.times { |i|
        #print "i:%d pedal:%d closed: %d" % [i, ((i/2)*2), ((7-i)/2)]
        sample :drum_splash_soft, rate: -1 if i==6
        ((i/2)*2).times { sample :drum_cymbal_pedal, amp: ts_amp<0 ? 0 : ts_amp; sleep 0.025 }
        ((7-i)/2).times { sample :drum_cymbal_closed, amp: ts_amp<0 ? 0 : ts_amp; sleep 0.05 }
        ts_amp += 0.01
      }
      #sample :elec_fuzz_tom
    end
  else
    sleep 0.15
  end
    stop if stop_all

end
sleep 0.15*8
ts_amp=-1
round="1"
live_loop :l do
  #sample :ambi_swoosh, rate: 0.6, amp: 0.25
  #sleep 0.5
  
  
  with_synth :piano do
    with_fx :gverb, mix: 0.125 do |fx_gverb|
      
      def r(p, po, r, drum=".", a7=0)
        r = "r"+r
        piano p, r+"0", aE: "vv..."+drum, a7: a7
        piano p, r+"1", aE: "....."+drum, a7: a7
        piano p, r+"2", aE: "vv..."+drum, a7: a7
        piano po, r+"3", aE: "....."+drum, a7: a7
      end
      
      # intro 1 and 2: a, b[0..3], a, c[0..3]
      2.times { |intro|
        cue 1
        piano p, "a"+round, a7: intro
        #ts_amp=0.05*intro
        4.times { |i| piano p, ((intro == 0 ? "b" : "c")+"%d%d") % [round, i], a7: intro*2 }
      }
      
      piano p, "break"+round+"0"
      with_fx :echo, decay: 0.05, mix: 0.125, phase: 0.05 do
        r p, po, round, drum="d", a1=1
      end
      piano p, "break1", a7: 0
      with_fx :gverb, mix: 0.5, amp: 0.75 do with_fx :flanger, mix: 0.5, amp: 1 do #with_synth :sine do
          piano pw, "break2"
      end end
      
      cue 1 #bloed, oder?
      sleep 0.25
      with_fx :gverb, mix: 0.125, amp: 0.5 do
        cue 111 if round == "2"
        r p, po, round
      end
      with_fx :ixi_techno do
        r p, po, round
        with_fx :echo, decay: 0.05, mix: 0.125, phase: 0.05 do
          cue 111 if round == "2"
          r p, po, round, drum="d"
        end
        with_fx :gverb , mix: 0.125, amp: 0.5 do
          r p, po, round
        end
      end
      
      sleep 0.5
      with_fx :echo, decay: 0.05, phase: 0.05, amp: 0.5 do # let it bounce onto the melody
        play_fpat1 po, "5d..5d..", "v...v..."
      end
      piano po, "break"+round+"0"
      
      sleep 0.025*8
      with_fx :echo, decay: 0.05, phase: 0.05 do
        with_fx :echo, decay: 0.025, phase: 0.05, amp: 0.5  do #echo 2 buzz
          play_fpat1 po, "5d..5d..", "v...v..."
          piano po, "break"+round+"0"
        end
      end
      
      
      sleep 0.025*8
      with_fx :echo, decay: 0.05, phase: 0.05, amp: 0.5 do # let it bounce half beat onto the melody
        play_fpat1 po, "5d..6d..3.4...", "v...v..."
      end
      play_fpat1 po, "0.8ddd", "..v...", a7=2 # wobble to a
      sleep  0.025*8
      play_fpat1 po,  "0.8ddd.......5.5656.5.6.5643210...8d......0.0.", "..v..."
      piano po, "break1"
      play_fpat1 po, "....7ddd...........", aEffects="", a7=1
      with_fx :gverb, mix: 0.5, amp: 0.75 do with_fx :flanger, mix: 0.5, amp: 1 do
          piano pw, "break2"
      end end
	  if round=="2" then
		stop_all=true
	    stop 
	  end
      round = "2"
  end end
end
while not stop_all do
  sleep 1
end
