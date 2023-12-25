
# ac03_hal9k_v2.rb
# http://www.fromtexttospeech.com/ "US" slow george Hal9k: "Sorry, i can't do that, dave"
# http://www.fromtexttospeech.com/ "uk medium harry Dave:  "Do you read me.
use_debug false


final_stop=false


#sample :mehackit_phone1
#sample :mehackit_phone2
o2001samples = "D:\\LA-N19\\dark_matter\\dm\\flac_hal9k\\"
o2001dave_open_please = o2001samples+"dave_open_please.flac"
o2001dave_do_u_read_me = o2001samples+"dave_do_u_read_me.flac"
o2001hal_i_read_u = o2001samples+"hal9k1_read_u.flac"
#sample o2001dave_do_u_read_me;stop;
o2001hal_sorry_dave = o2001samples+"hal9k2_sorry_dave.flac"
o2001hal_jeopardize = o2001samples+"hal9k3_jeopardize.flac"
#dave = "C:\\Users\\Mulacke\\Google Drive\\Proj\\2021_sonic_pi\\ambient coder\\flac\\dave_do_u_read_me.flac"

"
Dave Bowman : Hello, HAL. Do you read me, HAL?
HAL : Affirmative, Dave. I read you.
Dave Bowman : Open the pod bay doors, HAL.
HAL : I'm sorry, Dave. I'm afraid I can't do that.
Dave Bowman : What's the problem?
HAL : I think you know what the problem is just as well as I do.
Dave Bowman : What are you talking about, HAL?
HAL : This mission is too important for me to allow you to jeopardize it.
Dave Bowman : I don't know what you're talking about, HAL.
HAL : I know that you and Frank were planning to disconnect me, and I'm afraid that's something I cannot allow to happen.
Dave Bowman : [feigning ignorance]  Where the hell did you get that idea, HAL?
HAL : Dave, although you took very thorough precautions in the pod against my hearing you, I could see your lips move.
Dave Bowman : Alright, HAL. I'll go in through the emergency airlock.
HAL : Without your space helmet, Dave? You're going to find that rather difficult.
Dave Bowman : HAL, I won't argue with you anymore! Open the doors!
HAL : Dave, this conversation can serve no purpose anymore. Goodbye.
"
def amp_slider val, slide
  return [0.0, [0.5, val+slide].min].max
end

'
basari = :bd_klub
virveli = :sn_dolf
haitsu = :perc_snap
haitsu2 = :drum_cymbal_pedal
'

final_stop=false
live_loop :pic do
  stop if final_stop
  t=tick
  stars=(0..15).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," ."," °", "+ "].choose + " "*(8-r)}).join  }
  bar=["-"*190]
  
  # 120, 300
  step_getdown, step_eyewalk, step_manwalk = 120, 230, 300
  
  ship=(0..9).map { " "*2190 }
  ship[8][2010..1013]= "<[]_"
  ship[9][2010..1013]= " || "
  sx=2000
  sx=2000-t+step_eyewalk if t>step_eyewalk
  
  mx=2015-(t-step_manwalk).min(0)
  mm=t>step_manwalk ? 1 : 0
  ship[7][mx]="o"
  ship[8][mx]="O"
  ship[8][mx-1]="/" if mm == 0
  ship[9][mx-1]="/" if mm == 1 and t%2==0
  ship[9][mx]="|"
  
  er =  t>step_eyewalk # eye is running
  ex, ey, ed = 2100-(t-step_eyewalk).min(0), 0, rand_i(4) # eye x, y, direction
  ed = [3, ed].choose if er
  if t>step_getdown then
    ey=((t-step_getdown)/2).max(7)
  end
  ev = (ey != 7 ?  ["  (O) ","  (o) ","   '<)"," (>'  "] : ["  (O) ","  (o) ","   .<)"," (>.  "])[ed]
  
  
  ship[ey][ex..(ex+5)]=ev
  if ey >0 and ey<7 then
    ey.times { |ii| ship[ii][ex+3]="|" }
  end
  
  #man=
  if ey==7 then
    ship[8][ex..(ex+6)]=" __|__ "
    ship[9][ex..(ex+6)]="(O°o°O)"
    if er then
      (rand_i 4).times { ii=rand_i 7; ship[8][ex+ii]="   |   "[ii] }
      (rand_i 4).times { ii=rand_i 7; ship[9][ex+ii]=" 0'.'0 "[ii] }
    end
  end
  ship=ship.map { |v| v[sx..(sx+190)] }
  File.open($file, "w+") { |f|
    f.write((stars+bar+ship+bar+stars.reverse).join("\n")+"\n"+t.to_s)
  }
  stop if t==1550
  sleep 0.15
end


i16=0
tra_amp=0.025
tra_amp_s=0.005
walk_amp=0.75
walk_amp_s=0
def intro
  2.times do |subi|
    sleep 2
    sample subi==0 ? :mehackit_phone2 : :mehackit_phone3, amp: 0.125+subi*0.125
    sleep 4
    2.times do |subii|
      sample :glitch_robot1, amp: 0.125+(subi+subii)*0.25
      sleep 2
      sample [subi, subii].min==1 ? :mehackit_robot3 : :glitch_robot2, amp: 0.125+(subi+subii)*0.25
      sleep 4
    end
    sample subi==0 ? :mehackit_phone4 : :mehackit_robot4, amp: 0.25+subi*0.75 #:mehackit_phone1
    sleep 4
  end
end
"
live_loop :elec do
  sync 3;
  8.times do
    sample :loop_electric
    sleep sample_duration :loop_electric
  end
end
"
bss=false
live_loop :bss do
  if bss then with_fx :distortion, mix: 0.5, amp: 0.95 do with_fx :panslicer, smooth_up: 0.1, smooth_down: 0.1 do
        sample :bass_dnb_f, pitch: rrand(-0.25, 0.25), finish: 0.6
  end end end
  sleep 2
  stop if final_stop
