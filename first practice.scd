play{SinOsc.ar(OnePole.ar(Mix(
LFSaw.ar([1],[0,-2],3000,2000,).trunc([400,600,105])*[1,-1,]
),0.98)).dup*1.48*2*4
* XLine.kr(5, 0.8,-2)
//* PinkNoise.ar(0.1 + 0.15)
}


play{SinOsc.ar(OnePole.ar(Mix(
LFSaw.ar([1],[0],2000).trunc([400,600,1080])*[1,-1,0]
),0.98)).dup*2}

play{SinOsc.ar(OnePole.ar(Mix(
LFSaw.ar([1],[0],1000,10).trunc([100,600])*[-1]
),0.98)).dup*.80}

play{SinOsc.ar(MouseX.kr(1, 100));
        SinOsc.ar(300 + 800, 0, 0.1)
        +
        PinkNoise.ar(0.1 + 0.1)}

(
SynthDef(\gabberkick, {
    var snd, freq, high, lfo;
    freq = \freq.kr(440) * (Env.perc(0.001, 0.08, curve: -1).ar * 48 * \bend.kr(1)).midiratio;
    snd = Saw.ar(freq);
    snd = (snd * 100).tanh + ((snd.sign - snd) * -8.dbamp);
    high = HPF.ar(snd, 300);
    lfo = SinOsc.ar(8, [0, 0.5pi]).range(0, 0.01);
    high = high.dup(2) + (DelayC.ar(high, 0.01, lfo) * -2.dbamp);
    snd = LPF.ar(snd, 100).dup(2) + high;
    snd = RLPF.ar(snd, 7000, 2);
    snd = BPeakEQ.ar(snd, \ffreq.kr(3000) * XLine.kr(1, 0.8, 0.3), 0.5, 15);
    snd = snd * Env.asr(0.001, 1, 0.05).ar(2, \gate.kr(1));
    Out.ar(\out.kr(0), snd * \amp.kr(0.1));
}).add;