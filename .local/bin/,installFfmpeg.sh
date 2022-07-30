#!/usr/bin/env bash

cd /tmp

wget "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz"
wget "https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz.md5"
md5result=$(md5sum -c ffmpeg-release-amd64-static.tar.xz.md5)

if echo "$md5result" | grep -q ": OK"; then
	echo "md5 sum passed"
else
	echo "md5 sum FAILED"
	exit 1
fi

ffmpegFILE=$(tar -tf ffmpeg-release-amd64-static.tar.xz | egrep '/ffmpeg$')
ffprobeFILE=$(tar -tf ffmpeg-release-amd64-static.tar.xz | egrep '/ffprobe$')

if [ -z "$ffmpegFILE" ]; then
	echo "ffmpeg file not found in tar"
	exit 1
fi
if [ -z "$ffprobeFILE" ]; then
	echo "ffprobe file not found in tar"
	exit 1
fi

tar -xf ffmpeg-release-amd64-static.tar.xz
cp "$ffmpegFILE" /home/user/.local/bin/ffmpeg
cp "$ffprobeFILE" /home/user/.local/bin/ffprobe

