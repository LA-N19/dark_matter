'
  dm1_awakening_v01.rb

  Story:
    stars - stars
    Ship
    room  - Entering the room in the space ship (loop :room)
    dead  - showing mail funtion display of the sleeping boxes (loop :room)
    door  - door of dave sleeping box opens
    walk
    wake
'
#cd /mnt/c/Users/Mulacke/Google\ Drive/Proj/2021_sonic_pi/ambient\ coder/
#watch -n 0,2 'cat space_ship.txt'
#$file=''
$awa_stop = false

def aa_open
  print "opening door "
  sample :mehackit_robot4, rate: 0.2#, pitch: 1
  
  #          1234567890123456
  str_face=[" .||||||||||||. ",
            " | ___    ___ | ",
            "(| [*]    [*] |)",
            " |     /\\     | ",
            " |   ______   | ",
            " |____________| ",
            "      |  |      ",
            "  ____|  |____  ",
            " |            | ",
            " | |        | | ",
            " | | °    ° | | ",
            " | |        | | ",
            " | |        | | ",
            " 'M|        |M' ",
            "   |        |   ",
            "   |________|   ",
            "   | \\    / |   ",
            "   |__\\__/__|   ",
            "   |  |  |  |   ",
            "   |  |  |  |   ",
            "   |  |  |  |   ",
            "   |\\/|  |\\/|   ",
            "   |  |  |  |   ",
            "   |  |  |  |   ",
            ]
  
  (0..40).each { |j|
    lines = (1..(7+15+15)).map { " "*120 }
    #draw horizontal line [y, x, len]
    #win: x=27,y1=8,y2=18, xlen=25, ylen=10
    x = 35; y=10
    str_face.each_with_index { |ss,ii|
      l=lines[ii+y]; lines[ii+y] = l[0..x] + ss + l[(x+25)..119]
    }
    door_i = j
    pos = { box_l: 25,
            box_r: 60,
            door_l: 20.min(25 - (door_i/5)),
            door_r: 20.min(60 - (door_i)),
            win_l: 20.min(25 - (door_i/7)),
            win_r: 20.min(55 - (door_i)),
            }
    #    print door_i, j, pos
    sample :mehackit_phone1, rate: 0.25 if j==35
    
    def drawX(lines,x,y,x2, c)
      l=lines[y]; lines[y]=l[0..x-1]+"+"*(x2-x)+l[(x2)..(120)] if x<x2
      return  lines
    end
    
    # x-seps
    [[pos[:door_l],6,pos[:box_r]],
     [pos[:win_l],8,pos[:win_r]],
     [pos[:win_l],18,pos[:win_r]],
    ].each { |x,y,x2|
      l=lines[y]; lines[y]=l[0..x-1]+"_"*(x2-x)+l[(x2)..(120)] if x<x2
    }
    
    # x-spaces
    ((19..35).map { |y| [pos[:door_l],y,pos[:door_r]] }).each { |x,y,x2| lines = drawX(lines, x,y, x2, "+") }
    ((8..18).map { |y| [pos[:win_r],y,pos[:door_r]] }).each { |x,y,x2| lines = drawX(lines, x,y, x2, "+") }
    lines=drawX(lines, pos[:door_l],7,pos[:door_r], "+")
    
    
    
    
    # y-seps
    [[pos[:box_l],6+1,30],
     [pos[:box_r],6+1,30],
     [pos[:win_l],8+1,10],
     [pos[:win_r],8+1,10],
     [pos[:door_l],6+1,30],
     [pos[:door_r],6+1,30],
    ].each { |x,y,ylen|
      ylen.times.each { |yi| lines[yi+y][x]="|" }
    }
    
    File.open($file, "w+") { |file| file.write(lines.join("  \n")) }
    sleep 0.25#1
  }
  #sleep 12.0*(sample_duration :mehackit_robot4)
  print "door opened"
end


str_nums=[20, 13, 24]
#print ("____________").length; stop
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
# winding progression for room
notes=[[:f3, :a3, :d3],
       [:f3, :a3, :c3],
       [:f3, :a3, :c3],
       [:f3, :g3, :c3],
       [:e3, :g3, :c3],
       [:e3, :g3, :c3+1],
       [:e3, :g3+1, :c3+1],
       [:e3, :a3, :c3+1],
       [:e3, :a3, :d3],
       [:f3, :a3, :d3],
       ]


