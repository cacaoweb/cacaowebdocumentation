
mkdir "$1d"
mv "$1" "$1d"/
cd "$1d"

ffmpeg -i "$1" -an -pass 1 -vcodec libx264 -vprofile high -preset slow -b:v 850k -threads 0 "$1.1.flv"
ffmpeg -i "$1" -acodec libfaac -vol 1024 -pass 2 -vcodec libx264 -vprofile high -preset slow -b:v 850k -b:a 128k -threads 0 "$1.2.flv"

cd ..
mv "$1d/$1.2.flv" "$1.3.flv"
rm -r "$1d"

yamdi -i "$1.3.flv" -o "$1.2.flv"
rm "$1.3.flv"
