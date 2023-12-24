
# dm03_harmony_swarm_v01.rb
# Bach Prelude from Cello Suite in G
# L.A. N19 - instrument: chord-transition-noteknotter v01
# sliding apparently random chord-notes from one to the next chord, even if the same chord is played
# the instrument does play a arrangment of harmonic notes to a given note and than blending from one
# note to another note in the following chord.
#
#    chord:     minor7
#    blending:  linear alternating (1. note of the 1. chord slide to the )
#    attack:    1/16 Attack, no declay and no sustain, and release is smothed gradually
#    synth:     fm (sonic pi default settings)
#    fx:        ping-pong-panning, normaliser, bitcrusher
#
# this example the played minor7-chords in the following 8 4/4-beats:
#    0:b3, 1:b3, 2:e3, 4-1/16: (e3), 4:e4, 5:e4, 6:b3,
#
# https://chordchord.com/
# https://splice.com/sounds/beatmaker

use_debug false
path="C:/Users/Mulacke/Google Drive/Proj/2021_sonic_pi/"
load path+"__LA_N19_v01.rb"
pl_stop=false

x=100; y=20;
live_loop :pic do
  stars=(0..40).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," ."," °", "+ "].choose + " "*(8-r)}).join  }
  s="<]=====[#######]<:"
  x=(x+rand_i(3)-1).min(0).max(160)
  y=(y+rand_i(3)-1).min(1).max(40)
  stars[y][x..(x+s.length)]=s
  File.open($file, "w+") { |f| f.write(stars.join("\n")) }
  sleep 0.15  
  stop if pl_stop
end


def play_fpat1(aPat, aSynset, aPatset)
  a = aPat.scan(/(\d)([^\d]*)/)
  a.each_with_index do |x, i|
    no =  aPatset[:notes][x[0].chars[0].to_i]
    l = (1 + x[1].length)# * 0.025
    play no, aSynset, decay: x[1].count("d")*aPatset[:sleep]
    sleep aPatset[:sleep] * l
  end
end

def play_fpat2(aPat, aSynset, aPatset)
  a = aPat.scan(/(\d)([^\d]*)/)
  n = aPatset[:notes]
  '
  ctrl = n[aPat[0].to_i].map { |x|
    play x, amp: 0, sustain: aPat.length * 0.125, note_slide: 0.125, amp_slide: 0.125
  }'
  ctrl = []
  n[aPat[0].to_i].each_with_index { |nn, ii|
    ctrl[ii] = play nn, amp: 0, sustain: aPat.length * 0.125, note_slide: 0.125, amp_slide: 0.125
    #sleep 0.5
  }
  print "play_fpat2/aPat: " + aPat
  print "play_fpat2/aSynset: " + aSynset.to_s
  print "play_fpat2/aPatset: " + aPatset.to_s
  
  a.each_with_index do |x, i|
    no =  n[x[0].chars[0].to_i]
    l = (1 + x[1].length)# * 0.025
    no2 = no #default
    #no2 = no.map { |ii, v| no[(i + ii) % no.length] } if aPatset[:slidemode] == 0 # shift-knitter
    no2 = no.take(no.length + i ).drop(i) if aPatset[:slidemode] == 0 # shift-knitter
    no2 = no.reverse  if i % 2 == 0 and aPatset[:slidemode] == 1 # cross-knitter
    no2 = no.shuffle if aPatset[:slidemode] == 2 # random-knitter
    print "patpart(%d): %s, \t note: " % [i, x], no, " --> ", no2
    a = aSynset[:amp]
    ctrl.each_with_index { |ct, ii| control ct, note: no2[ii], amp: a }
    l.times { |i2| sleep 0.125
      a = 0.min(a - (((i2 % 2) * 3 - 1) * 0.075))
      ctrl.each { |ct| control ct, amp: a }
    }
  end
end

intro = true
pl_prophet=pl_saw_synth=pl_saw=pl_saw2=pl_knits=0

