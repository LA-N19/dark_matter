# L.A.N19 - 20241201 - lan19_SonicCalc_v01.rb
# cd /mnt/d/LA-N19/dark_matter; watch -n 0,2 cat  lan19_modalg_seq01.log

"https://www.conrad.de/de/p/joy-it-com-lcd-16x2-display-modul-6-6-cm-2-6-zoll-16-x-4-pixel-passend-fuer-entwicklungskits-arduino-mit-hintergrund-1656369.html?hk=SEM&WT.mc_id=google_pla&gad_source=1&gclid=Cj0KCQiAhomtBhDgARIsABcaYymLDMn9vkgwjU0d27d-DSoPh9FFjKmzPwbuEZD5tPNuMpf97TXLwcAaAhsYEALw_wcB  "
"https://www.youtube.com/watch?v=6XY9PooMrms&list=PLWNDWPAClRVojCmvkfJQqRusRUnb-bJKb&index=3"
"https://www.youtube.com/watch?v=JxtX4JIKK4s"
"https://www.reichelt.de/nummernblock-bluetooth-schwarz-sandberg-630-09-p342368.html?&trstct=pol_6&nbc=1"
"https://www.reichelt.de/nummerblock-bluetooth-pfeiltasten-aluminium-logilink-id0187-p288716.html"
"https://www.reichelt.de/nummernblock-usb-schwarz-it88884110-p354558.html?&trstct=pol_0&nbc=1"
"https://www.conrad.de/de/p/renkforce-usb-nummernblock-spritzwassergeschuetzt-staubgeschuetzt-touch-tasten-schwarz-1597229.html?hk=SEM&WT.mc_id=google_pla&gad_source=1&gclid=CjwKCAiAqY6tBhAtEiwAHeRopRljIlXMF5v7NCjuy1Pvku4zIL0GMc7Eq7tlVB8ms76UDsHXs2ynOhoCZYEQAvD_BwE"
"https://www.reichelt.de/entwicklerboards-display-lcd-1-3-240-x-240-pixel-st7789-debo2-lcd240x240-p296742.html?PROVID=2788&gclid=CjwKCAiAqY6tBhAtEiwAHeRopZaafKaJHerJPXkZqbYDMnPffBkyfXX620_Zw2MecEMEYhYzLRNG0RoCMxwQAvD_BwE"


#x = { "b": [ "|_ ", "|_|" ] }

tit="--== L.A.N19-SonicCalc_v0.1 ==--"
tit="L.A.N19:SonicCalc_v0.1"
@b = binding

out, out_head = [tit], []; @algX=0;  @alg_ = "";
@algs=[ "n0=b0*2+b1+b3+c0+cb; n1=b2*6+cb+c1;t=1.75;p0=b0-b1;p1=b2-b0;",
        "n0=b0*2+b1+b3;n1=b2*6;t=1.75;p0=b0-b1;p1=b2-b0",
        "n0=(b1+b2);na=b0",
        "n1=(b1&b2)+b0;na=b0;nb=b1|b2",
        "n1=(b1&b2)+b0; n0=b0; p0=b1-b0; na=b0; nb=b1|b2; nc=b1&b0",
        "n0=b0*2+b1+b3; n2=b2*6; na=b0; nb=b1|b2; nc=b1&b0; nd=b2&b0;",
        "n0=b0*2+b1+b3; n2=b2*6; sle=0.025;nb=b1|b2; nc=b1&b0; nd=b2&b0;"
        ]
@alg_len = 8
@algs += [""]*(10-@algs.length)
# use_synth :blade
#use_synth :hollow
exp = 7; len = 2**exp; @len = len

def get_array(var, yrange: (0..8), xrange: (0..(@len-1)), c: 0)
  #xrange = (0..@len) if not xrange
  vars, xlen = var.split(","), xrange.max
  return [ (" "*(3+c%xlen+1)+"*") ] if var == "*"
  return yrange.map { |y|
    (xrange.map { |x| y2p, y2 = (2 ** (y+1)), 2 ** y
       va = vars[(x * vars.length / xlen).to_i]
       next "*" if va == "b0" and (x / y2p) % 2 == 1
       #next "x=%d, y=%d, y2=%d"%[x,y,y2]  if var == "c0" and x == 63
       next (x == 0 ? "c%d=c%%%03d=%03d "%[y,y2p,c % y2p]:"") if va == "c0h" and x < 16
       next (x == (xlen-1) ? " c%s=c/%03d=%03d "%[(y+10).to_s(36),y2p,c / y2p]:"") if va == "cah"
       #next (x ==  ? "c%d=c%%%03d=%03d "%[y,y2p,c % y2p]:"") if va == "c0a" #and x < 8
       next (x % y2p).to_s(36) if va == "c0" and (x % y2p) > 0
       next (x / y2p).to_s(36) if va == "ca"
       next " "
       
  }).join("") }
end

