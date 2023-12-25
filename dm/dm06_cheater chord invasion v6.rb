
# interpret: L.A. N19
# album:     ambient coder
# song:      cheater chord invasion
# version:   0.5
# 14.03.2021: reduce d_dingel == 4-effects
# freac - audio converter

use_debug false
sleeping = 16

final_stop = false

man_pos = 25
man_vel = 1
live_loop :pic do
  t = tick
  File.open($file, "w+") { |f|
    s12 = lambda { |x2| (x2.times.map { " "*(r=rand_i 10) + ["* "," ."," °", "+ "].choose + " "*(10-r) }).join }
    ascii = []
    stars=(0..15).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," ."," °", "+ "].choose + " "*(8-r)}).join  }
    bar = ["-"*188]
    spa = ((1..3).map {""})
    lp_abehmer=""
    
    
    lp = """
.----------------.              
|             0  |              
|     x   x      |              
|   x       x    |              
|  x         x   |              
|  x    O    x   |              
|  x         x   |              
|   x       x    |              
|     x   x      |              
|            **  |   .---.      
'----------------'   |   |      
""".split("\n")
    lp = lp.map.with_index { |s,i|
      if i>8 then s+("            "+["[o]", "| |", "|_|"][i-9])*10
      elsif [1, 6].include? i then s+("-"*16+" "*14)*5
      elsif [2,3,4,5].include? i then s+("|"+" "*(rr=rand_i 12) + ["* "," ."," °", "+ "].choose + " "*(12-rr)+"|"+" "*14)*5
      else s+" "*150 end
      
    }
    lp[9][22..23]="__" if t>35
    if t<75 then
      # lp abnehmer
      lp[3][14]=lp[4][14]=lp[5][14]="|"
      lp[6][14]="#"
      
      # dave
      lp[9][26..28]=t<35 ? "  o" : " o "
      lp[10][26..28]=t<35 ? "  O" : " O "
      lp[10][26..28]="()O" if t>15 and t<35
      lp[11][27..28]=t<35 ? "/|" : "|\\"
      
    else
      # lp abnehmer
      lp[3][13]=lp[4][12]=lp[5][11]="/"
      lp[6][10]="#"
      #lp lights
      lp[10][13]=[true, false].choose() ? "*" : " "
      lp[10][14]=[true, false].choose() ? "*" : " "
      
      # lp flicker
      lp_flicker = rand_i(4)
      if lp_flicker == 1 then
        lp[7][7] =lp[8][6] = "/"
      end
      if lp_flicker == 2 then
        lp[4][10] =lp[5][9] = "/"
      end
      lp_border = [".", "o", "*", "°"].choose()
      lp = lp.map { |s| s.gsub "x", lp_border }
      
      # dave
      man_vel = (man_vel+rand_i(30) - 15).min(0).max(30)
      man_typ = (t/100+3)%5
      man_str = ["freestyle", "moonwalk1", "moonwalk2", "breakdance", "headdance"][man_typ]
      man_pos = (man_pos+Math.sin(man_vel/3.0)*2).min(28).max(180) if 0
	  man_pos = (man_pos+1).max(180) if man_typ==1
	  man_pos = (man_pos-1).min(28) if man_typ==2
      #man_typ = (t/10)==0 ? 0 : 1
      #lp = lp.map.with_index { |s,i| i>7 ? s+ " " * man_pos + man[i-8][man_typ] + " "*5 : s }
      #lp = lp.map { |s| s+" "*160 }
	  lp[1][(man_pos-5)..(man_pos-5+man_str.length)] = man_str

      if man_typ < 3 then 
        lp[9][man_pos] = "o"
        lp[10][man_pos] = "O"
        lp[11][man_pos] = "|"
	  end
	  if man_typ==0 then # 0-freestyle
        man_arms = rand_i(6)
        lp[10][man_pos+1] = [" ", " ", "-", "-", "\\", " "][man_arms]
        lp[10][man_pos-1] = [" ", "-", " ", "-", " ",  "/"][man_arms]
        man_feet = rand_i(3)
        lp[11][man_pos-1] = "/" if man_feet == 1
        lp[11][man_pos+1] = "\\" if man_feet == 2
	  elsif man_typ==1 then # moon-walk
        lp[11][man_pos-1] = "/" if t%2==1	    
	  elsif man_typ==2 then # moon-walk
        lp[11][man_pos+1] = "\\" if t%2==1	 
	  elsif man_typ==3 then # moon-walk
	    man_dir = (t%2==1 ? 1 : -1)
        lp[11][man_pos+man_dir] = "o" 
        lp[11][man_pos-man_dir] = "-" 
        lp[11][man_pos-man_dir] = "/" if rand_i(3)==0
        lp[11][man_pos] = "O" 
        lp[11][man_pos+1] = "\\" if t%2==1	 
	  elsif man_typ==4 then # headbreak
	    man_dir = (t%2==1 ? 1 : -1)
        lp[11][man_pos] = "o" 
        lp[10][man_pos] = "O" 
        lp[9][man_pos] = "|"
        man_feet = rand_i(3)
        lp[9][man_pos-1] = "/" if man_feet == 1
        lp[9][man_pos+1] = "\\" if man_feet == 2
	  end
    end
    
    f.write((stars+bar+spa+lp+bar+stars.reverse).join("\n"))
    #f.write(man_vel, "|", man_pos, "|", man_typ)
  }
  sleep 0.15
    stop if final_stop
