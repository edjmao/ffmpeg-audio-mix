#!/bin/sh

VIDEO_IN=$1
AUDIO_IN=$2

AUDIO_ORIG=$1.mp3
AUDIO_MIXED=$1-mixed.mp3
VIDEO_ONLY=$VIDEO_IN.noaudio.mp4
VIDEO_MIXED=$VIDEO_IN.mixed.mp4

ffmpeg -i $VIDEO_IN -vn -ac 1 -filter:a "volume=-20dB" -f mp3 $AUDIO_ORIG
ffmpeg -i $AUDIO_ORIG -i $AUDIO_IN -filter_complex amix=inputs=2:duration=first:dropout_transition=2 $AUDIO_MIXED
ffmpeg -i $VIDEO_IN -codec copy -an $VIDEO_ONLY
ffmpeg -i $VIDEO_ONLY -i $AUDIO_MIXED -shortest -c:v copy -c:a copy $VIDEO_MIXED
