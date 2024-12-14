'
dm_titles.rb
L.A. N19 / daniel mueller / 10.07.2021
'
file=$file #'d:/LA-N19/dv.txt'
use_bpm 60
m = $m; s = $s


#https://freetts.com/#ads / Matthew_Male

songs = "dm_Asd.rb
dm01_awakening_v02.rb
dm02_engine_room_v01.rb
dm03_harmony_swarm_v01.rb
dm04_night_train.rb
dm05_pentatiano_v07.rb
dm06_cheater_chord_invasion v6.rb
dm07_de4d_mouse.rb
dm08_bug_is_raisin_v3.rb
dm09_hal9k_v2.rb
dm10_dark_kick.rb
dm11_I_own_U_v05.rb".split("\n").map { |song| song[5..].sub("_v", " v0.").sub(".rb", "").gsub("_", " ") } #.rjust(30, "_") }

# https://ttsmaker.com/

scenes = {
  "scene-1": "dark matter(s) odessey",
  "scene-2": "prelude",
  "scene1": "the awakening",
  "scene2": "engine room",
  "scene3": "night train",
  "scene4": "harmony swarm",
  "scene5": "pentatiano",
  "scene6": "cheater chord inversion",
  "scene7": "de4d mouse",
  "scene8": "bug is raising",
  "scene9": "hal9k",
  "scene10": "dark void space kick",
  "scene11": "I own U",
  "scene-3": "credits and making of"
}


txt_en = {
  "scene-3": """
this is a sonic pi project for an lowfi scifi ascii art silent movie called:
  dark matter, respectivily: dark matters

It metaphorize the corona pendamic and the elon musk hype during in the early 2020s
into the early 2120s.

However, just read the following movie chapters descriptions.

Movie and songs are made with sonic pi, thus: Huge thanks to Sam Aaron!!!
(Support him using patreon or github sponsors, see https://sonic-pi.net/)

You can find the 2 years old version v0.1 you can watch at youtube (missing several chapters):
  https://www.youtube.com/watch?v=COeXdAULNlI&feature=youtu.be
or the actual sound track on sound cloud:
  https://soundcloud.com/la_n19/sets/lan19-dark-matters
even the code can be found on git hub:
  https://github.com/LA-N19/dark_matter.git

This movie and its sound tracks are all made by myself nearly only using my old PC,
sonic pi (which is for free; please donate!) and a used Donner dmk25 as midi-instrument.
The refurbished dmk25 for 70€ is used to input some melodies, but is only really
used in realtime in the song #011 I own you.
But it took endless ours to make the sounds you can hear and the movie you can watch.

For the songs there has been programmed the following instruments:
 1. chord knitter: sliding from notes to using several sliding note patterns
    the chord knitter is used in song #004 harmony swarms fixed coded
    the chord knitter can be played using midi (only used with dmk25 for #011 I own you)
 2. integer ratio harmony definition instrument:
    if you know about music theory, perfect harmony is archieved by using frequencies,
    which has an integer denominator and devisor, thus integer ratio in relation to
    the played root note.
    This instrument can define a list of interger denominator and devisor to have
    adding those frequenzies to you played note and gives free defined hormonic hightones.
    Good for cinmenatic & ambient pads, wind instrument, bowed string instruments.
    The instruments can be used to blast the frequency band from low to high.
    Where is ultraharmonic it sounds synthetic and wheirdly a bit cold as it is to
    harmonic and has not much or even no movement.
    This instrument is used here and there to make a basic ambient background fill.
 3. The dark void kick:
   The dark void kick is only used in the song #010, which is all about this kick.
   The kick is programmed starting at a sine wave and simulate a kick as it should be.
   The kick is sometimes only played 'wet' (if you are into sound synthesis: you'll know ;)).

If you get that far: I really appreciate py you've been that interested!
Thanks for watching and listening.
It's not ment to be pleasure, but if it is has been totally weird to you: Great!

Furhter: i know that the songs are some time oversteer until the sound clips.
Sorry for that, but I like it! I also used a normalizer instead of an compressor
and enjoy the really brutal and rough punch and even the clipping, which comes amongs it.
""",
  "scene-1": """
a lonely travel of humanity onto dark

a sonicpi-lowFi/sciFi Silent movie by L.A. N19
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
The space ship is switched to generous autopilot drive mode
and start dancing around asteroids.

SORRY, ASCII ART IS NOT PROGRAMMED FOR THIS SCENE!
""",

"scene5": """
meanwhile dave has become boring and lonely and
he has started to learn electric piano.

Let's see how far he's come.
""",
  "scene6":
"""
While the journey goes on and on dave found a old lp
from the intpreter L.A. N19 covering adam cheater
with the song cheater chord inversion from the early 21th century.

Let's hear how this old songs sound like.
""",

"scene7": """
A mouse, which found and eat some Upper pills.
Those common Upper pills for the usage after decryoninsation.
But the mouse weight's a 23 gram (0.002875% of an human).
It totally cracked up and went berserk!
""",

"scene8":  """
The cable the mouse has bitten, causes an error ... with the pale A.I.
Something is going weird.

Dave will have look at the old computer interface.
""",

"scene9": """
the bug is raised and it seems like it will take over the space ship
and dave tries to bring himself to safety.
""",
"scene10": """
After dave short-circuit the space folding drive,
time and space began to collapse and got shuffled.

SORRY, ASCII ART IS NOT PROGRAMMED FOR THIS SCENE!
""",
"scene11": """
Hence space is folder and thus all is universe and the universe is all,
Dave have to be merged with it's dark matter to get assimillated the universe
to get part of the entirety universe and transcendent omnipresents.

SORRY, ASCII ART IS NOT PROGRAMMED FOR THIS SCENE!
"""
}

