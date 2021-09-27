# speexdsp-test
Test SpeexDSP echo cancellation 

The purpose of this repository is to show the results obtained by running the acoustic echo canceller (AEC) proposed in the SpeexDSP library.
The matlab script has been provided in [this repo](https://github.com/nay0648/unified2021/tree/master/Experiment/Speex-AEC-matlab-master).

## Description

`test_aec.m` runs the AEC aglorithm on three scenarios:
- farend speech single talk (source 1)
- nearend speech single talk (source 2)
- double talk (source 3)

To find the configuration that gives the best results, different configuration of `delay [d]` (on the nearend mic signal), `frame size [fs]`, and `filter length [fl]` have been tested.

The obtained error signals can be found in `data/output`. Each filename contains the information above. 