def get_display(mod, c)
  if mod=='clo2' then
    # val += (1..4).map { |e| [ (0..(len-1)).map { |ca| xx=(ca % (2**e)).to_s(36); xx == "0" ? " " : xx  }].join("") }
    val = get_array("c0h,c0,ca,cah", yrange: (0..4), c: c)
    val += (5..8).map { |k| v=2**k;
      "c%s=c%%%03d=%3d  c%s=c/%03d=%3d %s" %
      [k, v, c%v, (k+10).to_s(32), v, c/v, "*"*((c%v)*32/v) ]
    }
    val += [ "clo2:c=%03d" % c ]
    add_last = 0
  end
  return val
end

def add_val2dis(val, c, len, li: nil, re: nil)
  out_dis = []
  val.each_with_index { |v,ix|
    if ix < 10 then
      l = (li == nil ? " "+@n[ix].to_s.rjust(3, ".")+" "+(c%2**(ix+1)).to_s.rjust(3)+"  "+((c/2**(ix+1))%2).to_s+"   "+ix.to_s(36) + " | " : li)
      r = (re == nil ? (ix+10).to_s(36) + " "+(c/2**(ix+1)).to_s.rjust(3)+" "+@n[ix+10].to_s.rjust(3) : re)
      out_dis += [ l + v.ljust(len) +" | " + r ]
    else
      out_dis += [ "              "+(ix < 10 ? ix : ix+22).to_s(36)+" | "+ v.ljust(len) +" | " + (ix+10).to_s(36) + " n" ]
    end
  }
  return out_dis
end


def add_val2dis2(val, c, len, li: "", re: "")
  return val.map { |v|  li + v.ljust(len) + " | " + re   }
end



