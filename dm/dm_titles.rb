'
dm_titles.rb
L.A. N19 / daniel mueller / 10.07.2021
'
file=$file #'d:/LA-N19/dv.txt'
use_bpm 60
m = $m; s = $s


#https://freetts.com/#ads / Matthew_Male

scenes = {
  "scene-1": "dark matter(s) odessey",
  "scene-2": "prelude",
  "scene1": "the awakening",
  "scene2": "engine room",
  "scene3": "night train",
  "scene4": "harmony swarm",
  "scene5": "pentatiano",
  "scene6": "cheater chord inversion",
  "scene7": "bug is growing",
  "scene8": "hal9k",
  "scene9": "dark void space folding",
  "scene10": "I own U"
}


txt_en = {
  "scene-1": """
a lonely travel of humanity onto dark

sonicpi-lowFi/sciFi-movie by L.A. N19 
""",
  "scene-2": """
the earth is almost destroyed by humanity
and a so-called elite has colonized mars,
because a pale person said: that would be an outstanding idea.

After a while people thought: what are we supposed to do on mars?
It is even more uninhabitable and a so-called elite of the elite made their way 
to the next -hopefully really habitable- exoplanet 'Proxima Centrauri B', 
but this was also not very habitable and therefore the elite of the elite 
is now on the to the exoplanet Teegarden b'.

Why? Because the pale A.I. (the same pale guy just transfered to an A.I.) 
meant that it was a great idea.

But: The pale A.I. just liked the name of the planet.
""",
 
  "scene1": """
Whatever the case, on the several years long journey with the giant spaceship 
C.O.C.K. (Common Odessey Carriage Kollosom),
which lasts so long that newer spaceships are built in the meantime, 
which will overtake the spaceship anyway .... 
something bad happens and the pale A.I. tries to wake-up the passengers.

That's when the story of Dave begins. 
""",
  "scene2": """
Dave has been resuscitated to fix the 
fusion powered space folding engine 
and he immediatly got to work and
hopefully got it fixed.
""",
  "scene3": """
after a hard engineer working day dave is very tired,
but even he's very exosted he could'nt sleep after this hard and long day.
So he count trains as he know them from historic documentation.
""",

  "scene4": """
the space ship is switched to generous autopilot drive mode 
and start dancing around asteroids.

SORRY, ASCII ART IS NOT PROGRAMMED FOR THIS SCENE!!!
""",

"scene5": """ 
meanwhile dave has become boring and lonely and 
he has started to learn electric piano.

Let's see how far he's come.
""",
  "scene6": 
"""
while the journey goes on and on dave found a old lp
from the intpreter L.A. N19 covering adam cheater
with the song cheater chord inversion from the early 21th century.

Let's hear how this old songs sound like.
""",

"scene7":  """
something is happening... with the pale A.I.
something is going weird

Dave should look at the computer
""",
"scene8": """
the bug is raised and it seems like it will take over the space ship
and dave tries to bring himself to safety.
""",
"scene9": """
after dave short-circuit the space folding drive time and space
began to collapse and got shuffle 
""",
"scene10": "I own U"
}

logos = { "scene1": "
°               °      °           .                °     °                °           .             +            *       +
                     ______                                                                                                  
*                   / ___  \                                                                                                                                                          
      *            / /__//  \/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/\//\/\//\\/   
.                 /..:       o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o    o  o  o   
*                 \ ______  _______________________________________________________________________________________________________________________________________________________   
       °           \ \|_|/ /\/\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/\\//\\\//\/   
 .                  \_____/                                                                                                                                                           
    °      .            °             *          °          °                   .     +            .                °      .           .             °        +         .            
 +             °          °                *          *         .  "
}


songs = "dm_Asd.rb
dm01_awakening_v02.rb
dm02_engine_room_v01.rb
dm03_harmony_swarm_v01.rb
dm04_night_train.rb
dm05_pentatiano_v07.rb
dm06_cheater_chord_invasion v6.rb
dm07_bug_is_raisin_v3.rb
dm08_hal9k_v2.rb
dm09_dark_kick.rb
dm10_I_own_U_v05.rb".split("\n").map { |song| song[5..].sub("_v", " v0.").sub(".rb", "").gsub("_", " ").rjust(30, "_") } 

scene = "scene"+s.to_s

# https://patorjk.com/software/taag/#p=testall&f=Graffiti&t=dark%20matter(s) / font: Bigfig