end


#sleeping = 0
'
pi=0
live_loop :piano do
  if pi !=0 then 4.times do |r| with_fx :gverb, mix: 0.25 do with_synth :piano do
          oct = (r>1 ? 12 : 0)
          print "piano: pi=%d, r=%d, oct=%d" % [pi, r, oct]
          play 50, amp: pi+0.1
          sleep 0.25
          play 55, amp: pi+0.2
          sleep 0.5
          play [57-12*1, 62-12*1, 57, 62], decay: 1.0, amp: pi+0.4
          sleep 1
          play 55+oct, amp: pi+0.2
          sleep 0.5
          play 55+oct, amp: pi+0.2
          sleep 0.25
          play 52+oct, amp: pi+0.2
          sleep 0.5
          play [52+oct, 52, 57], decay: 1.0, amp: pi+0.2
          #sleep 0.25
          #play 55, amp: a+0.2
          sleep 1

          play 55, amp: pi+0.2
          sleep 0.125
          play 57, amp: pi+0.2
          sleep 0.125
          play 62, amp: pi+0.2
          sleep 0.5
          play 57, amp: pi+0.2
          sleep 0.125
          play 55, amp: pi+0.2
          sleep 0.125
          play [57, 62], decay: 1.0, amp: pi+0.4
          sleep 1.0
          if r%2==1  then
            sleep 1.75
            play 55+oct, amp: pi+0.2
            sleep 0.25
            play 57+oct, amp: pi+0.2
            sleep 0.25
            play [62, 62+oct], amp: pi+0.2
            sleep 0.25

          else
            sleep 2
          end

          r += 1

    end end end
  else  sleep 8
end end
'


v=true
intro=true
d=0
a=0
d_dudel=true
d_lulu=true
d_dingel=1
d_sleep=0.125
v_cy1=true
v_cy2=true
v_ba1=false

#v_cy1=v_cy2intro=d_dudel=d_lulu=false; a=d=d_dingel=0; d_sleep=0.125


sample :vinyl_rewind, compress:1, beat_stretch:8 if intro
sleep 8 if intro
live_loop :vinyl do
  sample :vinyl_hiss if v
  sleep sample_duration :vinyl_hiss
  stop if final_stop
end
sleep 4 if intro


# Adrian Cheater / chord invasion


live_loop :d5 do
  print ":d5 d_dingel=%d d_sleep=%d" % [d_dingel, d_sleep]
  if d_dingel == 4
    with_synth :sine do with_fx :echo, mix: 0.125 do with_fx :reverb, mix: 0.125 do
          [1, 3, 6, 4, 3, 4, 3, 6, 1, 6, 4, 3, 1, 3].each do |no|
            (range -3, 3).each do |i|
              play_chord (chord_degree no, :c, :major, 3, invert: i, amp: 0.0025) if d_dingel>0
              sleep d_sleep
              play_chord (chord_degree no, :c, :major, 3, invert: (d_dingel==2 ? i : i.abs()*2), amp: 0.0025) if d_dingel>1
              sleep d_sleep
          end end
    end end end
  else
    [1, 3, 6, 4].each do |d|
      if d_dudel then
        with_synth :mod_tri do
          if tick > 1.5*10 and d == 4 then
            play 43, amp: 2
          elsif
            if tick % 8 == 3 then play 33, amp: 2  end
          end
      end end
      if d_lulu and tick % 4 == (tick / 10)%4 then
        with_synth :dark_ambience do
          with_synth :sine do
            with_fx :reverb do
              # play_chord (chord_degree d, :c, :major, 3, amp: 0.5, attack: 5, sustain: 12, decay: 15)
              play (chord_degree d, :c3, :major, 4, amp: 1), attack: 1, sustain: 1, decay: 1
      end end end end
      (range -3, 3).each do |i|
        play_chord (chord_degree d, :c, :major, 3, invert: i, amp: 0.05) if d_dingel>0
        sleep d_sleep
        play_chord (chord_degree d, :c, :major, 3, invert: (d_dingel==2 ? i : i.abs()*2), amp: 0.025) if d_dingel>1
        sleep d_sleep
      end
