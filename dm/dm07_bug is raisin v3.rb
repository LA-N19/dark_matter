##
#
#      (/
#
# interpret: L.A.N19
# album:     ambient coder
# song:      bug is raisin v3
#
# http://sonic-pi.mehackit.org/exercises/en/09-keys-chords-and-scales/01-piano.html

# wet/dry hands/sweden/0x10
# living mice
# c418 / mine craft
# sam smith/lukas graham/tyler joseph/lil jon/passenger/john legend/wanz/fall out boy/kodaline/beardyman
# CYMATICS: Science Vs. Music - Nigel Stanford
#use_sample_bpm :loop_compus, num_beats: 2

"
live_loop :loopr do
  sample :loop_compus, rate: [0.5, 1, 1, 1, 1, 2].choose unless one_in(10)
  sleep 4
end
"

#use_random_seed 3
use_bpm 40
use_debug false
pl_amp = 0.0# [0.0,0.25,0.5].choose;
$co1_amp = 0.0
co2_amp = 0.0
d1=false
d2=false
d3=false
d4=false
bass=false
dro=0.01
final_stop=false

live_loop :pic do
  t=tick
  File.open($file, "w+") { |f|
    stars=(0..15).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," ."," °", "+ "].choose + " "*(8-r)}).join  }
    bars=["-"*188]
    room="""      
      
      
      
      
      
  <[]_
   || """
    room = room.split("\n").map { |s| s+" "*170 }
    manpos=(30-t).min(8)
    room[5][manpos]="o"
    room[6][manpos]="O"
    room[6][manpos-1]="/" if manpos == 8
    room[7][manpos]="|"
    room[7][manpos-1]="/" if manpos > 10 and (manpos%3)==0
    
    pic = stars+bars+room+bars+stars.reverse
    
    if t > 30 then
      bugs = [
        [" .. ",  ],
        ["\\o/ ", ],
        ["-O- ",  ],
        ["/ \\ ", ],
      ]
      b = [" "*54, "-"*54]+(0..12).map { "||"+" "*50+"||"}+[ "-"*54, " "*54]
      t.times {
        y=rand_i(13)+2
        x=rand_i(48)+2
        b[y][x] = rrand_i(32,117).chr
      }
      
      a = [
        "  ["+"^1234567890ß´".chars.join("][")     +"][<-] [p][e]  ",
        "  [->]["+"qwertzuiopü+".chars.join("][")   +"][ | | |[^]  ",
        "  [v  ]["+"asdfghjklöä#".chars.join("][")   +"]_| | |[v]  ",
        "  [^ ]["+"<yxcvbnm,.-".chars.join("][") +"][    ] [^]     ",
        "  [str][alt][             ][alt][str]      [<][v][>]      ",
      ]
      c=b+a+[" "*50]*20
      pic=pic.map.with_index { |s,i|
        if i>10 and i<c.length-10 then
          s[0..60]+" "+c[i-10]+" "+s[115..180]
        else
          s
        end
      }
    end
    f.write(pic.join("\n"))
  }
  
  stop if final_stop
  sleep 0.1
end


live_loop :dro do
  with_synth :sine do
    s_dro= sample :ambi_drone if dro != 0
    8.times do
      control s_dro, amp: dro if dro != 0
      sleep (sample_duration :ambi_drone)/8
  stop if final_stop
end end end

live_loop :D1 do
  s = [0.125, 0.125, 0.25].choose
  [1, 2, 3, 4].choose.times do
    sample :tabla_re, amp: 0.5 if d1
    sleep s
  end
  stop if final_stop
end
live_loop :D2 do
  s = [0.25, 0.5, 1.0].choose
  [1, 2, 3].choose.times do
    sample :drum_cymbal_closed, amp: 0.25 if d2
    sleep s
  end
  stop if final_stop
end
with_fx :reverb do
  live_loop :D3 do
    s = [0.25, 0.5, 1.0].choose
    [1, 2].choose.times do
      play :d2, amp: 1 if d3
      sleep s
    end
  stop if final_stop
  end
end
live_loop :D4 do
  sleep 1
  [1, 2].choose.times do
    sample :mehackit_robot7, amp: co2_amp if d4
    sleep 0.5
  end
  stop if final_stop
end



def co(note)
  play chord(note, :minor).choose, cutoff: rrand(40, 100), amp: $co1_amp, attack: 0, release: rrand(0.5, 1), cutoff_max: 110
