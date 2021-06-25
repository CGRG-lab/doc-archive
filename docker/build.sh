docker rmi -f cgrg/mkdocs:0.1.0

cp ../requirements.txt .
docker build -t cgrg/mkdocs:0.1.0 -f Dockerfile .
rm requirements.txt