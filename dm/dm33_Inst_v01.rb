' dm44.rb / 11.11.2023 '
require 'date'
sca = scale :c, :major_pentatonic, num_octaves: 3
print(sca.length)
use_synth_defaults slide: 0.25, amp: 0.1
"
-> c[0..4]
  ->p[0..7]
"
#fname = "C:/Users/Mulacke/Google Drive/Proj/2021_sonic_pi/_dm/dm44/dm44_"+Date.today.strftime("%Y%m%d")+'_c1.lan19_dm44'
fname = "C:/Users/Mulacke/Google Drive/Proj/2021_sonic_pi/_dm/dm44/dm44_"+Date.today.strftime("%Y%m%d")+'.lan19_dm44'
cha = 0


dmk = {
  #    "/midi:dmk25_0:1/control_change"
  "c"=>{"~": 15, "<<": 16, ">>": 17, "[]":18, ">": 19, "()": 20},
  #     p0  p1 p2 p3 p4 p5 p6 p7 p8   /midi:dmk25_0:10/note_on
  "p"=>[nil,36,38,42,46,49,45,41,51],
  #     k0  k1 k2 k3 k4               /midi:dmk25_0:1/control_change"
  "k"=>[nil,10,91,93,73],
  "s"=>[ 7,],
}
no= {}
fx= { "pp"=>{}, "bit"=> {} }
pats_clear = [[ ],[ ],[ ],[ ],[ ],[ ], [ ], [ ]]
pats, padi = pats_clear, 0
sam_drum=Hash[dmk["p"].zip([:drum_bass_hard, :drum_bass_soft, :drum_cowbell, :drum_cymbal_closed, :drum_cymbal_open, :drum_cymbal_pedal, :drum_cymbal_soft, :drum_heavy_kick, :drum_snare_hard, :drum_snare_soft])]
sam=sam_drum
vt = nil
print(sam)
# sample_names :drum: ring(:drum_bass_hard, :drum_bass_soft, :drum_cowbell, :drum_cymbal_closed, :drum_cymbal_hard, :drum_cymbal_open, :drum_cymbal_pedal, :drum_cymbal_soft, :drum_heavy_kick, :drum_roll, :drum_snare_hard, :drum_snare_soft, :drum_splash_hard, :drum_splash_soft, :drum_tom_hi_hard, :drum_tom_hi_soft, :drum_tom_lo_hard, :drum_tom_lo_soft, :drum_tom_mid_hard, :drum_tom_mid_soft)
#print sample_names :drum
#stop
no = { }

with_fx :normaliser, phase: 1, mix: 0.1 do |fx_norm|
  # sample_names :drum: ring(:drum_bass_hard, :drum_bass_soft, :drum_cowbell, :drum_cymbal_closed, :drum_cymbal_hard, :drum_cymbal_open, :drum_cymbal_pedal, :drum_cymbal_soft, :drum_heavy_kick, :drum_roll, :drum_snare_hard, :drum_snare_soft, :drum_splash_hard, :drum_splash_soft, :drum_tom_hi_hard, :drum_tom_hi_soft, :drum_tom_lo_hard, :drum_tom_lo_soft, :drum_tom_mid_hard, :drum_tom_mid_soft)
  #print sample_names :drum
  #stop
  
  with_fx :gverb, mix: 1, tail_level: 0.1 do |fx_verb|
    with_fx :bitcrusher do |fx_bit|
      #
      '''
      live_loop :dru do
        sam2=sample_names :drum
        dpat=".161"*3+"6611"#
        #dpat="a66"+"166"*3
        dpat.split("").each { |n|
          sample sam2[n.to_i(32)], amp: 0.1
          # sleep 0.125
          sleep 0.125
        }
      end #'''
      with_fx :ping_pong do |fx_pp|
        live_loop :pad do
          n, v = sync "/midi:dmk25_0:10/note_on"
          print(pad = dmk["p"].index(n))
          padi = pad - 1 if pad < 5
        end
        
        live_loop :fx do
          n,v = sync "/midi:dmk25_0:1/control_change"
          a = (v+1)/140.0
          if v > 0 then
            pats, vt = pats_clear, 0 if n==dmk["c"]["()"]
            if n==dmk["c"]["[]"] then
              
            end
          end
          control fx_norm, mix: a if n == 10 #k1
          control fx_verb, mix: a if n == 91 #k2
          control fx_pp, phase: a if n == 93 #k3
          control fx_bit, bit: (v+1) if n == 73 #k4
        end
        live_loop :notes do
          n,v = sync "/midi:dmk25_0:1/note*"
          a = v/140.0
          print n, v
          pats[padi].append([n,v])
          if v > 0 then
            no[n] = play n, amp: a, sustain: 100
          elsif no[n] then
            control no[n], amp: 0
            kill no[n]
            no[n] = nil
          end
end end end end end