end


i=0
live_loop :robot_control do
  intro if i==0
  i+=1
  i16=i % 16
  print "i=%d i16=%d" % [i, i16]
  #i=((i& ? i : 0)+1) % 16
  tri_amp=(i<64 ? 0.5 - rrand(0, 0.25) : 0)
  tra_amp_s=(i==16) ? -0.025 : 0.0125
  walk_amp = i<30 ? 0.75 : amp_slider(walk_amp, -0.0125).min(0.05)
  if i==48 or i==64 or i==72 then
    walk_amp = 0
    tra_amp = 0
    tra_amp_s = 0
  end
  if i==76 then
  final_stop=true
  stop
  end
  #cue 3 if i>48 and i<60
  if i==64 then
    with_fx :krush, mix:0.125 do
      sample o2001dave_open_please, amp: 1; sleep (sample_duration o2001dave_open_please)+0.5
    end
    with_fx :bpf, mix:0.5, pre_amp: 1.5, amp: 1 do
      sample o2001hal_jeopardize, rate: 0.8, pitch: 1.2, amp: 1
      sleep (sample_duration o2001hal_jeopardize)+0.5
    end
    
    walk_amp = 0.75
    bss=true
    
    n = 1.5
    #at [2.5, 4.5, 2.5] do
    with_fx :panslicer, mix: 1, wave: 1 do with_fx :reverb, mix: 0.6, room: 0.2, amp: 2 do
        8.times do
          sample :bass_dnb_f, rate: n, finish: 0.1
          n -= 0.15
          sleep 0.25
        end
    end end
    cue 3
  elsif i==48 then
    with_fx :krush, mix:0.125 do
      sample o2001dave_open_please, amp: 1; sleep (sample_duration o2001dave_open_please)+0.5
      sample o2001dave_do_u_read_me, amp: 1;  sleep (sample_duration o2001dave_do_u_read_me)+0.25
      8.times do |di1|
        (di1/2).times do
          with_fx :flanger do
            with_synth :echo do
              sample o2001dave_do_u_read_me, rate: rrand(0.9, 1+2*di1/8.0), pitch: rrand(0, 2*di1/8.0)
              print di1, (8*8-di1**2)/8.0**2
              sleep (sample_duration o2001dave_do_u_read_me) * rrand(0.5, 0.75) * [(8*8-di1**2)/8.0**2, 1].min
        end end end
      end
      sleep 0.5
      with_fx :gverb do
        sample o2001dave_do_u_read_me, amp: 1
        sleep (sample_duration o2001dave_do_u_read_me) + 1.5
      end
    end
    with_fx :bpf, mix:0.5, pre_amp: 1.5, amp: 1 do
      sample o2001hal_i_read_u, rate: 0.8, pitch: 1.2, amp: 1
      sleep (sample_duration o2001hal_i_read_u)+1.5
    end
    with_fx :krush, mix:0.125 do
      sample o2001dave_open_please
      sleep (sample_duration o2001dave_open_please)+0.65
      with_fx :echo do
        sample o2001dave_open_please, amp: 1
        sleep (sample_duration o2001dave_open_please)+0.25
      end
    end
    with_fx :bpf, mix:0.5, pre_amp: 1.5, amp: 1 do
      sample o2001hal_sorry_dave, rate: 0.8, pitch: 1.2, amp: 1
      sleep (sample_duration o2001hal_sorry_dave)+1.5
    end
    walk_amp = 0.75
    tra_amp = 0.75
    cue 3
  end
  cue 1
  cue 2 if i>32
  sleep 2
  "if i==16 then
      sample :misc_cineboom
      sleep sample_duration :misc_cineboom
    end"
end

live_loop :tra do
  use_synth :sine
  tra=sample :bass_trance_c, amp: tra_amp, amp_slide: 1
  8.times do
    sleep (sample_duration :bass_trance_c) / 8.0
    control tra, amp: tra_amp=amp_slider(tra_amp, tra_amp_s)#[0.0, [0.5, tra_amp+tra_amp_s].min].max
  end
end

live_loop :robot_twang do
  sync 2
  4.times do
    sample i16>4 ? :elec_twang : :elec_soft_kick
    sleep 0.25
  end
  if i16>8 then
    sample :elec_blip, amp: 1
    sleep 0.25
    sample i%2==0 ? :elec_beep : :elec_blip2, amp: 1
    sleep 0.25
  end
end


live_loop :robot_walk do
  sync 1
  use_sample_defaults amp: walk_amp
  sample :bass_drop_c, amp: 1 if i16 ==15
  sample :bass_dnb_f if i16 > 10
  sample :glitch_bass_g if i16>8 and i16 < 15
  sample :drum_roll  if i16==6
  sample :glitch_perc1 if i16==1
  sample :glitch_perc2 if i16==2
  sample :glitch_perc3 if i16==3
  sample :glitch_perc4 if i16==4
  sample :glitch_perc5 if i16==5
  sample :mehackit_robot7 #unless one_in(i)
  sleep 0.5
  sample :mehackit_robot7 #unless one_in(i)
  sample :elec_twip
  sample :glitch_perc3
  sleep 0.125
  sample :mehackit_robot7 #unless one_in(i)
  sleep 0.375
  sample :mehackit_robot7 #unless one_in(i)
  sample :glitch_perc2
  sleep 0.075
  sample :mehackit_robot7 #unless one_in(i)
  sample :elec_twip if i>13
  sample :glitch_perc3
  sample :glitch_robot2
  sleep 0.075
  #sample :mehackit_robot7
  sample :elec_blup
end

while not final_stop do
  sleep 1
end
