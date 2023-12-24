'
  n19v2.rb
 
  
   
 _instrument_und_helix.rb
 https://de.wikipedia.org/wiki/Cent_(Musik)#:~:text=Verwendung%20in%20der%20Musiktheorie,-Die%20Gr%C3%B6%C3%9Fe%20von&text=Der%20Ma%C3%9Feinheit%20Oktave%20entspricht%20das%20Frequenzverh%C3%A4ltnis%202%3A1.&text=Werden%20Intervalle%20hintereinander%20ausgef%C3%BChrt%2C%20so,Cent%20%3D%201200%20Cent%20%3D%20Oktave.
 1200·log2(6⁄5)

   # https://www.youtube.com/watch?v=kFRdoYfZYUY
 
'
$n19cfg_to_i=9.0

$n19midi_dmk25 = { #
               :knob => { :midi => "/midi:dmk25_0:1/control_change",
                          :knob => [10, 91, 93, 73], :mod => 1,
                          :loop => 15, :rw => 16, :fw => 17, :stop => 18, :play => 19, :rec => 20 },
               :slider => [(1..4).map { |i| "/midi:dmk25_0:"+i.to_s+"/control_change" }, [7, 7, 7, 7]],
               :pad => ["/midi:dmk25_0:10/note_*", [36, 38, 42, 46, 49, 45, 41, 51]],
               :pitch => "/midi:dm25_0:1/pitch_bend",
               :note => "/midi:dmk25_0:1/note*",
               }
$n19nc_cfg= {
  :att => { note: -24, sustain: 1000, pan: -1, pan_slide: 0.5, amp_slide: 0.5, amp: 0 },
  :att_all => { note: +2 },
  :sus =>  { amp_slide: 0.1, note_slide: 0.1 },
  :dec =>  { amp_slide: 0.1, note_slide: 0.1 },
  :rel =>  {},
}

# the following funktion converts strings into a array of numbers, where p means positiv 0..1 and 
def n19str2a(aInput, aOutRange=[0.0, 1.0], aInRange=$n19cfg_to_i, aLen=4) 
  r=aOutRange[1].to_f-aOutRange[0]
  return (0..(aLen-1)).map { |i| aInput.to_f } if aInput.is_a? Float or aInput.is_a? Integer # if it is float/int --> all should have this number (convert to float to be sure...)
  return (0..(aLen-1)).map { |i| (i.to_f / aLen.to_f)*r + aOutRange[0] } if aInput == "lin"
  return (0..(aLen-1)).map { |i| aOutRange[1] - (i.to_f / aLen.to_f)*r } if aInput == "rlin"
  return (0..(aLen-1)).map { rrand(aOutRange[0], aOutRange[1]) } if aInput == "rand"
  return (0..(aLen-1)).map { |i| i%2==0 ? aOutRange[1] : aOutRange[0] } if aInput == "onoff" #or aInput == "ronoff"
  return aInput.chars.map { |s| (s.to_i(aInRange).to_f/aInRange.to_f)*r+aOutRange[0]  }
end

N19_CFG = {
  :nk_ord => ["0..9", "rand", nil, "ii=0", "ma01", "ma02", "ma03", "ma04", "ma05", "ma06", "ma07", "ma08"],
  :nk_pan_amp => ["0..9", "rand", nil, "sh01", "ma01", "flip"],
}


$n19_vt_start = nil
$nk19_record = 0
$nk19_recs   = []

def midi2text_piano_roll(file_name, notes: nil, info: nil, head: 0)
  File.open(file_name, head > 0 ? "w" : "a") { |f|
    t = "cCdDefFgGaAb"
    if head > 0 then
	   #f.write(" | |  | | | "*10, "\n") if head == 1 # short head
	   f.write(t*6, "\n") if head == 1 # short head
	   $n19_vt_start = nil
	else
	   $n19_vt_start = vt if $n19_vt_start == nil
       str = " | |  | | | "*6
	   #(notes.is_i ? [notes] : notes).each { str[note] = t[note%12] }
	   notes.each { |n| str[n-3*12] = t[n%12] }
	   f.write(str, info, " ",  (vt-$n19_vt_start).truncate(2).to_s, " ", notes, "\n") 
	end
  }
end


