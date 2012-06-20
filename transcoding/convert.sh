mkdir "$1d"
mv "$1" "$1d"/
cd "$1d"

#ffmpeg -i "$1" -an -pass 1 -vcodec libx264 -vpre slow_firstpass -b:v 950k -bt 10000k -threads 0 "$1.1.flv"
#ffmpeg -i "$1" -acodec libfaac -vol 1024 -pass 2 -vcodec libx264 -vpre slow -b:v 950k -bt 10000k -b:a 128k -threads 0 "$1.2.flv"

filename=$1
extension=${filename##*.}

if [ "$extension" = "mp4" ]
then
        ffmpeg -i "$1" -acodec copy -vcodec copy -threads 0 "$1.2.flv"
elif [ "$extension" = "mkv" ]
then
        ffmpeg -i "$1" -acodec libfaac -ar 22050 -ac 2 -vcodec copy -b:a 128k -threads 0 "$1.2.flv"
else
        ffmpeg -i "$1" -acodec libfaac -ar 22050 -ac 2 -vcodec libx264 -vprofile high -preset slow -crf 24 -b:a 128k -threads 0 "$1.2.flv"
fi


cd ..
mv "$1d/$1.2.flv" "$1.3.flv"
rm -r "$1d"

#MP4Box -inter 500 "$1.2.mp4"
yamdi -i "$1.3.flv" -o "$1.2.flv"
rm "$1.3.flv"

