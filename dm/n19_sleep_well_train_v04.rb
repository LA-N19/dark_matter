'
  n19_sleep_well_train_v01.rb 

  L.A. N19 / Melody generation and crossing / v0.1 / 29.5.2022

  playing generated melodies and crossed version of them in c major and f minor

  melody 1: there is one melody generated as a "hook" melody and keep steady all the time
  melody 2: seconde melody is new generated 
  melody 3: crossing the melody 1 and 2 to get back to the "hook" 
            using the amp from melody 2 (which have different muted nodes) to even explore more parts of the melody 1 through time

  this is the idea, but i couldnt hear it. it just sounds quite nice to me ;)
  some time the meoldy sucks; its random generated...

  each melody is played in c major and f minor and the chord and a bass is played among

  after adding a simple drum pattern the sounds got a bit muddy and i separated by fade in and out the drum and melody 
  with a 1/8th rythmn with an odd offset (just see usage of fx :slice and mention invertwave)

  at least all got put in a reverb to put it in the same "sound cloud" again


  output the melody-gen log:
  watch -t -n 0,20 "tail -40 /mnt/d/LA_N19/night_train.log"
  watch -t -n 0,20 "tail -40 /mnt/d/LA_N19/night_train.log2"
  watch -n 0,20 "tail -40 /mnt/d/LA_N19/night_train.ascii_gfx"
'

sca = scale(:C, :major)
$FILE="d:/LA_N19/night_train."

File.write($FILE, "L.A.N19\n")
File.write($FILE+"2", "L.A.N19\n")
#n19gen_mut = { |len, | }

def n19_gen(seed: 0, len: 8, num_notes: 5, pMut: 0.6, logout: "mel11")
  #if logout != nil
  #end
  use_random_seed seed
  mel = (0..len).map { rand_i(num_notes) }
  mut = (0..len).map { rand<pMut }
  amp = (0..len).map { |i| (not mut[i]) ? nil : rrand(0.25, 0.7).round(2) }
  amp_str = amp.map { |a| a==nil ? "0" : (a*16).to_i.to_s(16) }
  ret = { "mel" => mel,
          "amp" => amp }
  File.open($FILE, "a") { |f|
    f.write("n19_gen: Generated Melody ", ret["mel"].join, " amp:", amp_str.join, " ", logout, " seed ", seed, ", len ", len, ", num_notes=", num_notes, ", mute propability ", pMut, "\n")
  }
  return ret
end
def n19_genx(arr1, arr2)
  arr = (0..(arr1.length-1)).map { |i| i%2==0 ? arr1[i] : arr2[i] }
  File.open($FILE, "a") { |f|
    f.write("n19_genx crossing Melody ", arr.join, " = ", arr1.join, " x ", arr2.join, "\n")
  }
  return arr
end
def n19_genx2(arr1, arr2)
  return (0..(arr1.length-1)).map { |i| rand_i(2)==0 ? arr1[i] : arr2[i] }
end
def n19_genplay(melody, sca: scale(:C, :major), info: [])
  File.open($FILE, "a") { |f|
    f.write("n19_gen: playing Melody ", melody["mel"].join, " amp:", (melody["amp"].map { |a| a==nil ? "0" : (a*16).to_i.to_s(16) }).join, " in ", sca.to_s[22..-2], "\n" )
  }
  #File.open("d:/LA_N19/n19_exp_sound_gen.log", "a") { |f|
  #  f.puts(melody["mel"].to_s)
  #}
  info[8]=""
  melody["mel"].each_with_index { |v, i|
    amp, n = melody["amp"][i], sca[v]
    not_str=melody["amp"][i] ? note_info(n).to_s.split(" ")[1][1..-2].to_sym : ""
    play sca[v], amp: amp, pan: (i%2==0 ? -1 : 1) * (1.0-i/8.0) if amp != nil
    info[8]+=" "+note_info(n).to_s.split(" ")[1][1..-2]
    '
    File.open($FILE, "a") { |f|
      f.write(" "*(n-58), not_str, " "*(100-not_str.length-n), " (note #", v, " in scale --> ", sca[v], "(", not_str, "), amp: ", amp, ")")      #if amp!=nil
      f.write(" "*100, "\n")
    }
    '
    sleep 0.125
  }
end
use_bpm 30

wagon ="
  ________________________________________________________________________________________  