def n19str2arr(str, outRange: [0.0, 1.0], inRange: $n19cfg_to_i, len: nil, ii: 0) 
  str =   ["0..9", "R0..9"][ii%2]                if str == "ma01" #ord-only 
  str =   ["0..9", "3/6", "R3/6", "R0..9"][ii%4] if str == "ma02" #ord-only
  str =   ["0..9", "3/6", "R3/6", "R0..9"][[0,1,2,3,2,1][ii%6]] if str == "ma03" #ord-only
  str =   ["09", "0..9", "3/6", "R3/6", "R0..9", "R09"][ii%6] if str == "ma04" #ord-only
  str =   ["09", "0..9", "3/6", "R3/6", "R0..9", "R09"][[0,1,2,3,4,5,4,3,2,1][ii%10]] if str == "ma05" #ord-only
  str =   ["09", "0..9", "3/6", 0, "R3/6", "R0..9", "R09"][ii%7] if str == "ma06" #ord-only
  str =   ["09", "0..9", "3/6", 0, "R3/6", "R0..9", "R09"][[0,1,2,3,4,5,6,5,4,3,2,1][ii%12]] if str == "ma07" #ord-only
  str =   ["09", "0..9", "3/6", 0, "R3/6", "R0..9", "R09"][rand_i(7)] if str == "ma08" #ord-only
  str =   ["9*0", "R9*0"][ii%2]   if str == "sh01" 
  str =   ["09", "R09"][ii%2]     if str == "flip"
  l=len||str.length# == nil ? str.length : len
  return (0..(l-1)).map { |i| str.to_f } if str == nil or str.is_a? Float or str.is_a? Integer # if it is float/int --> all should have this number (convert to float to be sure...)
  return n19str2arr(str[1..-1], outRange: outRange, inRange: inRange, len: l, ii: ii).reverse if str[0] == "R"
  r=outRange[1].to_f-outRange[0]
  return (0..(l-1)).map { |i| (i.to_f / len.to_f)*r + outRange[0] } if str == "0..9"
  return (0..(l-1)).map { |i| outRange[i == l-1 ? 1 : 0] } if str == "0*9"
  return (0..(l-1)).map { |i| outRange[i == l-1 ? 0 : 1] } if str == "9*0"
  return (0..(l-1)).map { |i| outRange[i<l/2 ? 0 : 1] } if str == "0/9"
  return (0..(l-1)).map { |i| (ii+i)%l } if str == "ii=0"
  return (0..(l-1)).map { |i| outRange[0] } if str == "0*"
  return (0..(l-1)).map { |i| (i<l/2 ? 0.25 : 0.75) * r  }          if str == "3/6" 
  return (0..(l-1)).map { rrand(outRange[0], outRange[1]) }         if str == "rand"
  return (0..(l-1)).map { |i| i%2==0 ? outRange[1]-0.1 : outRange[0] } if str == "09" #or aInput == "ronoff"
  return str.chars.map { |s| (s.to_i(inRange).to_f/inRange.to_f)*r+outRange[0]  }
end
#def n19str2ord(aInput, aOutRange=[0.0, 1.0], aInRange=$n19cfg_to_i, aLen=4) n19str2ord(aInput, aOutRange=[0.0, 1.0], aInRange=$n19cfg_to_i, aLen=4) .map { |v| v.to_i } end


def nk19syn(aNotes, ord: "0..9", pan: "0..9", syn: nil, len: nil, ii: 0, amp: 0.5, tra: nil)
  targs = local_variables.clone
  l=len||aNotes.length
  #print o=n19str2arr(ord, outRange: [0, l], len: l, i: i) #.map { |v| v.to_i }
  o=n19str2arr(ord, outRange: [0, l], len: l, ii: ii).map { |v| v.to_i }
  p=n19str2arr(pan, outRange: [-1.0, 1.0], len: l, ii: ii)
  a=n19str2arr(amp, outRange: [0.0, 1.0], len: l, ii: ii)
  tra=tra||0
  tra=tra[ii%tra.length] if tra.kind_of?(Array)
  rNotes = (0..(l-1)).map { |i|
    { note: aNotes[o[i]]+tra, pan: p[i], amp: a[i] } # given aSyn noch hinzufügen
  }
  $nk19_recs.push({ :vt => vt, :syn => rNotes.clone, :args => targs}) if $nk19_record > 0
  return rNotes
end

def n19sam2file
File.open("d:/la_n19/n19_sam.rb", "w") { |f|
  f.write("$n19_sam = [")
  #f.write("#", sample_names[0..-1].to_s)
  sample_groups.each_with_index { |g,i|
    f.write("\n['%i', '%s', [\n" % [i,g])
    sample_names(g).each_with_index { |n,i|
      f.write("\n:",n,", #g",j,"s",i)
    }
    f.write("\n]],")
  }
  f.write("\n]")
}
end



