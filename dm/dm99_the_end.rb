
with_fx :echo, phase: 1/6.0 do
  with_fx :bitcrusher, bits: 1, sample_rate: 3, mix: 0.4 do
    with_fx :panslicer, phase: 0.1 do
      with_fx :slicer do
        live_loop :bam do
          8.times {
            synth :organ_tonewheel, sustain: 1, note: scale(:a, :major_pentatonic).choose
            sleep 1
          }
          sleep 2
        end
    end end
    live_loop :bam2 do
      with_fx :panslicer, phase: 0.1, invert_wave: 1 do
        with_fx :slicer, invert_wave: 1 do
          8.times {
            synth :organ_tonewheel, sustain: 1, note: scale(:a, :major_pentatonic).choose
            sleep 1
          }
          sleep 2
        end
    end end
  end
end

