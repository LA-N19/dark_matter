
txt = 'dm10_I_own_U_v05.rb |
-------- -------- -------- -------- -------- -------- -------- 
-------- chap 1 - P - Prolog - Deer in the woods      -------- 
-------- -------- -------- -------- -------- -------- -------- 
Deer in the woods 
 Musik ist 

-------- -------- -------- -------- -------- 
-------- Verse 1-3 - Tension build  -------- 
-------- -------- 37 sec   -------- -------- TODO: zu viele "bridges"
v11 (come out, if you dare   *1  50sc
v12 you know i am their)     *1  64s
               I own U           79s

v21 i see u                  *1
v22 i smell u                *1
               I own U       *2 125s

v31 flee, i am your hunter   *1 140s
v32 run, you are my hunted   *1 154s          /ALT:-> run, you want to hunt
               I own U       *2

  *1 - Bridge: Deer wird langsamer und schaut sich um, Wolf (Beat) wird auch langsamer
  *2 - Bridge: Deer wird hat Angst und wird schneller 

(-------- -------- -------- -------- -------- 
 -------- -------- -------- -------- -------- 
      my heartbeat is a deafening sound
     my saliva stretches to the ground
 -------- -------- -------- -------- -------- 
 -------- -------- -------- -------- --------)

-------- --------  171 sec -------- -------- 
-------- the hunt                   -------- 
-------- --------  190 sec -------- -------- 

-------- -------- -------- -------- -------- 
-------- put done                   -------- 
-------- -------- -------- -------- -------- 