msg_malfunc = -1
msg_malfunc_num=0
#use_bpm 250
live_loop :x do
  walking_man=false
  sh_len =str_space_ship[0].length
  s12 = lambda { |x2| (x2.times.map { " "*(r=rand_i 10) + ["* "," ."," °", "+ "].choose + " "*(10-r) }).join }
  first = (0..570)
  (0..950).each { |i|
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
    #use_bpm 60 if i == 400
    if msg_malfunc >= 0 then
      msg = ["| START AWAKING |", "| $!&!//)$!%=!= |", "|  MALFUNCTION  |"]
      if msg_malfunc == 10 then
        msg = ["| START AWAKING |", "| START THAWING |", "| RESUSCITATION |"]
        if msg_malfunc_num==2 then
          with_synth :tri do
            8.times { play 70+[0,4,6].choose(), release: 0.1; sleep 0.25 } #0.5/[4,2,8].choose() }
            sleep 0.5
            print "dave"
            err=chord 60, :major
            play err, release: 0.2
            sleep 0.25
            play err.map { |n| n + 12 }, release: 0.2
            sleep 1.25
          end
          sleep 2
        end
      end
      msg = msg.flat_map { |z| [z]*3 } [msg_malfunc_num]
      print "draw malfunc:",i,msg_malfunc, msg_malfunc_num,  x = (msg_malfunc == 10 ? 104 : 118) - msg_malfunc_num
      l=lines[17]; lines[17] = l[0..x] + msg + l[(x+18)..180]
      l=lines[18]; lines[18] = l[0..x] + "|_______________|" + l[(x+18)..180]
      msg_malfunc_num += 1
      if msg_malfunc_num == 9 then
        if msg_malfunc == 10 then
          aa_open; sleep 10
          msg_malfunc=-2
		  walking_man=true
        else
          msg_malfunc=-1
        end
        msg_malfunc_num=0
      end
    end
    if walking_man then
      lines[19][115] = 'o'
      lines[20][115] = 'O'
      lines[21][115] = '|'
      lines[21][116] = '\\' if i%2==0
    end
    if i==str_space_ship[0].length+50 then
      walking_man=false
      with_fx :distortion do
        with_fx :bitcrusher do
          with_fx :krush do
            with_fx :flanger do
              sample :misc_cineboom, compress: 1
      end end end end
      sleep 2
      
      
      # Font Name: Cygnet : /  https://patorjk.com/software/taag/#p=testall&f=Cygnet&t=dark%20matter
      lies = "\n"*20 +([ "  .        .             .  .       ",
                         ".-| .-. .-.|_,  .-.-..-.-|--|-.-,.-.",
                         "`-'-`-`-'  ' `  ' ' '`-`-'- '-`'-'  ",
                         "",
                         "      a L.A. N19 Lo-/SciFi-Movie    ",
                         ].map { |s| " "*75 + s + "\n" }).join + "\n"*20
      File.open($file, 'w+') { |file| file.write(lies) }
      a=1
      with_synth :fm do
        #p = play 50, sustain: 100
        100.times {
          di=124
          de=20
          play 80, attack: 0.05, release: 0.001, amp: a, env_curve: 7, pan: [-1, 0, 1].choose, divisor: di, depth: de
          sleep 0.25
          play 30, attack: 0.2, release: 0.01, amp: a, env_curve: 7, pan: [-1, 0, 1].choose, divisor: di, depth: de
          a=0.min(a-0.025)
        }
      end
  $awa_stop = true
  stop
    end
    
    File.open($file, 'w+') { |file| file.write(lines.join("   \n")) }
    sleep 0.25#1
  }
end



# winding progression for space ship
sh_cho = [:i, :V, :ii].map { |cp| (chord_degree cp, :C2, :major, 3) }
with_fx :gverb, mix: 0.5 do
  with_synth :hollow do
    live_loop :space_ship do
	  stop if $awa_stop == true
      c1=sh_cho[0].map { |n| play n, sustain: 100, attack: 10, amp: 0.25, pan_slide: 1, note_slide: 5, pan: (n+1) % 3 - 1 }
      print ":space_ship: 0 / start sad"; sleep 16
      c2=sh_cho[0].map { |n| play n+12, sustain: 100, attack: 10, amp: 0.25, pan_slide: 1, note_slide: 5, pan: n % 3 - 1 }
      print ":space_ship 1 / speed up"; sleep 8
      sh_cho[1].each_with_index { |n,i| c1[i].control note: n+12, pan: (n+1) % 3 - 1 }
      sleep 8
	  stop if $awa_stop == true
      sh_cho[1].each_with_index { |n,i| c2[i].control note: n, pan: n % 3 - 1 }
      print ":space_ship 2 / slow down"; sleep 8;
      sh_cho[2].each_with_index { |n,i| c1[i].control note: n, pan: (n+1) % 3 - 1 }
      sleep 8
	  stop if $awa_stop == true
      sh_cho[2].each_with_index { |n,i| c2[i].control note: n+12, pan: n % 3 - 1 }
      print ":space_ship 3 / fade out"; sleep 8*2;
	  stop if $awa_stop == true
end end end

live_loop :stars do
  stop if $awa_stop == true
  sleep 8
  with_fx :gverb do
    with_fx :echo do
      [0,1,2].each { |ci|
        print "stars:", ci, sh_cho[ci]
        4.times { |i|
          sh_cho[ci].each { |n|
            play n+(10+rand(i).to_i)*6, amp: 0.125, release: 0.1
            sleep i*0.25 # 0+0.25+0.5+0.75=1.5*4=6
          }
          sleep 2
        }
      }
  end end
  #sleep 8*2
end





sleep 7*8+5
l = notes.length # 10
with_synth :fm do
  room_i=0
  live_loop :room do
    c = (0..2).map { |n| play n, decay: l*4, sustain: l*4, sustain_level: 0.05, attack: 4, note_slide: 0.125, amp: 0.125 }
    l.times { |row|
      n=notes[row]
      print "room: ", room_i," notes[#{row}/#{l}]: ", notes[row]
      (0..2).each { |col|
        #c[(col + row) % 3].control note: n[col]+12
        c[col].control note: n[col]+12;
        sleep 0.5 # --> 1.5
      }
      
      stop if $awa_stop == true
      if room_i == 1 or room_i == 3   then
        msg_malfunc = row
        play 70+row*2, release: 0.1
        sleep 0.5
        print "room: ", room_i, "try_to_wake: ", row
        with_synth :saw do
          err=[43, 44.321, 45.233156, 47.5]
          play err.map { |n| n + 17.33 + row }, release: 0.2
          sleep 0.25
          play err, release: 0.2
        end
        sleep 1.75 # 4 - 1.5 - 0.5 - 0.25
      else
        sleep 2.5
      end
	  
    }
    room_i += 1
  end
end
sleep 10*2*4 # notes.length * 2 runden * 4 ticks
#use_bpm 60
msg_malfunc = 10
while $awa_stop == false 
  sleep 1
end
sleep 30