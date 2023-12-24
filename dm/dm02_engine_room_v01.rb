'
dm2_engine_room_v01.rb
L.A. N19 / daniel mueller / 17.04.2021
'
path=$path # 'C:/Users/Mulacke/Google Drive/Proj/2021_sonic_pi/'
file=$file #'C:/Users/Mulacke/Google Drive/Proj/2021_sonic_pi/dv.txt'
use_debug false
smpl = [:bass_dnb_f , :mehackit_robot7, :perc_snap, :perc_snap2, :tabla_ghe2, :tabla_ghe4, :drum_cymbal_pedal, :drum_tom_mid_hard]
smpl.each { |s| load_sample s }

#stop
sleep 5#
#        0123456789012345     0123456789012345               patternlength: 8*16=128
beat = ["1..............."*3+"11.1............"+"1..............."*3+"11.1............", #0 punch
        "...11.......1.1."*3+"...11..1.1.2...."+"1.1.....1...1.1."*3+"...11..1.1.2....", #1 robot7
        " 111..11..111..."*3+" 111..11.1 1.2.."+"1.1.1.1.1.1.111."*3+" 111..11.1 1.2..", #2 snap1
        "1.1.1.1.1.1.111."*3+"1.1.111 1 1 .2.."+" 111..11..111..."*3+"1.1.111 1 1 .2..", #3 snap2
        "...1......1....."*3+"...1.1.1.1 1.2.."+"1.....1........."*3+"...1.1.1.1 1.2..", #4 ghe2
        "1.....1........."*3+"1.1...111. 1.2.."+"...1......1....."*3+"1.1...111. 1.2..", #5 ghe4
        ("......1...1.1.1." +"......2...2.2.2" +"......3...3.3.3"+" "*16)*2,             #6 3*pedal
        #("......1...1.1.1."*2+"......2...2.2.2"+" "*16)*2,                              #6 3*pedal
        "....1...1...1..."*3+".......        1"+".....1..1....1.."*3+" . . 1        11", #7 tom
        ]
beat=beat.map { |b1| b1.chars.map { |b2| b2.to_i } }
s=0.05

nozzles =[  " ____ ",
            "/     ",
            "> - - ",
            "\\____ ",
            ]
man_idle = [':         :',
            ':.      o.:',
            '      /\\O ']
man_idle = [[':    o    :',
             ':.   O   .:',
             '     |     '],
            [':    o    :',
             ':.  -O   .:',
             '     |     '],
            [':    o    :',
             ':.   O-  .:',
             '     |     '],
            [':   o     :',
             ':. -O    .:',
             '    |\\     '],
            [':     o   :',
             ':.    O- .:',
             '     /|    ']]

#def f_out(file, beat, t)
main_frame = [      ((0..7).map { |ii| " "*128 + " }---(#{ii})---" + (ii==0 ? "." : "|") + "     " }),
                    ((0..15).map { |i| "|..."+i.to_s(16)+"..."}).join+" "*11+"|"         + "     ",
                    ((0..127).map { |i| i%2==0 ? (i%8).to_s : "_"}).join+" "*11          + "-----"
                    ].flatten(1)
beat.each.with_index { |yv, y| yv.each.with_index { |xv, x|
    #    next if xv == nil
    main_frame[y][x] = "+" if xv == 1
    main_frame[y][x] = "-" if xv == 2
    main_frame[y][x] = "*" if xv == 3
} }

sleep 1