x11 "your breat, i feel the heat"               201s(using https://ttsmaker.com/)
x12 "your teeth, dig into my meat"              206s
               "I own U"                        210s


x21 "you can wriggle, but i ll hold you tight"  215s
x22 "your life fades into the night"            218s

xx00_slowing_down.wav  (transcendentes gedudel into death)

               I own U                          302s

beat slows down till                            306
'
'
escape



jetzt, wo ich meine Zähne in dein Nacken bore,
findet dein Seele ruhe, da Du in deiner Bestimmung aufgehst

nun, da ich esse, merke wie hungrig ich war


wenn dein Blut in meinen rachen läuft
      meine Sinne in der Untergehen

Du weißt es. Und wenn meine Zähne sich in deinen Fleisch bohren, kannst Du es nicht mehr leugnen.
Du gehörst mir. Du bist mein Opfer.
Dann wenn ich dein Blut auf meiner Zunge schmecke. Dein salziger Schweiß in mein  Maul fließt. Dein Geruch in meiner Nase.
Dann wissen wir, dass dein Leben in den meinen aufgeht. Erst jetzt spüre ich den Hunger den ich hatte.

o your fate, you bend:
i am your ultimate end

du spürst den athmen an deinen nacken

your smell diffuses into my brain
testosteron gain
'
sca = scale(:c5, :minor_pentatonic, num_octaves: 2)
sam_path = 'C://Users//Mulacke//Google Drive//Proj//2021_sonic_pi//_dm//dm33//'
sams=['v11_come_dare',   'v12_you_know_i_am_their','I_own_U',
      'v21_i_see_u',     'v22_i_smell_u', 'I_own_U',
      'v31_flee_hunter', 'v32_run_hunted', 'I_own_U',
      'I_own_U', 'x21_tight', 'x22_night', 'I_own_U', ] # flee, i am your hunter / run, you are my hunted
sam_num = 0

$ply="PD123Hb"

final_stop = false
movie_chap, movie_mode, movie_i = 0, 0, 0
live_loop :movie do
  stars=(0..15).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," ."," °", "+ "].choose + " "*(8-r)}).join  }
  File.open($file, "w+") { |f| f.write(stars.join("\n"), "\n chap: ", movie_chap, " movie_mode:", movie_mode, ", movie_i: ", movie_i, '
    Konzept nach den Songphasen: PD123Hb
      chap [P]rolog: Dave schwebt durch den Weltraum 
      chap [D](123): Sterne formieren sich immer wieder und draengen auf Dave zu 
      chap [H]unt:   Sterne jagen dave und bekommen ihne auch
      chap [b]:      Dave "multiplziert" sich und geht in die Sterne auf --> wer wird zu den Sterne/nicht
  ', stars.join("\n")) }
  sleep 0.175
  stop if final_stop 
end

if $ply["P"] then print "P- Prolog - Deer hiding"
  ctrls = (0..4).map { play 0, sustain: 32, slide: 0.25, amp: 0.1 }
  #in_thread do
  
  8.times {
    ctrls.each_with_index { |ctr, idx|
      no = sca.choose - 24
      control ctr, note: no, pan: rrand(-1, 1)
      in_thread do
        sleep 0.125 * idx**1.5
        synth :pluck, note: no + 24, amp: 0.2 if rand_i(2)==0
      end
    }
    sle = [0.25, 0.75, 1.0, 1.25].choose
    sleep sle*2
  }
  print "x"
  32.times { |tim|
    use_bpm 30 + (tim**2)/2
    ctrls.each_with_index { |ctr, idx|
      no = sca.choose - 24
      control ctr, note: no, pan: rrand(-1, 1)
      in_thread do
        sleep 0.125 * idx
        synth :pluck, note: no + 24, amp: 0.2 if rand_i(2)==0
      end
    }
    sle = [0.25, 0.75, 1.0, 1.25].choose
    sleep sle
  }
  use_bpm 60
  ctrls.each { |c| control c, note: 0, slide: 4 }
  sleep 2
end


# fx-chain wolf - start
with_fx :normaliser, mix: 0.5, level: 0.25 do
  with_fx :bitcrusher, mix: 0.2, bits: 3, sample_rate: 8000 do
    with_fx :ping_pong, phase: 0.025, feedback: 0.2 do
      
      live_loop :lyrics_wolf do
        sync :lyrics_wolf
        with_fx :normaliser, mix: 0.5 do with_fx :flanger do
            #with_fx :gverb, tail_level: 1, spread: 0.2, room: 2, mix: 0.01 do
            with_fx  :rlpf do
              # with_fx :bitcrusher, mix: 0.01, bits: 2, sample_rate: 10 do
              print ":lyrics_wolf", (sam = sam_path+sams[sam_num % sams.length()]+'.wav')
              # play sample in diff rate thus tone and crossing the pan left and right
              c1=sample sam, rate: 0.7, pan: -1, slide: 6
              c2=sample sam, rate: 0.8, pan: 1, slide: 6
              control c1, pan: 1
              control c2, pan: -1
        end end end #end
        sam_num += 1
      end
      
      if $ply["D"] then
        
        
        
        #sleep 0.1; cue :lyrics; sleep 6; stop
        3.times do |lo1|
          sleep 0.1; cue :lyrics_wolf if lo1>0
          if $ply["1"] then
            sleep 3
            16.times do |i| print 'dow-dow-loop', i, '/16'   #live_loop :y do
              sample :drum_heavy_kick
              sample :drum_bass_hard
              play :c2
              if i >4 and i<14 then
                in_thread do
                  4.times do
                    play sca.choose, amp: 0.2
                    sleep (i*0.1)**2
                  end
              end end
              sleep (i*0.1)**2
            end
          end
          
          sleep 1
          2.times {
            if $ply["2"] then print "2 - dow-dow-loop"
              6.times { |i|
                cue :lyrics_wolf if i%6==0
                at [0, 0.25, 0.5] do sample :drum_heavy_kick end
                at [0.125, 0.175] do sample :drum_bass_hard end
                at [0.125+0.25, 0.25+0.175] do sample :drum_bass_hard end if (i/2)%2==0
                play :c2
                synth :fm, note: :c2, depth: 2, divisor: 100, cutoff: :c3 # the dow effect
                sleep 0.5
                play sca.choose, amp: 0.2 if rand_i(6)==0
                sample :sn_dub
                sleep 0.25
                play sca.choose, amp: 0.2 if rand_i(6)==0
                sample :sn_dub if i%2==0
                sleep 0.25
                play sca.choose, amp: 0.2 if rand_i(6)==0
            } end
            
            if $ply["3"] then
              # drum-raiser
              with_fx :ping_pong, phase: 0.125 do with_fx :normaliser, mix: 1 do
                  #tim=[0.5, 0.5, 0.5, 0.5, 0.2, 0.2, 0.2, 0.2, 0.15, 0.15, 0.15, 0.15, 0.05, 0.05, 0.05, 0.05, 0.025] #.flat
                  tim=[0.5, 0.4, 0.3, 0.25, 0.2, 0.125, 0.1, 0.075, 0.05, 0.025, 0.01]#, 0.15, 0.15, 0.05, 0.05, 0.05, 0.05, 0.025] #.flat
                  tim.each { |s|
                    sample :drum_heavy_kick, rate: 1, amp: 1
                    sleep s*2
                    sample :sn_dub, amp: 1, rate: 1, pan: -0.5
                    sleep s
                    sample :sn_dub, amp: 1, rate: 1, pan: 0.5
                    sleep s
                  }
              end end
            end
            
            sleep 0.2
          }
          
          if $ply["4"] then
            4.times { |iii|
              # drum-raiser
              with_fx :ping_pong, phase: 0.125, invert_wave: 1 do with_fx :normaliser, mix: 1 do
              end end
              
              
              with_fx :ping_pong, phase: 0.125 do with_fx :normaliser, mix: 1 do
                  #tim=[0.5, 0.5, 0.5, 0.5, 0.2, 0.2, 0.2, 0.2, 0.15, 0.15, 0.15, 0.15, 0.05, 0.05, 0.05, 0.05, 0.025] #.flat
                  tim=[ 0.2, 0.125, 0.1, 0.075, 0.05, 0.025, 0.01]
                  tim=[ [0.2]*4, [0.0125]*4, 0.1, 0.075, [0.1, 0.025] * 8, 0.05, 0.025, 0.01].flatten
                  #tim=[ [0.1, 0.025] * 8].flatten ##, 0.05, 0.025, 0.01]
                  tim.each { |s|
                    print iii, s
                    sample :drum_heavy_kick, rate: 1, amp: 1
                    sleep s*2
                    sample :sn_dub, amp: 1, rate: 1, pan: -0.5
                    sleep s
                    sample :sn_dub, amp: 1, rate: 1, pan: 0.5
                    sleep s
                  }
              end end
            }
            
          end
        end
        
        sleep 1
        play 120
        sleep 1
      end # if $ply["D"] then
end end end # fx-chain wolf - end


if $ply["H"] then
  with_fx :normaliser, mix: 0.25, level: 0.25 do
    with_fx :bitcrusher, mix: 0.2, bits: 3, sample_rate: 8000 do
      with_fx :ping_pong, phase: 0.025, feedback: 0.2 do
        with_fx :bitcrusher, mix: 0.5, bits: 1, sample_rate: 80 do
          with_fx :ping_pong, phase: 0.1 do with_fx :normaliser, mix: 1 do
              6.times { |tt|
                print "tt", tt
                tim=[ 0.1, 0.075, [0.1, 0.025] * 8, 0.05, 0.025, 0.01].flatten
                use_bpm 60 + tt*10
                #tim=[ [0.1, 0.025] * 8].flatten ##, 0.05, 0.025, 0.01]
                tim.each { |s|
                  sample :drum_heavy_kick, rate: 1.2, amp: 1
                  sleep s*2
                  sample :sn_dub, amp: 1, rate: 1.2, pan: -0.5
                  sleep s
                  sample :sn_dub, amp: 1, rate: 1.2, pan: 0.5
                  sleep s
              } }
              with_fx :gverb, spread: 1, release: 4, dry: 0.1 do
                synth :cnoise, amp: 1, release: 0.1, cutoff: 130
                synth :bnoise, amp: 1, release: 0.1
                synth :gnoise, amp: 1, release: 0.1
  end  end end end end end end
end

if $ply["b"] then
  sams_deer=['x11_the_heat',   'x12_my_meat']
  sams_deer_num = 0
  with_fx :panslicer, mix: 0.2 do
    with_fx :slicer, mix: 0.3 do
      with_fx :ping_pong, phase: 0.025, feedback: 0.2 do
        #with_fx :hpf do
        live_loop :lyrics_deer do
          sync :lyrics_deer
          #with_fx :normaliser, mix: 0.5 do with_fx :flanger do
          #with_fx :gverb, tail_level: 1, spread: 0.2, room: 2, mix: 0.01 do
          # with_fx :bitcrusher, mix: 0.01, bits: 2, sample_rate: 10 do
          print "lyrics_deer", (sam = sam_path+sams_deer[sams_deer_num % sams_deer.length()]+'.wav')
          # play sample in diff rate thus tone and crossing the pan left and right
          c1=sample sam, rate: 0.5, pitch: +12.1, pan: -1, slide: 6, compress: 1.0# , slice: 1
          c2=sample sam, rate: 0.55, pitch: +12, pan: 1, slide: 6, compress: 1.0#, slice: 16
          control c1, pan: 1
          control c2, pan: -1
          sams_deer_num += 1
  end end  end end
  
  sam_num = 9
  with_fx :lpf do
    live_loop :beat do
      t1 = tick(:beat)
      t2, t3 = t1 - 120, (t1 < 142 ? 0 : t1 - 142)
      print("beat", t1, t2, t3) if (t1 % 8) == 0
      
      use_bpm 80-t3**1.5
      sample :drum_bass_soft, rate: 0.8, amp: 0.5
      sleep 0.25
      sample :drum_bass_soft, rate: 0.6, amp: 0.2
      sleep 0.75
      cue "/live_loop/lyrics_deer" if t1 == 10  or t1 == 16
      cue "/live_loop/lyrics_wolf" if t1 == 22 or t1 == 28 or t1 == 32 or t3 == 2
      if t3 == 15 then
        use_bpm 60
        play :Bb6, sustain: 10, release: 0
        sleep 12
        play :Bb7, sustain: 0.1, release: 0
        stop
      end
  end end
  
  use_bpm 60
  sleep 24
  sample sam_path+'xx00_slowing_down.wav'
end

sleep 2
final_stop = true