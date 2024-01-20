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


x = { "b": [ "|_ ", "|_|" ] }




tit="--== L.A.N19-SonicCalc_v0.1 ==--"
tit="L.A.N19:SonicCalc_v0.1"
@b = binding
out, out_head = [tit], []; @algX=0;  @alg_ = "";
@algs=[ "n0=b0*2+b1+b3+c0+cb; n1=b2*6+cb+c3;t=1.75;p0=b0-b1;p1=b2-b0",
        "n0=b0*2+b1+b3;n1=b2*6;t=1.75;p0=b0-b1;p1=b2-b0",
        "n0=(b1+b2)",
        "n1=(b1&b2)+b0",
        "n1=(b1&b2)+b0; n0=b0; p0=b1-b0",
        "n0=b0*2+b1+b3; n2=b2*6",
        "n0=b0*2+b1+b3; n2=b2*6; sle=0.025"
        ]
@algs += [""]*(10-@algs.length)
exp = 6; len = 2**exp
live_loop :dimod_seq do
  c0 = tick; c2 =  c0 / len;
  
  mod   = ["bit", "clo", "alg"][(c0/len)%3]
  #mod = "alg"
  mod_n = -1; mod_c = (mod_n == -1 ? "_" : mod_n.to_i(32))
  #out_dis = [ tit.center(len+4,' ')+"   ", "    "+"_"*(len+2)+"   "]
  
  evals = {
    "clo_": #"c0=%d; c1=c0%4; c2=c0/4; c1=c0%8; c2=c0/8" % [tick,len,len],
    #"c0=%d; c1=c0 / 2; c2=c0/4" % [c0,len,len],
    "c0=%d;c1=c0/2; c2=c0/4; c3=c0/8;cb=c0%%2;cc=c0%%4; cd=c0%%8" % [c0],
    "bit_": [ (0..8).map { |e| "b%d=%d" % [e, ((c0/(2**e)) % 2)] } ].join(";"),
    "sca_": "s=(60..100).map{ |s| s };s0=s;s1=s;s2=s;s3=s;",
    #"sca_": "s=scale :Eb4, :super_locrian, num_octabes: 2;s0=s;s1=s;s2=s;s3=s;",
    "def": "off=50;t=2;n0=;n1=;n2=;p0=0;p1=0;p2=0",
    "exe": "@algX = cb % @algs.length; @alg_=@algs[@algX]",
    "_ply0": "play s0[n0], pan: p0, amp: 0.5 if n0",
    "_ply1": "play s1[n1], pan: p1, amp: 0.5 if n1",
    "_ply2": "play s2[n2], pan: p2, amp: 0.5 if n2",
    #"ply3": "play sca0[ton3], pan: pan3 if ton3",
    "_tim": "sleep (t*0.125).min(0.125)"
  }
  evals.each { |ti,ev|
    out_debug += [ ti.to_s+" "+ev ]
    print ti.to_s+" "+ev
    @b.eval(ev.gsub("=;", "=false;"))
    @b.eval(@alg_) if ti.to_s == "exe"
    #out += [ [" "],"   ["+mod+mod_c+"]: ["+ev.ljust(50)+"]" ] if mod+mod_c == ti.to_s
    #eval(ev, blo.binding)
  }
  
  out_dis = [ "    "+tit.center(len+2,'_')+"   "]
  add_last = 1
  if mod=="bit" then
    val = (0..8).map { |e| [ (0..(len-1)).map { |c| (c/(2**e)) % 2 == 1 ? "*" : " " }].join("") }
    val += [ (+" "*(c0%len+1)+"*") ]
  end
  if mod=="clo" then
    val, add_last = [ "c0=%10d" % [c0] ], 1
    val += (1..9).map { |k| v=2**k;
      "c%s=c0/%03d=%3d  c%s=c0%%%03d=%3d %s" %
      [k, v, c0/v, (k+10).to_s(32), v, c0%v, "*"*((c0%v)*32/v) ]
    }
  end
  if mod=="alg" then
    val, add_last = @algs.map { |v| v }, 2
  end
  val += [ mod+mod_c+": "+evals[(mod+mod_c).to_sym]] if add_last == 1
  val += [ mod+mod_c+("(%d): " % [@algX])+@alg_]  if add_last == 2
  val[-1] = val[-1][0..32] if val[-1].length > 64
  
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
  #val ü= out += [["   [alg_]: ["+@alg_.ljust(50)+"]" ], [" "] ]
  val.each_with_index { |v,ix| out_dis += [ " "+ix.to_s(32)+" | "+ v.ljust(len) +" | " ] }
  out_dis += [ "   |_"+"_"*len+"_|"]
  
  out = out_dis
  out_debug = [ "mod "+mod+mod_c  ]
  
  #
  out_help =  "0a [alg]orithm,1b [bit]s & beats,2c [clo]ck,3d [def]inition, 4e [exe]cute,5f [fx]".split(',')
  out_help +=  " w [swi]ing, g [ear]r, []".split(',')
  
  File.open("d:/LA-N19/dark_matter/lan19_modalg_seq01.log", "w") { |f| f.write([out].join("         \n")+"""
  joins of calc: ([def,clo]->[bit])->([exe]->([alg_,ply_,tim_,fx_])  

    _____   _____   _____   _____   _____   _____   _____ 
   |mod  | |lin  | |num  | |     | |  *  | |  /  | |     |
   |__(X)| |__(X)| |__(X)| |_____| |^____| |%____| |_____|
                            _____   _____   _____   _____ 
                           |  7  | |  8  | |  9  | |  -  |
                           |h_hlp| |i_tim| |j_oin| |&____|
                            _____   _____   _____   _____  
                           |  4  | |  5  | |  6  | |  +  |
                           |e_exe| |f_fx_| |g_ear| ||____|
            _____           _____   _____   _____   _____  
           |  ^  |         |  1  | |  2  | |  3  | |     |
           |__|__|         |b_bit| |c_clo| |d_def| |     |
    _____   _____   _____   _____   _____   _____  |   | |
   |  <  | |  |  | |  >  | |  (  | |  0  | |  )  | | <-' |
   |s_sca| |p_pan| |n_ote| |_____| |a_alg| |_____| |_____|

  """.sub("_"+mod+"|","<"+mod+">")+out_debug.join("\n") +[out_help].join("         \n")) }
end