if intro then
  print "t_inst9 - Instrument 'in9' - wide sprectral instrument for space hollow"
  with_fx :gverb do
    with_synth :hollow do
      #     znvadsr
      in9 = ["1194555",
             "6529921",
             "5452991",
             "4352991",
             "3245299",
             "2144922",
             "3134922",
             "4134444"]
      inst1(in9, 50, 0.125, 20.0)
    end
  end
  sleep 16
end


#notset = :b2


with_fx :normaliser, amp: 0.2  do
  #with_fx :ping_pong, phase: 0.25 do
  with_synth :fm do
    i=0
    live_loop :mi7chords do
      synset = { amp: pl_knits, loop_name: "mi7chords" }
      patset = { sleep: 0.125, slidemode: 0 } # i %  4 }
      notset = [:b3, :e3, :e4].map { |c| chord(i/2 % 2 == 0 ? c : c-12, i % 2 == 0 ? :minor7 : :minor)  }
      #notset = [60, 64, 68].map { |n| ring [2/3.0, 0.75, 1.0, 1.25, 4/3.0].map { |f| Math.sqrt(f*(n.to_f/12.0)**2)*12.0 } }
      
      
      i+=1
      
      sleep 0.001 # sonic pi erkennt das sleep nicht in fpat3...
      # chords: 8*2+2 -> 12
      #            0 . u . 1 . u . 2 . u . 3 . u . 4
      if pl_knits>0 then
        fpat3(("0.......0.......1..............1"+
               "2.......2.......0.............01")*2+
              "0.....010......01............121"+
              "2....1212.....210...............", synset, patset, notset)
      else
        sleep 16
      end
	  stop if pl_stop
    end
end end

#pl_prophet = 1
with_synth :prophet do
  live_loop :prophet do
    print no44 = { notes: chord(:b2, :minor7), sleep: 0.125 }
    mel =
      (".01 23 34 3dd  21..  0  . 0..111"+
       "2ddd2..   .2ddd2 ...  2ddd2...01")*2+
      " 01.01  0......01............121"+
      "2....1212.....210..............."
    if pl_prophet>0 then
      #            0 . u . 1 . u . 2 . u . 3 . u . 4
      fpat1(mel,
            { amp: 0.75, attack: 0.01, release: 0.5 },
            no44)
    else
      sleep mel.length * 0.125
    end
	  stop if pl_stop

  end
end



with_fx :krush do
  with_synth :prophet do
    with_fx :slicer, mix: 0.5, phase: 0.125 do |sl|
      live_loop :l_saw do      if pl_saw>0 then
        n = [:b3, :e3, :e4]
        env = "43210".chars.map { |n| n.to_i * 0.1 }
        #     c = play n[0]+12, amp: 0.5, release: 1, sustain: 2, pan: 0, pan_slide: 2, note_slide: 2, attack: 1, amp_slide: 1
        #    control c, pan: -1
        #   control sl,
        #  env.each {|m| control sl, mix: m }
        [ [[n[0]+12, n[1]], [-1, 1]],
          [[n[1]+12, n[0]], [-1, 1]],
          [nil, nil],[nil, nil],
          [[n[0]+12, n[1]], [1, 1]],
        [[n[1], n[0]+12], [-1, -1]]].each { |note_pair, pan_pair|
          if note_pair == nil then
            sleep 4
            next
          end
          c = play note_pair[0], amp: 0.5, release: 1, sustain: 2.5, pan: 0, pan_slide: 2, note_slide: 2, attack: 1, amp_slide: 1
          control c, pan: pan_pair[0]
          sleep 1
          control c, amp: 0.125
          env.each { |e| control sl, mix: e;  sleep 1/5.0; }
          sleep 8
          control c, note: note_pair[1], pan: pan_pair[1], amp: 0.5
          sleep 1;
          control c, amp: 0.125
          env.reverse.each { |e| control sl, mix: e;  sleep 1/5.0; }
        }
        else
          sleep 16
        end
        stop if pl_stop