logos = { "scene2": "
[o]
|_|
"}


scene = "scene"+s.to_s

# https://patorjk.com/software/taag/#p=testall&f=Graffiti&t=dark%20matter(s) / font: Bigfig

def return_cover(sel, songs2)
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
  songs2.each_with_index { |song,i| cov[i+3] = cov[i+3].ljust(29, " ") + (i==sel ? ">#" : " #")+i.to_s.rjust(3, "0")+(i==sel ? "< " : "  ")+song+" "*10 if i > 0 }
  return cov
end


if $m == 3 then
  File.open($path+"/txt2wav/text2speach.sh", "w+") { |f|
  (-4..11).each { |s|
      scene = "scene"+s.to_s
      title = s>0 ? "chapter %2d: %s" % [s, scenes[scene.to_sym]] : scenes[scene.to_sym]
      f.write("espeak \"", title, "\n\n", txt_en[scene.to_sym], "\" -w ", $wsl_path, "txt2wav/", scene, ".wav\n\n\n")
    }
  }
  stop
end

if $m == 2 then
  File.open(file+"_cover_text", "w+") { |f|
    f.write(return_cover(-100, songs).join("\n"))
    scenes.each { |k,v|
    sep = "\n"+"*"* 100+"\n"
    f.write(sep, "   ", k, " - ", v, sep, txt_en[k.to_sym])
    }
  }
  stop
end

if $m == 1 then

  if s > 1 then
    s1 = s - 1; scene2 = "scene"+s1.to_s

    # output the cover
    File.open(file+"_album", "w+") { |f| f.write(return_cover(s1, songs).join("\n")) } # + "\n" + logos[scene.to_sym]) }

    File.open($file_wav_cut_bash_out, "a+")  { |f|
      songname = "dm"+s1.to_s.rjust(3,"0")+"_"+songs[s1]
      wavname = "'"+songname+".wav'"; mp3name = "'"+songname+".mp3'"
      f.write("\n\n######### "+songname+" #########")
      f.write("\nsox dm.wav ", wavname, " trim ", $vt.to_i, " ", (vt-$vt).to_i)
      f.write("\nlame -V3 "+wavname+" "+mp3name)
      f.write("\nid3v2 -a 'L.A.N19' -A 'dark matters' -t '"+songname+"' -g 'L.A.N19 - sonic home brew studios' -T "+s1.to_s+" -y 2024 "+mp3name)
      f.write("\neyeD3 --add-image 'dm_cov_front.png:FRONT_COVER' "+mp3name)
      f.write("\neyeD3 --add-image 'dm_cov_back.png:BACK_COVER' "+mp3name)
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

tit_sam_name = $path+"/txt2wav/"+scene+".wav"
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