live_loop :dimod_seq do
  c = tick #; c2 =  c0 / len;
  
  mod   = ["bit", "clo", "clo2", "alg"][(c/len)%4]
  #mod   = "clo2"
  #mod = "alg"
  mod_n = -1; mod_c = (mod_n == -1 ? "_" : mod_n.to_i(32))
  #out_dis = [ tit.center(len+4,' ')+"   ", "    "+"_"*(len+2)+"   "]
  
  evals = {
    "clo_": #"c0=%d; c1=c0%4; c2=c0/4; c1=c0%8; c2=c0/8" % [tick,len,len],
    #"c0=%d; c1=c0 / 2; c2=c0/4" % [c0,len,len],
    "c=%d;c0=c%%2;c1=c%%4;c2=c%%8;c3=c%%9;ca=(c/2);cb=c/4;cc=c/8;cd=c/16" % [c],
    "bit_": [ (0..8).map { |e| "b%d=%d" % [e, ((c/(2**e)) % 2)] } ].join(";"),
    #"sca_": "s=(60..100).map{ |s| s };s0=s;s1=s;s2=s;s3=s;",
    "sca_": "s=scale :Eb4, :super_locrian, num_octabes: 2;s0=s;s1=s;s2=s;s3=s;",
    # "def": "off=50;t=1;n0=0;n1=0;n2=0;p0=0;p1=0;p2=0;na=0;nb=0;nc=0;nd=0",
    "def": "off=50;t=1;p0=0;p1=0;p2=0",
    "def1": (['n'].map { |cz| (0..15).map { |i| cz+i.to_s(36)+"=0" }}).flatten.join(";"),
    "exe": "@algX = cd % @alg_len; @alg_=@algs[@algX]",
    #"exe": "@algX = 4; @alg_=@algs[@algX]",
    "_ply0": "with_synth :dark_ambience do; play s0[n0], pan: p0, amp: 0.5 if n0 > 0; end",
    "_ply1": "with_synth :hollow do; play s1[n1], pan: p1, amp: 0.5 if n1 > 0; end",
    "_ply2": "with_synth :hollow do; play s2[n2], pan: p2, amp: 0.5 if n2 > 0; end",
    #"ply3": "play sca0[ton3], pan: pan3 if ton3",
    "_plyA": "sample :drum_cymbal_pedal, slice: 16  if na > 0",
    "_plyB": "sample :drum_bass_hard, slice: 16 if nb > 0",
    "_plyC": "sample :drum_snare_hard, slice: 16  if nc > 0",
    "_plyD": "sample :drum_tom_mid_hard, slice: 16  if nd > 0",
    "_tim": "sleep (t*0.125).min(0.125)",
    "_outn": (['n'].map { |cz| "@"+cz+"=["+((0..15).map { |i| cz+i.to_s(36) }).join(",") + "]" }).join(';')
  }
  
  evals.each { |ti,ev|
    out_debug += [ ti.to_s+" "+ev ]
    print ti.to_s+" "+ev
    @b.eval(ev.gsub("=;", "=false;"))
    @b.eval(@alg_) if ti.to_s == "exe"
    #out += [ [" "],"   ["+mod+mod_c+"]: ["+ev.ljust(50)+"]" ] if mod+mod_c == ti.to_s
    #eval(ev, blo.binding)
  }
  
  val = [ "" ]
  add_last = 0
  val_bit = (0..6).map { |e| " bit b"+e.to_s+"="+(c/(2**e) % 2).to_s + " | " +  [(0..(len-1)).map { |ca| (ca/(2**e)) % 2 == 1 ? "*" : " " }].join("") }
  #val_bit = get_array("b0")
  val_bit += ["          | "+ " "*(c % len)+"*"]
  val_bit += (0..4).map { |e| " clo c"+e.to_s+"="+(c % (2**(e+1))).to_s(36) + " | " +  [(0..(len-1)).map { |ca| (ca % (2**(e+1))) == 0 ? " " : (ca % (2**(e+1))).to_s(36) }].join("") }
  val_bit += ["          | "+ " "*(c % len)+"*"]
  val_bit += (1..6).map { |e| " clo c"+(e+10).to_s(36)+"="+((c / (2**e)) % 64).to_s.ljust(2) + "| " +  [(0..(len-1)).map { |ca| (ca / (2**(e+1))) == 0 ? " " : (ca / (2**(e+1))).to_s(36) }].join("") }
  if mod=='clo2' then
    val = get_display(mod, c)
    val += [ 'clo2:c=%03d' % c ]
    add_last = 0
  end
  
  
  val_clo, add_last = [ "c=%10d" % [c] ], 1
  val_clo += (1..9).map { |k| v=2**k;
    "c%s=c/%03d=%3d  c%s=c%%%03d=%3d %s" %
    [k, v, c/v, (k+10).to_s(32), v, c%v, "*"*((c%v)*32/v) ]
  }
  
  val_alg = @algs.each_with_index.map { |v,i| " alg a"+i.to_s+"   | "+v }
  val_alg += ["      exe | alg %d: %s" % [@algX, @alg_]]
  #val += [ mod+mod_c+": "+evals[(mod+mod_c).to_sym]] if add_last == 1
  #val += [ mod+mod_c+("(%d): " % [@algX])+@alg_]  if add_last == 2
  #val += [ "exe%d: %s" % [@algX,@alg_] ]
  #val += [[">_", ">"].choose]
  # val[-1] = val[-1][0..32] if val[-1].length > 64
  
  '
  if mod=="not" then
    val = [ "c0=%10d" % [c0] ]
    val += (1..9).map { |k| v=2**k;
      "c%s=c0/%03d=%3d  c%s=c0%%%03d=%3d %s" %
      [k, v, eval("c0/(2**"+k.to_s+")"), (k+10).to_s(32), v, c0%v, "*"*((c0%v)*32/v) ]
    }
    val += [ mod+mod_c+": "+evals["clo_".to_sym]]
  end
  '
  #val ü= out += [["   [alg_]: ["+@alg_.ljust(50)+"]" ], [" "] ]#
  
  
  ########################################################################
  # out_dis - display
  ########################################################################
  #out_dis = [ " n[] c[] b[]  i  "+tit.center(len+2,'_')+"  i  c[] n[]   "]
  out_dis = [ "           "+tit.center(len+2,'_')+"   "]
  #out_dis += add_val2dis(val_clo, c, len)
  out_dis += add_val2dis2(val_bit, c, len+12)
  out_dis += add_val2dis2(val_alg, c, len+12)
  out_dis += [ "          |_"+"_"*len+"_|"]
  
  out = out_dis
  out_debug = [ "mod "+mod+mod_c  ]
  
  #
  '
  out_help =  "0a [alg]orithm,1b [bit]s & beats,2c [clo]ck,3d [def]inition, 4e [exe]cute,5f [fx]".split(",")
  out_help +=  " w [swi]ing, g [ear]r, []".split(",")
  '
  out_help = [@n.to_s]
  out_help += """Command-Mode:,a1=1 # algo 1 switch on,a1 # toggle algo 1 on/off,A # switch on algo display,a1: # edit algorithm one""".split(",")
  
  
  File.open("d:/LA-N19/dark_matter/lan19_modalg_seq01.log", "w") { |f|
    f.write([out].join("         \n")+"\n  joins of calc: ([def,clo]->[bit])->([exe]->([alg_,ply_,tim_,fx_])")
    f.write(out_help.join("\n"))
    f.write("""
.   _____   _____   _____   _____   _____   _____   _____
.  |mod  | |lin  | |num  | |     | |  *  | |  /  | |     |
.  |__(X)| |__(X)| |__(X)| |_____| |^____| |%____| |_____|
.                           _____   _____   _____   _____
.                          |  7  | |  8  | |  9  | |  -  |
.                          |h_hlp| |i_tim| |j_oin| |&____|
.                           _____   _____   _____   _____
.                          |  4  | |  5  | |  6  | |  +  |
.                          |e_exe| |f_fx_| |g_ear| ||____|
.           _____           _____   _____   _____   _____
.          |  ^  |         |  1  | |  2  | |  3  | |     |
.          |__|__|         |b_bit| |c_clo| |d_def| |     |
.   _____   _____   _____   _____   _____   _____  |   | |
.  |  <  | |  |  | |  >  | |  (  | |  0  | |  )  | | <-' |
.  |s_sca| |p_pan| |n_ote| |_____| |a_alg| |_____| |_____|""")
  }
  
end

##.sub("_"+mod+"|","<"+mod+">")+out_debug.join("\n") +[out_help].join("         \n"))