end end end end


sleep 16 if intro

with_fx :echo, decay: 0.05, mix: 0 do
  with_fx :reverb do
    with_synth :dsaw do
      n = [:b2, :e2, :e2].choose() -12
      live_loop :x do
        sleep 1
        2.times {
          #play :b1, attack: 0.2, amp: 0.25, release: 0
          #sample :perc_impact1, rate: 0.25#, pitch: -50, finish: 0.5
          play n, attack: 0.02, amp: 0.25, release: 0
          sleep 0.1
          play n, attack: 0.02, amp: 0.25, release: 0
          sleep 0.1
          play n, attack: 0.02, amp: 0.25, release: 0
          sleep 0.2
        }
			  stop if pl_stop

        #     print "hallo"
        '
      with_synth_defaults attack: 0, release: 0, decay: 0.01, amp: 0.1 do
        2.times do play_pattern_timed [:b5, :b5], [0.1] end
      end
'
      end
end end end
sleep 16 if intro

live_loop :bum do
  #with_fx :lpf, mix: 0.25 do #, mix: 0.05 do
  with_fx :bitcrusher, bits: 16, mix: 0.25 do
    with_fx :reverb do
      with_synth :fm do
        2.times { |o| n = o == 0 ? :b1 : :e1
          2.times {
            3.times { |i|
              play n, attack: 0.01, amp: 1, release: 0.05+i*0.1, divisor: 3+i*0.5
              #sleep 0.1
            }
            sleep 0.5
          }
          2.times {
            #play :b1, attack: 0.2, amp: 0.25, release: 0
            #sample :perc_impact1, rate: 0.25#, pitch: -50, finish: 0.5
            play n+12, attack: 0.02, amp: 0.5, release: 0
            sleep 0.1
            play n+12, attack: 0.02, amp: 0.5, release: 0
            sleep 0.2
          }
          sleep 0.2
          play [:b6, :e8].choose, attack: 0.01, amp: 0.0125, release: 0.025
          sleep 0.2
          play [:b6, :e8].choose, attack: 0.01, amp: 0.025, release: 0.025
          #          play n = o == 0 ? :e8 : :b6, attack: 0.01, amp: 0.025, release: 0.025
          #         sleep 0.2
          #        play n = o == 0 ? :b6 : :e8 , attack: 0.01, amp: 0.05, release: 0.025
        }
			  stop if pl_stop

end end end end#end


with_fx :krush do
  with_synth :prophet do
    live_loop :prophet do
      if pl_prophet>0 then
        n = [:b3, :e3, :e4]
        c = play n[0]+12, amp: pl_prophet, release: 1, sustain: 4*2, pan: 0, pan_slide: 2, note_slide: 2, attack: 2, amp_slide: 1
        control c, pan: -1
        sleep 1; control c, amp: 0.125; sleep 1
        control c, pan: 1, note: n[1], amp: pl_prophet
        sleep 1; control c, amp: 0.125; sleep 1
        control c, pan: -1, note: n[2], amp: pl_prophet
        sleep 1; control c, amp: 0.125; sleep 1
        control c, pan: 1, note: n[0], amp: pl_prophet
        sleep 1; control c, amp: 0.125; sleep 1
      else sleep 4
      end
	  	  stop if pl_stop

end end end

#pl_saw_synth=1
pset = { notes: [:b4, :e4, :e4].map { |c| chord(c, :minor7) }, sleep: 0.125 }
with_fx :echo, mix: 0.125 do with_fx :panslicer, phase: 0.125, mix: 0.25 do with_fx :reverb do with_fx :gverb, mix: 0.125 do with_synth :saw do
          #          2.times do
          live_loop :l2 do
            #            0 . u . 1 . u . 2 . u . 3 . u . 4
            mel =
              (".0..01..01..1 1 1..............1"+
               "2...2 .21   1 1 0..............."
               )*2+
              "11 01 01 01 1 1 1...1...1.1.1111"+
              "    2 12 12 10 10...0...0.0.0000"
            if pl_saw_synth>0 then
              fpat1(mel,
                    { amp: 0.25, attack: 0.05, release: 0.1 },
                    pset)
            else
              sleep mel.length*0.125
            end
				  stop if pl_stop