end

e_loop = 0
with_synth :tb303 do with_fx :distortion, mix: 0.25 do |fx_d| with_fx :reverb do with_fx(:echo, delay: 0.25, decay: 2) do |fx_e|
        live_loop :echoes do
          e_loop += 1
          print e_loop, pl_amp
          s = play :c2, release: 2, amp: co2_amp, note_slide: 1
          #play chord([:b1, :b2, :e1, :e2, :b3, :e3].choose, :minor).choose, cutoff: rrand(40, 100), amp: 0.5, attack: 0, release: rrand(1, 2), cutoff_max: 110
          #sleep [0.25, 0.5, 0.5, 0.5, 1, 1].choose
          if tick % 3 == 0 then co(:c2); sleep 0.25
          else co(:c2); sleep 0.125; co(:c2); sleep 0.125 end
          co(:c2); sleep 0.125
          control s, note: :c2
          co(:a2); sleep 0.125
          co(:c2); sleep 0.25
          co(:d2); sleep 0.25
          control s, note: :d2
          # 1 sec
          
          #pl_amp = [0.0,0.25,0.5].choose;
          if pl_amp != 0 and e_loop % 4 == 0 then
            control s, note: :e3
            a =                      [[:e3, 0.25], [:e3, 0.25], [:c3, 0.125], [:d3, 0.125], [:c4, 0.25], [:a4, 0.25], [:e3, 0.25], [:d3, 0.25],]
            if e_loop % 6==0 then a= [[:e3, 0.25], [:e3, 0.25], [:c3, 0.125], [:d3, 0.125], [:c3, 0.25], [:a3, 0.25], [:c3, 0.25], [:d3, 0.25],] end
            a.each do |p|
              play p[0], amp: pl_amp, attack: 0, release: rrand(0.25, 0.75) #, cutoff: rrand(40, 100), cutoff_max: 110
              sleep p[1]
            end
            control s, note: :d3
            sleep 0.25
            pl_amp = 0
          end
		  
          stop if final_stop
        end
end end end end


live_loop :bass do
  if bass then
    sample :bass_voxy_c, amp: rrand(0.1, 0.2), rate: [0.5, 0.5, 1, 1,2,4].choose if one_in(4)
    use_synth :mod_pulse
    use_synth_defaults mod_invert_wave: 1
    play [:C1, :c2].choose(), mod_range: 12, amp: rrand(0.5, 1), mod_phase: [0.25, 0.5, 1].choose, release: 1, cutoff: rrand(50, 90)
    play [:d2, :d3].choose(), mod_range: [24, 36, 34].choose, amp: 0.35, mod_phase: 0.25, release: 2, cutoff: 60, pulse_width: rand
  end
  sleep 1
  stop if final_stop
end

d4=true
25.times do dro += 0.01; sleep 0.125; end
dro_bkg=dro
16.times do |i|
  dro=dro_bkg + 0.5-0.01*(i-8)**2
  print "ambi drone parable bounce to max amp:", dro
  sleep 0.125
end
10.times do dro -= 0.01; sleep 0.125; end
80.times do |i|
  co2_amp += 0.01
  sleep 0.25
end
co2_amp = 0
bass=true
d4=false
d1=true
sleep 4
d2=true
sleep 4
sample :ambi_haunted_hum
d3=true
sleep 8
bass=false #d1=d2=d3=false
sleep 4

10.times do |i|
  $co1_amp = 2*(i+1)*0.0125
  sleep 0.2
end
sleep 4
pl_amp = 0.5
sleep 4
$col_amp=0.125
d1=d2=d3=true
sleep 4
bass=d1=d2=d3=false
pl_amp=0.125
co2_amp=0.125
$co1_amp=0
sleep 4
pl_amp=co2_amp=0
$co1_amp=0.125


sleep 4
$co1_amp=0.025
d2=d3=d4=true