'    
nk1_combos = { "rand" => [["rand", "rand", "rand"]],
               "ma01" => [["inc0", "inc0", "inc0"],  ["dec0",  "inc0" , "inc0"]],
               "ma02" => [["inc0", "inc0", "inc0"],  ["inc1",  "inc0" , "inc0"], ["inc1",  "inc0" , "inc0"]]
}
end

  syn=n19syn(cho, aOrd: ["0123", "1122", "2211", "3210"][iii%4]) if b_knit == 2
  syn=n19syn(cho, aOrd: ["0123", "1122", "0033", "3300", "2211", "3210"][iii%6]) if b_knit == 3
'


'
1 Zaehler
2 Nenner
3 Volume 
4 Attack
5 decay
6 sustain
5 release

Example: 
  with_fx :gverb do
    with_synth :hollow do
      #     znvadsr
      i = ["1194555",
           "6529921",
           "5452991",
           "4352991",
           "3245299",
           "2144922",
           "3134922",
           "4134444"]
      inst1(i, 50, 0.5, 20.0)
    end
  end

'
def inst1(aInst, aNote, aAmp, aDuration )
  aInst.map { |i|
    #v = i.chars.map { |val| val.to_i(36)/36.0 }
    v = i.chars.map.with_index { |val,i| (val.to_i/10.0 * (i > 2 ? aDuration : 1.0)).round(2) }
    #print i, v
    play aNote+12.0*Math.log2(v[0]/v[1]), amp: v[2]*aAmp, attack: v[3], decay: v[4], sustain: v[5], release: v[6]
  }
end


def fpat1(aPat, aSynset, aPatset)
  a = aPat.scan(/(\d)([^\d]*)/)
  a.each_with_index do |x, i|
    no =  aPatset[:notes][x[0].chars[0].to_i]
    l = (1 + x[1].length)# * 0.025
    play no, aSynset, decay: x[1].count("d")*aPatset[:sleep]
    sleep aPatset[:sleep] * l
  end
end


def fpat2(aPat, aSynset, aPatset)
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

def fpat3(aPat, aSynset, aPatset, aNotset)
  a = aPat.scan(/(\d)([^\d]*)/)
  n = aNotset
  '
  ctrl = n[aPat[0].to_i].map { |x|
    play x, amp: 0, sustain: aPat.length * 0.125, note_slide: 0.125, amp_slide: 0.125
  }'
  ctrl = []
  n[aPat[0].to_i].each_with_index { |nn, ii|
    ctrl[ii] = play nn, amp: 0, sustain: aPat.length * 0.125, note_slide: 0.125, amp_slide: 0.125, pan_slide: 0.5, divisor: 0.1, cutoff: 20, deep: 0.1
    #ctrl[ii] = play nn, amp: 0, sustain: aPat.length * 0.125, note_slide: 0.125, amp_slide: 0.125, pan_slide: 0.5
    sleep 0.1
  }
  print "__LA_N19_v01/fpat3/aPat: " + aPat
  print "__LA_N19_v01/fpat3/aSynset: " + aSynset.to_s
  print "__LA_N19_v01/fpat3/aPatset: " + aPatset.to_s
  print "__LA_N19_v01/fpat3/aNotset: " + aNotset.to_s
  
  a.each_with_index do |x, i|
    no =  n[x[0].chars[0].to_i]
    l = (1 + x[1].length)# * 0.025
    nno = ctrl.length
    no2 = no #default
    #no2 = no.map { |ii, v| no[(i + ii) % no.length] } if aPatset[:slidemode] == 0 # shift-knitter
    no2 = no.take(no.length + i ).drop(i) if aPatset[:slidemode] == 0 # shift-knitter
    no2 = no.reverse  if i % 2 == 0 and aPatset[:slidemode] == 1 # cross-knitter
    no2 = no.shuffle if aPatset[:slidemode] == 2 # random-knitter
    #print "patpart(%d): %s, \t note: " % [i, x], no, " --> ", no2
    a = aSynset[:amp]
    pan = []
    ctrl.each_with_index { |ct, ii|
      pan[ii]=(i+ii) % 5 / 2.0  - 1.0 # (i+ii+0.0) % nno / nno  - 1.0;
      control ct, note: no2[ii], amp: a, pan: pan[ii];
    }
    #print pan
    l.times { |i2| sleep 0.125
      a = 0.min(a * (1 - (i2 % 2) / 1.2)/1.0)
      ctrl.each_with_index { |ct, cti| control ct, amp: a, pan: pan[cti]*0.9**i2 }
    }
  end
end



#with_synth :fm do
def inst_a_create(aNotes, sustain: 1)
  c = (0..3).map { |n| play 0, amp: 0, attack: 0, sustain: sustain, release: 1, pan_slide: 0.05, note_slide: 0.05, amp_slide: 0.05 }