end end end end end end
#pl_saw_synth=1; sleep 64

live_loop :debug do
  print "[pl_knits, pl_prophet, pl_saw, pl_saw2, pl_saw_synth]: ", [pl_knits, pl_prophet, pl_saw, pl_saw2, pl_saw_synth]
  sleep 4
  	  stop if pl_stop

end

pl_knits=1
sleep 16-1
pl_knits=1
sleep 16; pl_knits=0.75; sleep 16; pl_knits=0.5;
pl_saw=1
sleep 32
pl_saw=0
pl_saw2=0.25
sleep 16-1
pl_saw_synth=1
pl_saw2=0
pl_knits=1
sleep 16
pl_saw_synth=0
sleep 16
pl_knits=0
sleep 16
pl_stop=true
sleep 4
'
#live_loop :l do
with_synth :fm do
  c = play [:b2, :b2+3], attack: 1, sustain: 5, release: 5, divisor: 3, node_slide: 6
  sleep 6
  control c, note: [:e2+3, :e2, ]
  sleep 6
end #end
####################################################################################
####################################################################################
####################################################################################
use_debug false


#i1 = Inst1.new([:b2, :e2, :e3].map { |c| chord(c, :minor) }, method(:pl1))
#i1.play_fpat1("0.......0.......1..............12......2.......0...............")

use_bpm 40

use_synth :tb303
use_bpm 45
use_random_seed 3
use_debug false


with_fx :reverb do
  with_fx(:echo, delay: 0.5, decay: 4) do
    live_loop :echoes do
      play chord([:b1, :b2, :e1, :e2, :b3, :e3].choose, :minor).choose, cutoff: rrand(40, 100), amp: 0.5, attack: 0, release: rrand(1, 2), cutoff_max: 110
      sleep [0.25, 0.5, 0.5, 0.5, 1, 1].choose
    end
  end
end



use_bpm 90

live_loop :intro do

  # harmonisation de i-iV-V-i-N-V7-i en do mineur
  use_synth :piano
  x = rrand_i(1, 10)

  force = rand(0.25..0.4)
  fade = rand(1..2)
  vel = rand(0.25..0.4)

  if x > 3
    play [:C2, :Ef3,:C4] ,decay: 2 ,hard: force # i
    sleep 2
  else
    play [:Af2, :Ef3, :Af3,:C4] ,vel: vel, decay: fade ,hard: force#VI substitution
    sleep 2
  end
  play [:F2, :F3, :Af3,:C4] ,vel: vel, decay: fade ,hard: force# iv
  sleep 2
  play [:G2, :D3, :G3,:B3] ,vel: vel, decay: fade ,hard: force# V
  sleep 2
  if x > 5
    play [:C3, :Ef3, :G3,:C4] ,vel: vel/2, decay:fade ,hard: force # i
    sleep 2
  else
    play [:C3, :Ef3, :Af3,:C4] ,vel: vel/2, decay:fade ,hard: force # VI substitution
    sleep 2
  end
  play [:F2, :F3, :Af3,:Df4] ,vel: vel, decay: fade # N sixte napolitaine
  sleep 2
  if x > 4
    play [:G2, :F3, :B3,:D4] ,vel: vel, decay: fade # V7
    sleep 2
  else
    play [:Af2, :F3, :B3,:Df4] ,vel: vel, decay: fade # Substitution par Triton Db7
    sleep 2
  end
  play [:C2, :G3,:C4] ,vel: vel, decay: 4 # i
  sleep 4


end

'