set -e

DOCKERPUSH=0
ARCHITECTURE=""
while [ -n "$1" ]; do 
    case "$1" in
    --dockerpush) 
        DOCKERPUSH=1 ;; 
    --arch)
        ARCHITECTURE="$2" shift;;      
    esac 
    shift
done

docker build -t shukriadams/cifs-client .
echo "container built"

# no need to smoke test container, it's a binary package only

if [ $DOCKERPUSH -eq 1 ]; then
    echo "starting docker push"
    TAG=$(git describe --tags --abbrev=0) 
    echo "Tag ${TAG} detected"

    docker tag shukriadams/cifs-client:latest shukriadams/cifs-client:"${TAG}${ARCHITECTURE}"
    docker login -u $DOCKER_USER -p $DOCKER_PASS 
    docker push shukriadams/cifs-client:$TAG$ARCHITECTURE

    echo "container pushed"
fi