end end
  stop if final_stop
  end

sleep sleeping if intro



live_loop :vic do
  #print ":vic v_cy1=%B, v_cy2=%B, v_ba1=%B" % [v_cy1, v_cy2, v_ba1].map { |b| b ? 1 : 0 }
  if v_cy1 then
    sample tick % 4==0 ? :drum_cymbal_open : :drum_cymbal_pedal, pan: 0.25*(tick % 4)
  end
  sleep 0.25
  
  4.times do
    sample :drum_cymbal_closed if v_cy2
    sleep 0.125
  end
  if v_ba1
    with_fx :echo do
      with_fx :reverb do
        play 34
        sample :drum_bass_soft, amp:2
  end end end
  stop if final_stop
end
sleep sleeping if intro
"
droe=true
with_synth :mod_tri do
  live_loop :droen do
    if droe
      [1, 6].each do |d|
        play 39 + d
      end
      #play 42 - 2*(tick%3) + tick%2, amp: (tick % 4)*0.55+1
      sleep 0.5
    end
    sleep 1
  end
end
live_loop :droen do
  play 40 - 2*(tick%3), amp: (tick % 4)*0.125+1
  sleep 1
end
"
#sleep sleeping

def x(a)
  play 50, amp: a+0.1
  sleep 0.25
  play 55, amp: a+0.2
  sleep 0.25
  play 57, amp: a+0.4
  sleep 0.25
  play 62, amp: a+1
  sleep 0.25
end
def x2(a)
  play 62, amp: a+0.1
  sleep 0.50
  play 62, amp: a+0.2
  sleep 0.125
  play 57, amp: a+0.4
  sleep 0.125
  play 55, amp: a+1
  sleep 0.25
end

live_loop :dum do
  print ":dum d=%d a=%d" % [d, a]
  sleep 4
  x(0.125) if d>0
  x2(0.125) if d>1
  if d>2 then
    with_fx :echo do with_fx :flanger do with_fx :reverb do
          play 62, amp: 0.5, attack: 0.25, sustain: 0.25, decay: 0.25
          sleep 0.5
          play 50, amp: 0.5, attack: 0.25, sustain: 0.25, decay: 0.25
          sleep 0.5
          play 57, amp: 0.5, attack: 0.25, sustain: 0.25, decay: 0.25
    end end end
    play 50, amp: 0.5, attack: 0.25, sustain: 0.25, decay: 0.25
    sleep 1
    with_fx :reverb do
      play 48, amp: 0.75, attack: 0.25, sustain: 0.25, decay: 0.25
    end
  end
  stop if final_stop
end

'
sleep sleeping
d=2
sleep sleeping
d=3
'

sleep sleeping
v=false
#sample :misc_cineboom
v_cy1=false
v_cy2=false
v_ba1=false
d=0
"
[1, 3, 6, 4, 3, 4, 3, 6, 1, 6, 4, 3, 1, 3].each do |d|
  with_synth :sine do with_fx :echo do with_fx :reverb do
        (range -3, 3).each do |i|
          play_chord (chord_degree d, :c, :major, 3, invert: i, amp: 0.1)
          sleep 0.25
          play_chord (chord_degree d, :c, :major, 3, invert: i.abs()*2, amp: 0.1)
          sleep 0.25
        end
    end end
end end
"

d_dudel=true
d_lulu=true
#sleep sleeping
d_dingel=2
d_sleep=0.25

sleep sleeping
d_dingel=4
d_sleep=0.25

sleep sleeping
d_dingel=3
sleep sleeping
v_ba1=true
d_dudel=false
d_lulu=false
sleep sleeping
d=0
v=true
d_dudel=true
d_lulu=true
v_cy1=true
v_cy2=true
sleep sleeping
d=3
v_ba1=false
d_dudel=false
d_lulu=false
v_cy1=false
v_cy2=false
sleep sleeping
v=false
sleep sleeping
d_dingel=1
sleep sleeping
d_dingel=0

sleep sleeping
d=0
final_stop = true