with_fx :normaliser            , mix: 0 do |fx_nrm|
  with_fx :ixi_techno          , mix: 0 do |fx_ixi|
    with_fx :gverb             , mix: 0 do |fx_gve|
      with_fx :flanger         , mix: 0 do |fx_fla|
        with_fx :whammy        , mix: 0, transpose: -6  do |fx_wha|
          with_fx :bitcrusher  , mix: 0, bit: 1 do |fx_bit|
            fx_ctr = [fx_ixi, fx_gve, fx_fla, fx_wha, fx_bit, fx_nrm]
            #fx_str = ["fx_ixi", "fx_gve", "fx_fla", "fx_wha", "fx_bit", "fx_nrm"]
            i=0
            fx_num = -1
            
			(16*48).times { |ti|
            #live_loop :beat do
              #ti=tick
              t=(ti) % beat[0].length #128
              print t, ti, " /16:", ti/16 if ti%16==0
              sw_s="0......."
              sw_s="0.....6." if ti > 16*2
              sw_s="0.2.4.6." if ti > 16*4
              sw_s="01234567" if ti > 16*8
              sw_s="0.....6." if ti > 16*24 and ti < 16*32
              fxa = []
              fxa = [[fx_gve, 1]] if ti == 0
              fxa = [[fx_bit, 0.5]] if ti == 16*4
              fxa = [[fx_gve, 0], [fx_ixi, 1]].each { |fx,mix| control fx, mix: mix } if ti == 16*8
              control fx_ixi, phase: 3 if ti == 16*12
              control fx_ixi, phase: 2 if ti == 16*14
              fxa = [[fx_bit, 0], [fx_fla, 1.0], [fx_ixi, 0]].each { |fx,mix| control fx, mix: mix } if ti == 16*16
              fxa = [[fx_wha, 0.2], [fx_fla, 0]].each { |fx,mix| control fx, mix: mix } if ti == 16*20
              fxa = [[fx_wha, 0], [fx_nrm, 1]] if ti == 16*20
              fxa = [[fx_bit, 0.5], [fx_nrm, 0.5]] if ti == 16*24
              fxa = [[fx_bit, 1], [fx_nrm, 0]] if ti == 16*28
              control fx_ixi, phase: 16, cufoff_max: 400 if ti == 16*40
              fxa = [[fx_ixi, 0.25], [fx_gve, 0.25], [fx_nrm, 0.25]] if ti == 16*40
              stop if ti == 16*48 # dann reichts aber auch mal ;)
              fxa.each { |fx,mix| control fx, mix: mix } if fxa.length > 0
              #control fx_ctr.choose, mix: [0.0, 0.25].choose if t%8 == 0
              bebo=sw_s.chars.map { |c| c != "." }
              b=beat.map.with_index { |bi,i| bebo[i] ? bi[t] : 0 }
              
              
              # drawing ascii-art
              li = Marshal.load(Marshal.dump(main_frame))
              (0..7).each { |y| li[y][t] = "|" if bebo[y]  }
              fx_ctr.each.with_index { |fx,i|
                fx_m=(6*fx.args[:mix]).to_i;
                str = "[" + fx.name[12..14] + "|"+ '*'*fx_m + " "*(6-fx_m)  + "]" + "."*(7-i)*2+". "+": "*i + " "
                li[i] += str
                #li += [str]
              }
              #["| * * * * |"].each.with_index { |ll,ii| li[ii+6] += " "*20 + ll  }
              #li += [ " "*20+"| "*6]*3+[ " "*20+"| * * * * |"]
              
              fx_num=-1 if ti%16 == 0
              if fxa.length > 0 then
                fx_ctr.each.with_index { |f,ii| fx_num = ii if fxa[-1][0] == f }
              end
              x = 24
              man =man_idle.choose
              if fx_num >= 0 then
                x = (fx_num > 3 ? 30 : 28) - fx_num*2
                man = [ [':  o      :' , ':.-O     .:', '   |\\      '],
                        [': \\o      :', ':. O     .:', '   |\\      '],
                        [':   \\o    :', ':.   O   .:', '     |\\    '],
                        [':    o/   :' , ':.   O   .:', '    /|     '],
                        [':     o/  :' , ':.    O  .:', '     /|    '],
                        [':      o  :' , ':.     O-.:', '      /|   ']][5-fx_num]
              end
              man = man_sit if ti == 16*48
              man.each.with_index { |mans,mani| li[mani+6] += " "*16 + mans + "  " }
              li[9] += "-"*17 + "<" + sw_s + ">   "
              #li[10] +=  "#{fx_num}, x:#{x}"
              stars=(0..15).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," ."," °", "+ "].choose + " "*(8-r)}).join  }
              sp_edge  = ["-"*(16*10+14)]
              space_ship = sp_edge + [" "*(ti%128)+"|/" + " "*(171-ti%128) + " "] + li + sp_edge
              (nozzles*3).each.with_index { |vv,ii| space_ship[ii] += (ii == 0 ? "." : "|") + vv + " "*(r=rand_i(5))+ [" ", "*",".","°", "+"].choose + " "*(5-r)}
              File.open(file, "w+") { |f| f.write (stars + space_ship + stars.reverse).join("\n") }
			  
              # finally playing samples regarding the pattern
              sample smpl[0] if b[0] != 0
              sample smpl[1], rate: b[1] == 1 ? 0.4 : -0.4 if b[1] != 0
              sample smpl[2], rate: b[2] == 1 ? 2 : -2     if b[2] != 0
              sample smpl[3], rate: b[3] == 1 ? 2 : -2     if b[3] != 0
              sample smpl[4], rate: b[4] == 1 ? 1 : -1     if b[4] != 0
              sample smpl[5], rate: b[5] == 1 ? 1 : -1     if b[5] != 0
              
              sample smpl[6], rate: 5, finish: 0.5 if b[6] != 0
              #s = Math.sin(t/8.0) * 0.01 + 0.06 if ti > 128
              #print s
              sleep s
              sample smpl[6], rate: 5, finish: 0.5 if b[6] == 1 or b[6] == 2
              sleep s
              sample smpl[6], rate: 5, finish: 0.5 if b[6] == 1 or b[6] == 3
              sleep s
              sample smpl[6], rate: 5, finish: 0.5 if b[6] == 2 or b[6] == 3
              
              sleep s
			  
              if ti == 16*48-1 then # dann reichts aber auch mal ;)
			    60.times { |xxx| 
				  stars=(0..15).map { ((0..18).map { " "*(r=rand_i 8) + ["* "," ."," °", "+ "].choose + " "*(8-r)}).join  }
				  space_ship = space_ship.map { |e| e[(xxx/4+1)..-1]+" "*(r=rand_i xxx/4)+["*",".","°", "+"].choose+" "*(xxx/4-r) }
                  File.open(file, "w+") { |f| f.write (stars + space_ship + stars.reverse).join("\n") }
				  sleep 0.1
				}
				break
              end
            }
end end end end end end
sleep 2