~|   __   |_|   |_|   |_|   |_|   |_|   |_|    |_|   |_|   |_|   |_|   |_|   |_|   __  ## |~
~|  |  |                                                                          |  |    |~
~|==|==|==L.A.N19==================== === == =the sleep well / night train= == ===|==|== =|~
~|__|__|__________________________________________________________________________|__|____|~
______(*)=^=(*)____________________________________________________________(*)=^=(*) _______
"
lok="
  ____________________________________  
 | #### #  |_|  ####### #     __   |__\\  
 | #####        ###  ####    |  |      \\ 
 |==== === == =      = == ===|==|=====(<  
 |___________________________|__|______/ 
____(*)=^=(*)_____________(*)=^=(*) ____
"
# cows@[5-7],12,18
msgs = "
================== === == =the sleep well / night train= == ===
================== === == =count wagons to fall asleep = == ===
================== === == = there are nintynine wagons = == ===
================== === == =  ...take your time...      = == ===
================== === == =    hey, look: the cows!    = == ===
================== === == =with their annoing cowbells = == ===
================== === == =  ... never mind...         = == ===
================== === == =  they are already gone...  = == ===
================== === == =the sleep well / night train= == ===
================== === == = problems will wait for you = == ===
================== === == =  hoping this melody helps  = == ===
================== === == = quite monotonic, repeating = == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =half way to final destination == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
================== === == =the sleep well / night train= == ===
"

cows=["
         __n__n__ 
  .------`-\\00/-'
 /  ##  ## (oo)     
/ \\## __   ./      
   |//YY \\|/        
   |||   |||         
", "
            ___  
  .--------\\00/  
 /  ##  ## (oo)     
/ \\## __   ./      
   |//YY \\|/        
   |||   |||          
","
 ___            
\\00/-------.   
(oo)  ##  ##\\   
 \\## __    ./\\       
   |//YY \\|/         
   |||   |||            
"]





def draw_gfx(arr, x, y, pic, reverse = false)
  slen, plen = arr[1].length, pic[1].length
  return arr if x + plen <= 0 or x >= slen
  sxs, sxe=x.min(0), (x+plen).max(slen-1) # calculate position in the screen
  return if sxe-sxs==0
  pxs = (x < 0 ? -x : 0)
  pxe = pxs+(sxe-sxs) # calcute cutout...
  pic.each_with_index { |s,i|
    next if s.length ==0
    s=s+" "*10#print "y", y, "i", i, "x", x, "screen [", sxs, sxe, "], pic[",  pxs, pxe, "]", s, pxe-pxs,  sxe - sxs
    arr[y+i][sxs..sxe] = (reverse ? pic[i].reverse[pxs..pxe] : pic[i][pxs..pxe])
  }
  return arr
end

info = ["","L.A.N19 - the sleep well night train v.1", "[gfx_i]", "mel1"]

tree = ["
  #### #####
 ##\\###|#/##
######|#|###/#
###\\##|#/#-##
 #####||####
      ||
      /\\
"]

gfx_i = -20
live_loop :gfx do
  stars=(0..30).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," .","° ", "+ "].choose + " "*(8-r)}).join }
  slen = stars[0].length-1
  weed=(0..10).map { ((0..slen).map { [" ", " ", " ", " ", " ", "`", "´"].choose }).join  }
  arr = stars+weed
  
  #draw_gfx(arr, 600-gfx_i, 32, tree[0].split("\n"))
  
  arr[31][0..(slen)]="_"*slen
  info[2] = "i:%04d" % gfx_i
  draw_gfx(arr, 1, 1, info)
  (0..99).each { |wi|
    wag = (wi==0 ? lok : wagon).split("\n")
    wlen=wag[1].length
    wx = gfx_i-wi*wlen
    if wx>-wlen and wx<slen then
      if wi == 2 or wi == 3 then
        end
        if wi == 5 or wi == 6 then
          draw_gfx(arr, 600-gfx_i, 32, cows[0].split("\n"))
          draw_gfx(arr, 620-gfx_i, 34, cows[1].split("\n"))
          draw_gfx(arr, 650-gfx_i, 33, cows[2].split("\n"))
        end
        if wi>0 then
          wag[2]["##"] = "%02d" % wi
          msg = msgs.split("\n")[wi]
          wag[4][17..(msg.length+16)] = msg
        end
        draw_gfx(arr, wx, 25, wag)
      end
      }
      File.write($FILE+"ascii_gfx", arr.join("\n"), mode: "w")#, "a")
      gfx_i += 1
      sleep 0.05
    end
    
    
    
    with_fx :vowel, mix: 0.2 do
      with_fx :wobble, mix: 0.1 do
        #with_fx :normaliser, slide: 0.1, mix: 1  do |fx_n|
        ctr = synth :pnoise, note: chord(:f, :major), attack_level: 1, attack: 0.5, decay: 4, decay_level: 0.05, sustain: 100, sustain_level: 0.02, slide: 2, pan: 1
        control ctr, note: chord(:c, :minor), pan: 0
    end end #end
    sleep 4
    
    drum_pat =[]
    (32*8).times { |t|
      drum_pat[t]={}
      drum_pat[t][:drum_cymbal_pedal]=(t/4)%4!=0
      drum_pat[t][:drum_cowbell]=((t/32)%8==5)
      drum_pat[t][:drum_heavy_kick]=(t/32)%4==1
      drum_pat[t][:drum_bass_soft]=t%16==10 or t%16==13 or t%16==15
      drum_pat[t][:drum_tom_lo_hard]= t%16==12 or t%16==14
      drum_pat[t][:drum_bass_hard]=t%16==0
      drum_pat[t][:drum_snare_soft]=t%4==2
      drum_pat[t][:drum_snare_hard]=t%16==2
    }
    sleep 4
    with_fx :reverb do#, damp: 0.01, room: 0.999 do
      with_fx :flanger, mix: 0 do #0.75
        with_fx :vowel, mix: 0 do |fx_vowel|
          with_fx :bitcrusher, mix: 0, rate: 123, bits: 1 do |fx_bit|
            
            
            
            
            with_fx :slicer, smooth: 0.1, phase: 0.125, mix: 0.5, pre_mix: 0.5, phase_offset: 0.05, invert_wave: 1 do
              live_loop :dru do
                t=tick(:blub) % (32*8)
                
                drum_pat.each { |v|
                  str=""
                  v.each { |k,v|
                    if v then
                      if k==:drum_cymbal_pedal then
                        # for pedal add some variation: to monotic
                        sample k, amp: rrand(0.25, 0.4), pan: rrand(-1,1), rate: rrand(0.99, 1.01)
                      elsif k==:drum_cowbell then
                        # cowbell it tooo loud!
                        sample k, amp: 0.25
                      else
                        sample k
                      end
                    end
                    str+=v ? "x" : " "
                  }
                  File.write($FILE+"2", " "*120+str+"\n", mode: "a")#, "a")
                  sleep 0.125
                }
                
              end
            end
            with_fx :slicer, smooth: 0.1, phase: 0.125, mix: 0.5, pre_mix: 0.5, phase_offset: 0.05 do
              mel1=n19_gen
              i=1
              live_loop :x do
                print i
                i+=1
                '#if gfx_i > 100 then
                    control fx_bit, mix: 0.5
                    control fx_vowel, mix: 0.5
                    #end'
                # playing melody 1
                mel2=n19_gen seed: i*10, pMut: rrand(0.4, 1.0)
                mel3=mel2.clone
                mel3["mel"]=n19_genx(mel1["mel"], mel2["mel"])
                info[4]="melody 1: "+mel1["mel"].join+" (hook melody)"
                info[5]="melody 2: "+mel2["mel"].join+" (new generated)"
                info[6]="melody 3: "+mel3["mel"].join+" (cross melody: 1x2)"
                
                info[7]="playing melody 1 in c major"
                #note_info(n).to_s.split(" ")[1][1..-2].to_sym
                play chord(:c, :major), pan: -1, amp: 0.5
                with_fx :panslicer, phase: 0.2, smooth: 0.1 do
                  play :c2, amp: 1
                end
                
                n19_genplay(mel1, info: info, info: info)
                
                # playing melody 2 (new generated)
                play chord(:F, :minor), pan: 1, amp: 0.5
                with_fx :panslicer, phase: 0.2, smooth: 0.1 do
                  play :f2, amp: 1
                end
                info[7]="playing melody 1 in f minor"
                n19_genplay(mel1, sca: scale(:F, :minor), info: info)
                #sleep 0.25
                
                info[7]="playing melody 2 in c major"
                play chord(:c, :major), pan: -1, amp: 0.5
                n19_genplay(mel2, info: info)
                
                with_fx :panslicer, phase: 0.2, smooth: 0.1 do
                  play :f2, amp: 1
                end
                play chord(:F, :minor), pan: 1, amp: 0.5
                info[7]="playing melody 2 in f minor"
                n19_genplay(mel2, sca: scale(:F, :minor), info: info)
                
                
                # playing melody 3 (crossed melody 1 and melody 2)
                info[7]="playing melody 3 in c major"
                with_fx :panslicer, phase: 0.2, smooth: 0.1 do
                  play :c2, amp: 1
                end
                play chord(:c, :major), pan: -1, amp: 0.5
                n19_genplay(mel3, info: info)
                
                info[7]="playing melody 3 in f minor"
                play chord(:F, :minor), pan: 1, amp: 0.5
                n19_genplay(mel3, sca: scale(:F, :minor), info: info)
              end
    end end end end end
    