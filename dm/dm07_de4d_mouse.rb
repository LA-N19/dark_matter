' dm27_imu.ita.cas.fEDM.ige.v01.rb
  imu.ita.cas.fEDM.ige stand for "I m unmusical. i try algorithms. computer also sucks. For EDM. its good enough"
  (this is version 0.1 and my computer already nerly collapse due to realtime calculation. donate me a stronger one and i can make new version: you regret it!)
  bass: just one polymetric*1 bass hook (seems to be the only thing, which we need for EDM. DARKMOUZE made it by mistake, or?)
  lead: bullsh*tt*ng around with multi-phase-panning-ping-pong a triangle-wave for head tearing minor/major multi-layer-random-melody (thats what i got, when i asked my computer for melodies...)
  beat: just [bums-ch]^n and it wont get better. but nobody wants more. take the cr*p. oh sorry, there is a hihat (chu*4) and very seldom a chirp(or?)
  fx:   many!!! overlaying effects grinding all of it in into the brian: at least: i like it. 
  conlusion: Keep your expections low and you will still have bloody hears.
  be ready, for a sonic painful experience, which will let you recognize really good music (e.g. classic, alt-j, tool, radio head, DARKSIDE, son lux)

  new scene 1: 
  The story starts with a de4d mouS. It founds a i


0 :drum_bass_hard
1 :drum_bass_soft
2 :drum_cowbell
3 :drum_cymbal_closed
4 :drum_cymbal_hard
5 :drum_cymbal_open
6 :drum_cymbal_pedal
7 :drum_cymbal_soft
8 :drum_heavy_kick
9 :drum_roll
a :drum_snare_hard
b :drum_snare_soft
c :drum_splash_hard
d :drum_splash_soft
e :drum_tom_hi_hard
f :drum_tom_hi_soft
g :drum_tom_lo_hard
h :drum_tom_lo_soft
i :drum_tom_mid_hard
j :drum_tom_mid_soft

 __QQ
