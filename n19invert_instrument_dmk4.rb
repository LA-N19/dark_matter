'
 n19v4_dmk.rb / 18.5.2021

   XX       XXXX     XXX   XX   XXX   XXX     L.A. n19 - home brew sonic engineering (6.5.2021 / Daniel M�ller)
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
            #       znvADSRadsr (TODO: adsr-klein ist noch nicht programmiert... lautst�rke bei adsr )
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
end end end





