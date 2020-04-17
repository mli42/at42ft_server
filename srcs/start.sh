docker build . -t me
docker run -p 80:80 -p 443:443 --name meme me