end

def inst_a_helix(aCtrl, aNotes, aSteps: 4, aStepWidth: 3, aMode: 0 )
  print c = aCtrl
  x = Proc.new { |y| Math.sin((y-3)).round(3) }
  z = Proc.new { |y| Math.cos(y/6.0).round(3) }
  nn = aNotes.length
  #helix= (-12..0).step(2).map { |y| {
  #    x: x[y], z: z[y], l: (x[y+1]-x[y]).round(3), s: z[y].abs, a: (z[y]+2.5)/4.0
  #} }
  #print helix
  sleep 0.1
  aSteps.times do |i|
    p=((i+1)/aSteps)
	total_y=((aSteps-1)*aStepWidth)
    y=i*aStepWidth
	#[s=z[y].abs, a=(z[y]+2.5)/4.0]
    print "p, [x,y,z]->[s,a]: ", p, [x[y], y, z[y]], "->", [s=z[y].abs, a=(z[y]+2.5)/4.0]
    
    c.each_with_index { |c,i|
	  n = aNotes[i] # in doubt: just do nothin
	  n = aNotes[i] + y - dist if aMode == 0 or (aMode == 2  and i < nn / 2.0)
 	  n = aNotes[i] - y + dist if aMode == 1 or (aMode == 2 and i > nn / 2.0)
 	  n = aNotes[i]     if aMode == 2 and i == nn / 2
 	  n = aNotes[i] * p + aNotes[nn/2]*(1.0-p) if aMode == 3 
      control c, note: n, pan: x[y] * (i%2==0 ? -1 : 1), amp: a
      #print aNotes[i]+y, x[y] * (i%2==0 ? -1 : 1), a
    }
    # *(i%3-1.0), amp: a }
    #control c2, note: n+y+3, pan: x[y], amp: a
    #play n+y+12, pan: x[y], amp: a, sustain: s/2.0
    sleep s/4.0
  end
  #end
  return c
end

def hpat0(ahpat)
    ahpat.each_with_index { |r,i|
      print sleep_sum += r[0], i, r
      #sleep_sum += r[0]
      print p=r[1].split('|')
      p.each_with_index { |s,j|
        no = ((s.chars.map { |n| "CcDdEFfGgAaB".index(n) }).select { |n2| not n2.nil? }).map { |n3| n3+j*12}
        if no.length > 0 then
          play no, r[2]
        end
      }
      sleep r[0]
    }
end


def n19pat_a(apat)
  nam, cnv, tim, pat = apat.split("|")
  tim, par, nn_par = eval(tim+".0").to_f, pat.chars, pat.chars.map { |v| next if v!=" "; v }
  if cnv[">"] then
    m = cnv.split(">")
    map_from, map_to = m[0].to_i, eval(m[1])
    map_to_span = (map_to[1]-map_to[0]).to_f
    #parm_i = parms.map { |v| v==" " ? nil : (v.to_i(map_from)/map_from.to_f) * map_to_span }
  end
  pax = {
    "unit"       => tim,
    "length"     => tim*par.length,
    "parms"      => par,
    "nn_parms"   => nn_par,
    "parms_i"    => par.map { |v| v==" " ? nil : v.to_i(36) },
    "nn_parms_i" => nn_par.map { |v| v.to_i() },
    #"nn_parms_i" => nn_par.map { |v| v.to_i(36) },
    "units"      => par.map.with_index { |v,i| i*tim },
    "nn_units"   => par.map.with_index { |v,i|  next if v!=" "; i*tim},
  }
  
  
  return [nam.strip, pax]
end
def n19pats_a(apats);   return apats.map { |v| n19pat_a(v) }.to_h; end


'
    
    synth                          - 
    attack_[mode,duration(0.1),amp(1)]     
	decay_[mode,duration(0.2),amp(0.75)] 
	sustain_[mode,duration,amp(0.5)]  
	release_mode
	       _duration
		   amp                       - default: 0 
	gliss_[mode,duration,amp]   -
    overall_[mode,duration(1),amp()] - if amp and duration is set (and by default it is set!) all other amp/duration are set relativly

	, for each of them you have the following "mode"-components
	  ["nkeep", "nshift", "nflip", "nrand"] - vary between notes
    , ["pnote", "phelix"]
	, ["alinear", "astep"]                  - amp behavior
    , ["helix]	
	
  n19i1_create()
  n19i1_play
  n19i1_glide
  
my_note = play :C4, sustain: 60 * 60 * 2
my_note.pause
my_note.run
my_note.control note: :E4
my_note.kill
  
'
	