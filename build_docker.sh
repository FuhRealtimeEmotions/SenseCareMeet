REGISTRY="dennismaier"
project_root=$(realpath $0 )
echo $project_root
compose_yaml="$( dirname -- "$project_root"; )""/docker-composeTest.yml"
docker build -f ./Dockerfile_base --tag edumeetbase:latest .
docker compose -f $compose_yaml build  --no-cache
docker compose -f $compose_yaml up # --no-cache