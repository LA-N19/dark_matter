' dm6_dark_kick
  L.A. N19 / 23.8.2021 / Daniel Mueller 
'
b_kick = b_ping_in = b_ping = b_click = b_dark = b_guitar = b_growl = b_zick = false
final_stop = false

# kick notes-slide, panning.. for kick i=1 (short and less drop slide, bit shorter release), i=2 -> full kick
def my_kick(i)
  c1 = play 50+12, slide: 0.05, pan: -0.75, release: [0.9, 1][i%2] #d4
  c2 = play 50.1+12, slide: 0.05, pan: 0.75, release: [0.9, 1][i%2]#, attack: 0.1, release: 0.1
  control c1, note: 50.1, slide: [0.3, 0.5][i%2] # fast slide to d3 and then decrease slide speed regarding double punch (i%2=1-->0.3) or not (i%2=0-->0.5)
  control c2, note: 50, slide: [0.3, 0.5][i%2]
  control c1, note: [12, 0.1][i%2], pan: 0.25
  control c2, note: [12.1, 0][i%2], pan: -0.25
end

with_fx :reverb, mix: 0.2 do #a tiny bit more
  with_fx :distortion do #
live_loop :kick do
      #with_synth :fm do # may not: if its done good: sine wave might be enough
      use_synth_defaults divisor: 1.1, depth: 0.2
      4.times { |i|
        my_kick(i) if b_kick
        with_fx :slicer, phase: 0.04 do play 40, decay: 0.3, release: 0; end if b_growl
        if i%2==1 and b_zick then
          sleep 0.75
          with_synth :cnoise do
            play 1111, attack: 0.0125, release: 0, amp: 0.2, pan: 0, cutoff: 130
            sleep 0.25
            play 1111, attack: 0.0125, release: 0, amp: 0.2, pan: 0, cutoff: 130
          end
          sleep 0.125
        else
          sleep 1
        end
        with_fx :slicer, phase: 0.04 do play 40, decay: 1, release: 0 ; end if b_growl
        
        if i%2==1 then
          if b_zick then
            sleep 1
            with_synth :cnoise do
              play 1111, attack: 0.025, release: 0, amp: 0.2, pan: 1, cutoff: 130
              sleep 0.125
              play 90, attack: 0.021, release: 0, amp: 0.3, pan: 0
              sleep 0.125
              play 90, attack: 0.021, release: 0, amp: 0.4, pan: -1
              sleep 0.75
            end
          else sleep 2; end
        end
        stop if final_stop
      }     
end end end

# kick shadow 1: crispy + overpressure exhaust click
live_loop :x1 do
  with_fx :normaliser, mix: 1, amp: 0.02, amp_slide: 2 do |fx_n|
    with_fx :reverb, mix: 0.15 do 
       with_synth :blade do
        with_fx :bitcrusher, bits: 6, sample_rate: 909 do
          4.times {
            2.times { |i|
              if b_click then
                c = play [50, 50.1], note_slide: [0.3, 0.5][i]
                control c, note: 0
              end
              my_kick(i) if b_click
              sleep 1
            }
            control fx_n, amp: 1
            sleep 2
            stop if final_stop
          }
end end end end end

#kick shadow 1: dark void echo
live_loop :x2 do
    with_fx :normaliser, mix: 1, amp: 0.05, amp_slide: 2 do |fx_n|
      with_fx :distortion do
        with_fx :reverb, mix: 0.15 do  with_synth :blade do
          4.times { |ii|
            2.times { |i|
              if b_dark then
                c = play [50, 50.1], note_slide: [0.3, 0.5][i]
                control c, note: 0
              end
              
              play 50+46+rrand(0.0, 0.2), amp: 0.1, attack: 1, release: 0 if ii==1 and b_ping
              sleep 1
              play 50+48+rrand(0.0, 0.2), release: 0.01 if ii==1 or i==2 and b_ping
              play 40, attack: 0.5, release: 1 if ii==3 and b_guitar
              
            }
            control fx_n, amp: 1 if b_dark
            sleep 2
            stop if final_stop
  }
end end end end end



