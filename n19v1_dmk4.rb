'
 n19v4_dmk.rb / 18.5.2021

   XX       XXXX     XXX   XX   XXX   XXX     L.A. n19 - home brew sonic engineering (6.5.2021 / Daniel Müller)
  XX      XX  XX    XXXX  XX  X XX  XX XX     proudly presents: home brewed instruments midi-connected 
 XX      XXXXXX    XX XXXXX    XX     XX       a) chord knitter in all flavours 
XXXX X  XX  XX X  XX   XXX    XX   XXX         b) metal pain instruments (trying to get the most afrequency-
                                               c) frequenz-ratio-ADSR-Encoded defined instruments


#lead synth:   0.00|nor:0.99|sli:0.64/0.28|bit:0.83/ 1/ 14465
#ear crusher:  0.92|nor:0.33|sli:0.99/0.44|bit:0.99/ 1/ 10497    geht auch gut mit saw
#ambientes:    0.66|nor:0.99|sli:0.00/0.44|bit:0.07/ 1/    20   geht auch gut mit saw oder fm

 03.11.2021 : using n19v2.rb: $n19midi_dmk25 for midi-strings

Pimoroni Mini.Mu Glove-Kit
'
use_debug false

nc_cfg= {
  :att => { note: -24, sustain: 1000, pan: -1, pan_slide: 0.5, amp_slide: 0.5, amp: 0 },
  :att_all => { note: +2 },
  :sus =>  { amp_slide: 0.1, note_slide: 0.1 },
  :dec =>  { amp_slide: 0.1, note_slide: 0.1 },
  :rel =>  {},
}
path = "C:/Users/Mulacke/Google Drive/Proj/2021_sonic_pi/"
load path+"n19v2.rb"
midi_out_file = path+'rec'#+Time.now.strftime('%Y%m%d_%H%M%S')

'
print kn19syn([44,65,23], ord: "rand")
stop'
b_piano = 3
b_metro = 0 # 1--> 4/4
b_knit = [8, 5, 2]
b_knit_def =  [nil, nil, nil]
b_sort = 1
b_ver = 0
b_write_midi_file = 2
midi2text_piano_roll(midi_out_file+".log", head: 1) if b_write_midi_file > 0
$nk19_record = (b_write_midi_file == 2 ? 1 : 0)
rec_mod = []

live_loop :metro do play (tick%4==0 ? 80 : 78), release: 0.01 if b_metro > 0; sleep 1; end


with_real_time do
  s = [0,1]
  live_loop :p do
    b_knit_def[0] = N19_CFG[:nk_ord][b_knit[0]]
    #b_knit_def[0] = ["0..9", "rand", nil, "ii=0", "ma01", "ma02", "ma03", "ma04", "ma05", "m06"][b_knit[0]]
    b_knit_def[1] = N19_CFG[:nk_pan_amp][b_knit[1]]
    b_knit_def[2] = N19_CFG[:nk_pan_amp][b_knit[2]]
    rec_mod.push [vt, b_knit_def.dup] if s[1] > 0
    print "Node knitting mode:", b_knit, b_knit_def
    s = sync $n19midi_dmk25[:pad][0]
    if s[1] > 0 then
      b_knit = [0, 0, 2] if s[0]==$n19midi_dmk25[:pad][1][0]  #p1 - boring...
      b_knit = [3, 3, 3] if s[0]==$n19midi_dmk25[:pad][1][1]  #p2 - sheppard
      b_knit = [7, 3, 2] if s[0]==$n19midi_dmk25[:pad][1][2]  #p3 - mash  1
      b_knit = [8, 5, 2] if s[0]==$n19midi_dmk25[:pad][1][3]  #p4 - mash 2
      
      b_knit[0] = (b_knit[0] + 1)%N19_CFG[:nk_ord].length if s[0]==$n19midi_dmk25[:pad][1][4]      #p5 change ord-knitting
      b_knit[1] = (b_knit[1] + 1)%N19_CFG[:nk_pan_amp].length if s[0]==$n19midi_dmk25[:pad][1][5]  #p6 change pan-knitting
      b_knit[2] = (b_knit[2] + 1)%N19_CFG[:nk_ord].length if s[0]==$n19midi_dmk25[:pad][1][6]      #p7 change amp-knitting
      b_piano = (b_piano + 1)%4 if s[0]==$n19midi_dmk25[:pad][1][7]                                #p8 piano
    end