if $m == 1 then
  if s > 0 then
    cov = ("
                             _| _  __ |    __  _ _|__|_ _  __  | _    
    ██          █████       (_|(_| |  |<   |||(_| |_ |_(/_ |    _>              
    ██         ██   ██      
    ██         ███████      
    ██         ██   ██      
    ██████ ██  ██   ██ ██
    _____________________

    ███    ██  ██  █████   
    ████   ██ ███ ██   ██  
    ██ ██  ██  ██  ██████  
    ██  ██ ██  ██      ██  
    ██   ████  ██  █████  
                                                                                                                
                            dark matter's by L.A. N19, (c) 2021-24   
     ").split("\n")
      songs.each_with_index { |song,i| cov[i+3] = cov[i+3].ljust(29, " ") + (i==s ? ">#" : " #")+i.to_s.rjust(3, "0")+(i==s ? "< " : "  ")+song+" "*10 if i > 0 }
      File.open(file+"_album", "w+") { |f| f.write(cov.join("\n")) } # + "\n" + logos[scene.to_sym]) }

      File.open($file_wav_cut_bash_out+"_"+scene+"_cover.txt", "w+") { |f| f.write(cov.join("\n")) } # + "\n" + logos[scene.to_sym]) }
      File.open($file_wav_cut_bash_out, "a+")  { |f|
        wav_filename = "dm_"+(s-1).to_s.rjust(3,"0")
        f.write("\nsox dm.wav ", wav_filename, ".wav trim ", $vt.to_i, " ", (vt-$vt).to_i)
        f.write("\nlame -V3 "+wav_filename+".wav "+wav_filename+".mp3")
        f.write("\nid3v2 -a 'L.A.N19' -A 'dark matters' -t '"+songs[s]+"' -g 'home brew sonic' -T "+s.to_s+" -y 2024 "+wav_filename+".mp3")
      }
      $vt=vt
  end 
else

load $path+"../n19v3.rb" # for inst1: the L.A. N19-Instrument-Algorithm

release=4 # alt: 10
in_thread do
with_fx :normaliser, mix: 0.9, amp: 0.25 do #finally: blow it up to nearly the max (compressor is for softies!!!)
#  with_fx :echo, mix: 0.9, amp: 0.75, phase: 2, decay: 4 do #decay=beat len --> give it a feel of beat repetition
  with_fx :echo, mix: 0.9, amp: 0.75, phase: 2, decay: 1 do #decay=beat len --> give it a feel of beat repetition
    with_fx :gverb, amp: 0.75, tail_level: 1, damp: 0.5, room: 4, release: release, spread: 0.75, dry: 0.29  do
      with_fx :gverb, amp: 0.75, tail_level: 1, damp: 0.5, room: 2, release: release, spread: 0.75, dry: 0.25 do
        with_fx :ixi_techno, phase: 4,  amp: 0.75, res: 0.9 do # let the sound fly around in pan n pitch
          with_fx :slicer, mix: 0.9, amp: 0.75 do #slicer&dice: add rythm due (due 1 echo and 2 gverb its a bit relativated)
            with_fx :bitcrusher, bit: 1, amp: 0.75, sample_rate: 1000 do #yeah, we like it crispy'n'crunchy...
              with_synth :hollow do #hollow: a bit space wobble at the start ;) / kalimba or hollow sounds cool as bel
                #      "znvadsr"   # give the inst1-instrument-definer an array of fm-Modulation each defined by a string with the following values:
                in9 = ["1194555",  #   [Z]aehler/[N]enner (somewhow like fm-synth) and
                       "6529921",  #   0-9 means repräsing 0%-100% for [V]olumne (each multpplied with the give volumne), ADSR (Attacl)
                       "5452991",  #
                       "4352991",  #    XX       XXXX     XXX   XX   XXX   XXX
                       "3245299",  #   XX      XX  XX    XXXX  XX  X XX  XX XX
                       "2144922",  #  XX      XXXXXX    XX XXXXX    XX     XX
                       "3134922",  # XXXX X  XX  XX X  XX   XXX    XX   XXX
                       "4134444"]
                inst1(in9, 50, 0.75, 2.0) # inst, note, vol, length
                #16.times { |i| sleep 0.5*i; play 50-24+i*6, attack: 1.0 / i, amp: 0.5 }
                8.times { |i| sleep 0.25*i; play 50-24+i*6, attack: 1.0 / 2*i, amp: 0.5 }
                inst1(in9, 52, 0.75, 2.0) # inst, note, vol, length
                # 16.times { |i| sleep 0.5*i; play 52-24+(16-i)*6, attack: 1.0 / i, amp: 0.5 }
                8.times { |i| sleep 0.25*i; play 52-24+(16-i)*6, attack: 1.0 / 2*i, amp: 0.5 }
end end end end end end end end
end


tit_sam_name = $path+"/flac_titles/"+scene+".flac" 
print(tit_sam_name)
sce = s>0 ? "chapter %2d: %s" % [s, scenes[scene.to_sym]] : scenes[scene.to_sym]
txt = txt_en[scene.to_sym].split("\n")
print("dbg: title: ", s, scene, sce, txt)
(txt.length+80).times { |i|
    y=i*-1+40
    # 41x190
    stars=(0..40).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," .","° ", "+ "].choose + " "*(8-r)}).join }
    str = [
      [y-1, "-"*sce.length],
      [y, sce],
      [y+1, "-"*sce.length], 
    ]	
	txt.each_with_index { |e,ii| str.append([y+2+ii, e]) }
    str.each { |y2,s2|
      x2 = 190/2 - s2.length / 2-1
      stars[y2] = stars[y2][0..x2]+s2+stars[y2][(190-x2)..190] if y2>=0 and y2<41
    }
    sleep 0.1
    File.open(file, "w+") { |f|
    f.write stars.join("\n")
	}
   sample tit_sam_name, amp: 1 if i==20
   sleep sample_duration(tit_sam_name) if i==20+txt.length
  }
end