'''
part 1 - 
the following effects will be tested:
  * no root note (mi7 - root) --> thiner, but colourfull anyway (gehirn denkt sich den fehlenden ton dazu)
  * destructive a la moree effect
'''
n = 50 - 12*2
c_o = 0
c_i = 1
c =  (0..(6*4-1)).map { play 0, attack: 1, decay: 200, sustain: 40, pan_slide: 0.25, note_slide: 0.1, amp_slide: 0.4 }
with_fx :slicer do |fx_slice|
  live_loop :whoooooble do
    sleep rrand(0.45, 0.5)
    #print "c1(n%d.2, p%d.2) c2(n%d.2, p%d.2)" % [n1=n+rrand(-0.6, 0.4), p1=rrand(-1, 1), n2=n+rrand(-0.4, 0.4), p2=rrand(-1, 1)]
    a = chord(n, :minor7) #+ chord(n, :minor7).each { |xx| xx+12 }
    a.each.with_index { |no, ii|
      next if c_i < ii
      control c[ii*4]  , note: no+rrand(-0.6, 0.4), pan: r=rrand(-1, 1), amp: c_o > 0 ? rrand(0.2, 0.3) : rrand(0.2, 0.5)
      control c[ii*4+1], note: no+rrand(-0.6, 0.4), pan: r*-1, amp: c_o > 0 ? rrand(0.2, 0.3) : rrand(0.2, 0.5)
      control c[ii*4+2], note: no+12+rrand(-0.6, 0.4), pan: r=rrand(-1, 1), amp: c_o > 0 ? 0 : rrand(0.2, 0.3)
      control c[ii*4+3], note: no+12+rrand(-0.6, 0.4), pan: r*-1, amp: c_o > 0 ? 0 : rrand(0.2, 0.3)
      control c[ii*4+4], note: no+24+rrand(-0.6, 0.4), pan: r=rrand(-1, 1), amp: c_o > 1 ? 0 : rrand(0.2, 0.3)
      control c[ii*4+5], note: no+24+rrand(-0.6, 0.4), pan: r*-1, amp: c_o > 1 ? 0 : rrand(0.2, 0.3)
      control fx_slice, mix: [0, 0.5, 1].choose
      stop if final_stop
    }
end end

sleep 4
dki=0
bpm_old=60
live_loop :w_ctrl do
  o= 12*(((dki/2)%4)-2); bpm_new=bpm_old; bpm_new=(70+o/3.0).round
  print  "#"*30, dki, o, "bpm: ", bpm_old, "-->", bpm_new, "#"*30
  use_bpm 0.8*bpm_old + 0.2*bpm_new
  n = 52 + o
  sleep 2
  use_bpm 0.6*bpm_old + 0.4*bpm_new
  n = 53 + o
  sleep 2
  use_bpm 0.4*bpm_old + 0.6*bpm_new
  n = 50 + o
  sleep 4
  use_bpm 0.2*bpm_old + 0.8*bpm_new
  dki+=1
  stop if final_stop
end
#sleep 10

print 0; c_o = 1; sleep 12; b_kick = true
print 1; c_o = 0; sleep 12; b_kick = true
print 2; c_o = 1; sleep 6;  b_zick = true
'
2.times {
  print 3; c_o = 0; sleep 6;  b_ping_in = b_ping = b_click =  b_dark = true
  print 4; sleep 12; b_guitar = b_growl = true; b_ping_in = b_ping = b_click =  b_dark = b_zick = false
  print 5; sleep 12; b_ping_in = b_ping = true; b_guitar = b_growl = b_kick = b_click =  b_dark = b_zick = false
  print 6; sleep 12; b_ping_in = b_ping = b_growl = b_kick = b_click =  b_dark = b_zick = true;  b_guitar = false
  print 7; sleep 6; b_ping = b_growl = b_kick = b_click =  b_dark = b_zick = false; b_ping_in = true
  print 8; sleep 6; b_ping = true; b_ping_in = false
  print 10; sleep 6; c_o = 1; b_ping = false;
  print 11; sleep 12; c_o = 2; b_zick = b_growl = true;
}
'
b_zick = b_growl = false;
final_stop = true
sleep 2
c.each { |ctrl| kill ctrl; sleep 1 }
sleep 2