end end


$s1 = 0.0
p3cue = [] #conrols for the piano #3
#use_bpm 100

p3 = {}
p3i = 0
kn = nil
notes = []
vt_last_add_node = 10000.0
vt_start = vt
sleep 1

with_fx :normaliser, mix: 0 do |fx_n|
  with_fx :gverb, release: 2, room: 2, ref_level: 0.1, damp: 0.125, mix: 0.125, amp: 0.75, tail_level: 0.1, mix: 0 do
    #with_fx :ring_mod do
    #with_synth :dsaw do
    with_synth :sine do
      with_fx :bitcrusher, bits: 10, sample_rate: 13009, mix: 0 do |fx_b|
        with_fx :slicer, phase: 1.0, smooth: 0.01, mix: 0 do |fx_s|
          use_synth_defaults depth: 0.5, division: 5
          
          '

        with_real_time do live_loop :pitch do
        $pitch = (sync "/midi:usb_midi_interface_0:4/pitch_bend")[0].to_f / 8192.0 -1.0
        control fk_n, mix: 0.min($pitch*-1.0) if $pitch < 0
    end end
 ' 
          with_real_time do
            live_loop :s1 do
              co = sync $n19midi_dmk25[:slider][0][0]
              $s1 = co[1].to_f / 128.0 if co[0] == 7
            end
            live_loop :s2 do
              co = sync $n19midi_dmk25[:slider][0][1]        # [s2]
              control fx_s, phase: 0.01.min(1.0 - co[1] / 128.0) if co[0] == 7
            end
            live_loop :s3 do
              co = sync $n19midi_dmk25[:slider][0][2]        # [s3]
              control fx_b, sample_rate: 1+co[1]  if co[0] == 7
            end
            live_loop :s4 do
              co = sync $n19midi_dmk25[:slider][0][3]        # [s4]
              print "hallo", co
              control fx_b, sample_rate: 1+co[1] * 128 if co[0] == 7
            end
            live_loop :k do
              #$pitch = (sync "/midi:usb_midi_interface_0:4/pitch_bend")[0].to_f / 8192.0 -1.0
              #control fk_n, mix: 0.min($pitch*-1.0) if $pitch < 0
              co = sync $n19midi_dmk25[:knob][:midi]
              control fx_n, mix: 0.min(co[1] / 128.0) if co[0] == $n19midi_dmk25[:knob][:knob][1][0] # [1]->notes, [0]->knop #1
              control fx_s, mix: 0.min(co[1] / 128.0) if co[0] == $n19midi_dmk25[:knob][:knob][1][1] # [1]->notes, [1]->knop #2
              control fx_b, mix: 0.min(co[1] / 128.0) if co[0] == $n19midi_dmk25[:knob][:knob][1][2] # [1]->notes, [2]->knop #3
              control fx_b, bits: 1.min(co[1] / 6).to_i if co[0] == $n19midi_dmk25[:knob][:knob][1][3] # [1]->notes, [3]->knop #4
              #control fx_b, bits: 1.min(co[1] / 6).to_i if co[0] == $n19midi_dmk25[:knob][][3] # [1]->notes, [3]->knop #4
              #control fx_b, sample_rate: 1+co[1] * 128.0 if co[0] == $n19midi_dmk25[:knob][1][4] # [1]->notes, [4]->mod-slider
              if co[0] == $n19midi_dmk25[:knob][:stop] then
                File.open(midi_out_file+".txt", "w") { |f| f.write $nk19_recs }
                w = (($nk19_recs[-1][:vt]*20.0).ceil)
                svg='<svg width="'+w.to_s+'" height="1000" xmlns="http://www.w3.org/2000/svg"><g><title>L.A. N19 - Note Knitter</title>'
                cols = ["firebrick", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflowerblue", "darkorchid", "crimson"]
                g_lines  = (0..4).map { |o| [1,3,6,8,10].map { |n| h=(o*12+n)*3; '<line x1="%d" y1="%d" x2="%d" y2="%d" style="stroke:lightgrey;stroke-width:2"/>' % [0,h,w,h]  } }
                str_mode = []
                pre_r = nil
                rects = []
                offset = 5*12*3
                $nk19_recs.each.with_index { |r,i|
                  x1=(r[:vt]*20).to_i
                  #str_mode.push('<text x="" y="10" fill="red" text-anchor="start" transform="translate('+x1.to_s+',) rotate(90)">'+r[:knit].to_s+'</text>')
                  r[:syn].each.with_index { |a,i|
                    io = i/10.0 #offset for this note to prevent overlaying lines
                    #rects.push("<!--"+k.to_s+" / " +a.to_s+"-->")
                    ny1=(a[:note]-24)*3+io
                    py1=a[:pan]*4.0+io+offset+20#.to_i
                    col=cols[i%cols.length]
                    if pre_r != nil then if pre_r[:syn][i] != nil then
                      # note
                      x2=(pre_r[:vt]*20).to_i.to_s
                      ny2=((pre_r[:syn][i][:note]-24)*3+io)
                      rects.push('<line x1="'+x1.to_s+'" y1="'+ny1.to_s+'" x2="'+x2.to_s+'" y2="'+ny2.to_s+'" stroke="'+col+'"/>')
                      
                      # panning
                      py2=(pre_r[:syn][i][:pan]*4.0+io+offset+20)
                      rects.push('<line x1="'+x1.to_s+'" y1="'+py1.to_s+'" x2="'+x2.to_s+'" y2="'+py2.to_s+'" stroke="'+col+'"/>')
                    end end
                  }
                  pre_r=r
                }
                svg += "\n"+g_lines.join("\n")+rects.join("\n") +str_mode.join("\n")
                rec_mod.each { |vti, knit|
                  svg += '<text fill="black" text-anchor="start" transform="translate('+(vti*20).to_s+',4) rotate(0)" font-size="0.2em">ord:'+knit[0].to_s+'</text>\n'
                  svg += '<text fill="black" text-anchor="start" transform="translate('+(vti*20).to_s+',8) rotate(0)" font-size="0.2em">pan:'+knit[1].to_s+'</text>\n'
                  svg += '<text fill="black" text-anchor="start" transform="translate('+(vti*20).to_s+',12) rotate(0)" font-size="0.2em">amp:'+knit[2].to_s+'</text>\n'
                }
                svg += "\n</g></svg>"
                
                
                File.open(midi_out_file+".svg", "w") { |f| f.write svg }
                stop
                # <line stroke-linecap="undefined" stroke-linejoin="undefined" id="svg_1" y2="219.5" x2="455.5" y1="114.5" x1="56.5" stroke="#000" fill="none"/>
              end
            end
          end
          
          '
                with_real_time do live_loop :s2 do
                    #$pitch = (sync "/midi:usb_midi_interface_0:4/pitch_bend")[0].to_f / 8192.0 -1.0
                    #control fk_n, mix: 0.min($pitch*-1.0) if $pitch < 0
                    co = sync $n19midi_dmk25[:slider][0][1]
                    control fk_n, mix: 0.min(co[1] / 128.0) if co[0] == 7
                end end
                '
          
          with_real_time do
            live_loop :mid_in do
              s = sync $n19midi_dmk25[:note]
              n = s[0]
              v = s[1]/128.0
              #              $s_b = s# if s[0] < 60
              #synth :blade, note: $s[0], amp: $s[1]/128.0
              midi2text_piano_roll(midi_out_file+"_midi.log", note: n, midi: [$n19midi_dmk25[:note], s]) if b_write_midi_file == 1
              if b_piano > 0 then
                synth :piano, note: s[0], vel: 0.1+0.4*(s[1]/128.0), sustain: (s[1]/128.0)*2.0, amp: 0.2+(s[1]/128.0) if s[1] > 0 and b_piano == 1
                if b_piano == 2 and v > 0 then
                  #       znvADSRadsr (TODO: adsr-klein ist noch nicht programmiert... lautstärke bei adsr )
                  in9 = ["1194555",  #1/1 --> root note. soll mal laut sein, damit keine Verwirrung    [Z]aehler/[N]enner and
                         "6529921",  #   0-9 means repraesenting 0%-100% for [V]olumne and than each of adsr (attack, decay, sustain, release) multplied with the give length
                         "5452991",  #--> frequenz: +f*5/4, vol: 50%*vol
                         "4352991",  #    XXXXX  2  XX  X     _XXX   XXX
                         "3245299",  #   XX        XXX XX    X XX  XX XX
                         "2144922",  #  XXXX      XX XX X     XX     XX
                         "3134922",  # XX        XX  X  X    XX   XXX
                         "4134444"]
                  inst1(in9, n, 0.25, v*4) # inst, note, vol, length
                end
                
                # attack +12
                #with_synth :saw do
                p3cue.push([v > 0 ? (play n-24, sustain: 1000, pan: -1, pan_slide: 0.5, amp_slide: 0.5, amp: 0) : nil, n,v, vt]) if b_piano > 1
                #end
                #p3cue.push([n,v]) if b_piano > 2
              end
            end
            
            
            ' this loop receives notes the array p3cue in the following form:
                  [ control, note, velocity, phase, phase_i]
                '
            
            live_loop :p3 do
              if b_piano == 3 then
                p3i += 1
                tra = 0
                att_rel = p3cue.length > 0
                
                if p3cue.length > 0 then
                  while (c, n, v = a = p3cue.shift) != nil
                    if v > 0 then
                      p3[n.to_s] = a
                      control c, amp: v, amp_slide: 0.1, note_slide: 0.1
                      vt_last_add_node = vt
                    else
                      c=p3[n.to_s][0]
                      control c, note: n-12, amp: 0, pan: 1, pan_slide: 0.5, note_slide: 1, amp_slide: 1
                      #control c, note: n+12, amp: 0, pan: 1, pan_slide: 0.5, note_slide: 0.1, amp_slide: 0.25
                      #control c, amp: 0
                      p3.delete(n.to_s)
                      in_thread do sleep 1.5; kill c; end
                    end
                  end
                  print vt, b_ver, b_sort, p3.keys, b_knit_def
                  notes = (p3.keys.map { |s| s.to_i })
                  tra = 2 #CFG1: all note pitch slide
                  print fx_n.args
                end
                ord, pan, amp = b_knit_def
                kn = nk19syn(b_sort==0 ? notes : notes.sort, ord: ord, pan: pan, amp: amp, ii: p3i, tra: tra) if att_rel or  $s1 > 0.05
                #rec.push({ :vt => vt, :p => (p3.map { |k,a| [k, (a[0] != nil ? a[0].args.clone : nil)]}).to_h , :knit => b_knit_def, :info => info }) if  b_write_midi_file == 2
                sleep 1.0-$s1 if not att_rel and $s1 > 0.05
                if  vt < vt_last_add_node + 1.0 or $s1 > 0.05 then
                  p3.each_with_index { |(k,v),i|
                    #print p3[k][2], p3[k][3], ta=(p3[k][2]/2.0).min(p3[k][2] / (1.0+vt-p3[k][3])) if (amp == nil or p3[k][3]+1.0 < vt)
                    control v[0], kn[i], amp: (p3[k][2]/2.0).min(p3[k][2] / (0.5+vt-p3[k][3])) if (amp == nil or p3[k][3]+1.0 < vt) #CFG2/3: amp atack fall
                    control v[0], kn[i] if amp != nil
                  }
                end
                
              end
              sleep 0.2
              if b_write_midi_file == 2 then
                info = "%.2f|nor:%.2f|sli:%.2f/%.2f|bit:%.2f/%2d/%6d" % [$s1, fx_n.args[:mix], fx_s.args[:mix], fx_s.args[:phase], fx_b.args[:mix], fx_b.args[:bits], fx_b.args[:sample_rate]]
                midi2text_piano_roll(midi_out_file+".log", notes: (p3.keys.map { |s| s.to_i }), info: info+b_knit_def.to_s)#+fx_n.to_s)
                #rec.push({ :vt => vt, :p => (p3.map { |k,a| [k, (a[0] != nil ? a[0].args.clone : nil)]}).to_h , :knit => b_knit_def, :info => info })
              end
            end
end end end end end end