(_)_">

   __OQ
 ~/_)_">

     __Qo
  `(\_ _">


  
'
final_stop = false

$sca, $ply, $mel=nil, nil, nil

str_nums=[20, 13, 24]
print ("   ______   "+"           "        *str_nums[0] +"  _"+"____"*str_nums[1]).length;#335 stop
str_space_ship = [
  "   ______   "+"           "        *str_nums[0] +"  _"+"________"*str_nums[1]+"________________"*str_nums[2]+"_"*50+". ___ ",
  "  / ___  \\ "+"           "        *str_nums[0] +"  |"+"        "*str_nums[1]+"                "*str_nums[2]+" "*50+"|/ _ |",
  " / /__//  \\"+'/\//\\\\/\\//\\'    *str_nums[0] +"//|"+"        "*str_nums[1]+"                "*str_nums[2]+"-"*50+"|\\___|",
  "/..:       " +"o  o  o    "        *str_nums[0] +"  |"+" [ ]    "*str_nums[1]+"     _  [_]     "*str_nums[2]+" "*50+"|     ",
  "\\ ______  _"+"___________"        *str_nums[0] +"__|"+"________"*str_nums[1]+"    [o]         "*str_nums[2]+"_"*50+"| ___ ",
  ' \\ \\|_|/ /\\/'+'\\\\//\/\\\//\\' *str_nums[0] +"\\|"+"--------"*str_nums[1]+"    |_|         "*str_nums[2]+"-"*50+"|/ _ |",
  "  \\_____/  "+"           "        *str_nums[0] +"  |"+"________"*str_nums[1]+"________________"*str_nums[2]+"_"*50+"|\\___|",
]

live_loop :x_01a do
  walking_man=false
  sh_len =str_space_ship[0].length
  s12 = lambda { |x2| (x2.times.map { " "*(r=rand_i 10) + ["* "," ."," °", "+ "].choose + " "*(10-r) }).join }
  first = (0..570)
  (400..800).each { |i|
    st_first = i<180
    sh_range = [i<180 ? 0 : (i-180).abs.max(sh_len), sh_len.max(i)]
    sh_len2 = sh_range[1] - sh_range[0]
    st_len = 180-sh_len2
    lines = (16.times.map { s12[15] } )
    lines += str_space_ship.map { |s|
      stars = s12[st_len/12] +" "*(st_len%12)
      ship= s[sh_range[0]..sh_range[1]]
      st_first ? stars + ship : ship + stars
    }
    lines += (16.times.map { s12[15] })
    lines += [[i, st_first, st_len, sh_range].join("/")]
    
    stop if final_stop
    File.open($file, 'w+') { |file| file.write(lines.join("   \n")) }
    sleep 0.25#1
  }
end
print("hallo")



def n19pat_tim_i(div, len=nil) return Array((0..((len==nil ? div : len)-1))).map { |i| i/div.to_f } end                           # 4, 3  --> [0, 0.25, 0.5]
def n19pat_str2arr1(str) return str.chars.map { |c| c == " " ? -1 : c.to_i(32) } end                                              # "03 c" --> [0,3,-1,12]
def n19pat_tim_par(div, str) return n19pat_tim_i(div, len=str.length), n19pat_str2arr1(str) end
def n19pat_tim_stretch(mul, str) return (str.chars.map { |c| c+" "*(mul-1) }).join end                                            # 2, "0 12" -> "0   1 2 "
def n16pat_arr_gen(len, &code) return Array((0..(len-1))).map { |i| code.call(i)==0 ?  -1 : code.call(i) } end                    # n16pat_arr_gen(4) { |i| i%2 } --> [-1, 1, -1, 1]
def n16pat_str_gen(len, &code) return (Array((0..(len-1))).map { |i| code.call(i)==0 ? " " : code.call(i).to_s(36) }).join end    # n16pat_str_gen(4) { |i| i%2 } --> " 1 1"
def n19s2t(s)   a = s.split("/").map { |x| x.to_i }; return n19pat_tim_i(a[1], a[0]) end

# deathmouse polymeter: print s= n19pat_tim_stretch(4, n16pat_str_gen(16) { |i| (((i%8)%3)%2)*(1+i/8) })
sca=scale(:a2, :major_pentatonic)
pats = {         # 0123
                 "k" => "k   "*8 ,
                 "s" => "  s "*8 ,
                 "h" => "h h h h",
                 "b" => "   1     1    a1ba 2     2   1 243",
                 }
sams = { "k" => :drum_heavy_kick, "s" => :sn_dub }
t_bass,p_bass=n19pat_tim_par(8, "  1     1    a1ba 2     2   1 243") # polymeter melody: DO IT LIKE DEATHMOUTH!!!


sleep 1
with_fx :gverb, mix: 0.125, tail_level: 0.1 do
  with_fx :normaliser, mix: 0.2 do # mix: 0.2
    #    with_fx :lpf    do
    $ply = "H" # hblkpH
    #8.times { tick(:str) }
    live_loop :strg do
      sleep 3.9
      $ply = [" b    ",
              " b    H",
              "hb    ",
              " b    H",
              "hbl   ",
              "hbl   ",
              " b ks ",
              " b    ",
              " b ks ",
              "hblks ",
              "hblks H",
              "h lks ",
              "hblks ",
              " b    ",
              " b ks ",
              "   ks ",
              " b ks ",
              " b    ",
              " b    H",
              " b   p",
              "hb   p",
              " b   p",
              ""].tick(:str)
      pats.each { |k,v|
        print look(:str), $ply+"/"+k+": "+v if $ply[k]
      }
      sleep 0.1
      if $ply == "" then
         final_stop = true
         stop
      end
    end
    live_loop :x_01b do
      #with_fx :ixi_techno, phase: 0.125, res: 0.8 do
      #at t_bass.map { |t| t+0.25 }, p_bass do |p| synth :bass_foundation, release: 0.1, note: sca[p] if p!=-1 end if $ply["b"]
      at t_bass, p_bass do |p| synth :bass_foundation, release: 0.1, note: sca[p] if p!=-1 end if $ply["b"]
      #end
      stop if final_stop
      if $ply["l"] then
        with_fx :lpf do #, mix: 0.25 do
          with_fx :bitcrusher, amp: 0.1, mix: 0.25 do
            nots = Array((0..9)).map { sca.choose }
            with_fx :ping_pong, mix: 0.25 do in_thread do
                sleep 2
                synth :tri, note: sca
                sleep 0.25
                nots[0..7].each { |n|
                  #n = sca.choose
                  #synth :blade, sustain: 0.125, release: 0.1, note: n
                  #synth :saw, sustain: 0.125, attack: 0.1, release: 0, note: n+12-6
                  synth :tri, sustain: 0.1, release: 0, note: n+12+6
                  sleep [0.125, 0.25].choose
                }
            end end
            with_fx :ping_pong, phase: 0.2, mix: 0.25, invert: 1 do in_thread do
                sleep 2.25
                nots[0..9].each { |n|
                  synth :tri, sustain: 0.1, release: 0, note: n
                  sleep [0.125, 0.25].choose
                }
            end end
            with_fx :ping_pong, phase: 0.3, mix: 0.25, invert: 1 do in_thread do
                sleep 2.25
                (nots[0..5]+nots[0..5].reverse).each { |n|
                  synth :tri, sustain: 0.1, release: 0, note: n+24+4 # major!!!
                  sleep [0.125, 0.25].choose
                }
            end end
            with_fx :ping_pong, phase: 0.5, mix: 0.25, pan_phase: -1 do in_thread do
                sleep 2.25
                (nots[0..5]+nots[0..5].reverse).each { |n|
                  synth :tri, sustain: 0.1, release: 0, note: n+24+4 # minor!!!
                  sleep [0.125, 0.25].choose
                }
            end end
      end end end
      at n19s2t("8/2").map { |t| t - 0.25 } do sample :sn_dub, amp: 0.15, norm: 1 end if $ply["s"]
      at n19s2t("8/2") do sample :drum_heavy_kick, norm: 1, amp: 1  end if $ply["k"]
      at n19s2t("4/4") do sample :drum_cymbal_pedal, amp: 0.05 end if $ply["h"]
      at n19s2t("4/32").map { |t| t+0.75 }  do sample :elec_tick, amp: 0.015, rate: -10, pan: rrand(-1, 1) end if $ply["H"]
      at n19s2t("16/32").map { |t| t+1 }  do sample :elec_tick, amp: 0.015, rate: -10, pan: rrand(-1, 1) end if $ply["H"]
      if $ply["p"] then
        with_synth  :kalimba do
          at n19s2t("10/15") do |t| play sca.choose+24, amp: 0.2, attack: 0.01+t/2.0, release: 0.025, sustain: 0 if rand_i(2)==0 end
          at n19s2t("4/6") do |t| play sca.choose+24, amp: 0.1, attack: 0.01+t/2.0, release: 0.025, sustain: 0 if rand_i(2)==0 end
        end
      end
      #with_fx :flanger, vowel_sound: 5, voice: 4, mix: 0.4 do
      at [3.25] do
        c=synth :supersaw, attack: 0.75, release: 0.25, amp: 0.05, slide: 1, env_curve: 7, note: sca.choose - 24
        control c, note: sca.choose + 12
      end# end
      sleep 4
end end end
sleep 4
while not final_stop do
  sleep 4
end
sleep 4