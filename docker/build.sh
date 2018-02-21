#!/usr/bin/env bash
build_init=false
build_prod=false
build_docker=false
build_all=true

while :
do
    case "$1" in
      -h | --help)
          cat <<EOF
          Собираем FootCourtProxy
          Ключи:
              -i - npm run init
              -p - npm run production
              -d - запаковать в docker image
          По умолчанию: все действия
EOF
          exit 0
          ;;
      -i)
          build_init=true
          build_all=false
          shift # past argument
          ;;
      -p)
          build_prod=true
          build_all=false
          shift # past argument
          ;;
      -d)
          build_docker=true
          build_all=false
          shift # past argument
          ;;
      *)  # No more options
      break
      ;;
    esac
done

WORKDIR=$(pwd)
echo "*! Run from ./FootCourtProxy"
echo "** current directory: $WORKDIR"

if ${build_docker} || ${build_all}; then
    if [ -z "$VERSION" ]; then
       read -r -p "** Please, enter version: dgls/footcourtproxy-`uname -m`:" VERSION
    fi
fi

if ${build_init} || ${build_all}; then
    docker run -t --rm \
                    -v "$WORKDIR":"/var/www/FootCourtProxy" \
                    -w "/var/www/FootCourtProxy/" \
                    dgls/node-base:1.0.0 \
                    sh -c \
                    "npm run init"
fi

if ${build_prod} || ${build_all}; then
    docker run -t --rm \
                    -v "$WORKDIR":"/var/www/FootCourtProxy" \
                    -w "/var/www/FootCourtProxy/" \
                    dgls/node-base:1.0.0 \
                    sh -c \
                    "npm run production"
fi

if ${build_docker} || ${build_all}; then
    (cd docker/final_image; ./export_in_docker_image.sh ${VERSION})
fi