use_bpm 20
bi=0
with_fx :distortion do
  with_synth :flanger do
    with_synth :mod_tri do
      with_fx :compressor do
        ri1 = ring(:e1, :e1, :c1, :d1, :c1, :a1, :c1, :d1)
        #ri2 = ring(:e3, :e3, :c3, :d3, :c4, :a4, :e3, :d3)
        ri2 = ring(:e2, :e2, :c2, :d2, :c2, :a2, :c2, :d2)
        live_loop :hov do
          bi+=1
          l=bi/8
          
          sl = ring(0.25, 0.25, 0.125, 0.125, 0.25, 0.25, 0.25, 0.25).tick
          no = l<5 ? ri1.tick : ri2.tick
          a = 0
          a += l%4 == 2 ? (bi%4/2)*12 : 0 # ever 3.beat shift the 2. half by an octave
          a += (l/3)%2 ? 12 : 0
          print "flamod: ", bi, l, a
          play no + a, release: sl*1.5
          #play no + (i%3)*3, release: sl*1.5
          #play no + (i%8)*3, release: sl*1.5
          play no.to_i * 2.0, release: sl*1.5, amp: 0.1 if l in [2, 4 ,7]
          sleep sl
          stop if l==8
end end end end end
d1=d2=d3=false; d4=true
sleep 4
$co1_amp=0.125
bass=true
sleep 4
$co1_amp=0
bass=false
co2_amp =0.125
sleep 4
d1=d2=d3=d4=false; co2_amp =0; pl_amp = 0.0
15.times do
  dro -= 0.01
  sleep 0.125
end
dro =0
sample :ambi_swoosh, amp: 1
final_stop=true
"
use_sample_bpm :loop_amen
with_fx :rlpf, cutoff: 10, cutoff_slide: 4 do |c|
  live_loop :dnb do
    sample :bass_dnb_f, amp: 5
    sample :loop_amen, amp: 5
    sleep 1
    control c, cutoff: rrand(40, 120), cutoff_slide: rrand(1, 4)
  end
end
"

"
live_loop :hov do
  #use_synth :mod_tri
  use_synth :mod_pulse
  play_pattern [:e3, :e3, :c3, :d3, :c3, :a3, :c3, :d3], [0.25, 0.25, 0.125, 0.125, 0.25, 0.25, 0.25, 0.25]
end
"

#sleep 10
#use_bpm 55
#pl_amp = 0# [0.0,0.25,0.5].choose;
#co1_amp = 0
#co2_amp = 0
#sleep 14
#$co_amp = 0.5
#sleep 16
#$co_amp = 0.5


"

use_sample_bpm :loop_compus, num_beats: 4

live_loop :loopr do
  sample :loop_compus, rate: [0.5, 1, 1, 1, 1, 2].choose unless one_in(10)
  sleep 4
end

live_loop :bass do
  sample :bass_voxy_c, amp: rrand(0.1, 0.2), rate: [0.5, 0.5, 1, 1,2,4].choose if one_in(4)
  use_synth :mod_pulse
  use_synth_defaults mod_invert_wave: 1
  play :C1, mod_range: 12, amp: rrand(0.5, 1), mod_phase: [0.25, 0.5, 1].choose, release: 1, cutoff: rrand(50, 90)
  play :C2, mod_range: [24, 36, 34].choose, amp: 0.35, mod_phase: 0.25, release: 2, cutoff: 60, pulse_width: rand
  sleep 1
  #  stop
end





basari = :bd_klub
virveli = :sn_dolf
haitsu = :perc_snap
haitsu2 = :drum_cymbal_pedal

with_fx :distortion, mix: 0.08 do
  with_fx :nrhpf, mix: 0.05 do

    live_loop :drumloop do
      at [1, 2, 4] do
        sample basari, amp: rrand(1, 1.5), rate: rrand(0.95, 1.05)
      end
      at [2.5, 6.5] do
        sample virveli, amp: rrand(0.6, 1), rate: rrand(0.95, 1.05)
        sleep 0.1
        with_fx :gverb, amp: 0.6, mix: 1, spread: 1, delay: 10 do
          sample virveli, amp: rrand(0.3, 0.5), rate: rrand(0.95, 1.05)
        end
      end
      at [0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5] do
        with_fx :flanger, mix: 0.5, depth: 40, delay: 20, decay: 5, feedback: rrand(0.1, 1.0) do
          sample haitsu, amp: rrand(0.3, 0.5), rate: rrand(2.1, 2.2), pan: rrand(-0.25, 0.25)
          if one_in(10)
            sleep 0.5
            sample haitsu2, amp: rrand(0.6, 0.9), rate: rrand(1.1, 1.2), pan: rrand(-0.25, 0.25)
          end
        end
      end
      sleep 8
    end
end end

"