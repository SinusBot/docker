#!/bin/bash

set -ex

VERSION="$1"

if [[ -z "$VERSION" ]]; then
    echo "Usage: ./release_version.sh <version>"
    exit 1
fi

echo "Version: $VERSION"

IMAGE=sinusbot/docker

read -p "Pull from git? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^([Yy]| ) ]] || [[ -z $REPLY ]]; then
    git pull
fi

echo "Replacing version in files..."
sed -i '' "s|^SINUSBOT_VERSION=.*|SINUSBOT_VERSION=\"$VERSION\"|g" discord/install.sh
sed -i '' "s|^LABEL version.*|LABEL version=\"$VERSION\"|g" discord/Dockerfile
sed -i '' "s|^FROM sinusbot.*|FROM $IMAGE:$VERSION-discord|g" Dockerfile
sed -i '' "s|^LABEL version.*|LABEL version=\"$VERSION\"|g" Dockerfile

read -p "Show diff? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^([Yy]) ]]; then
    git diff
fi

read -p "Commit changes? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^([Yy]| ) ]] || [[ -z $REPLY ]]; then
    git add -A
    git commit -m "v$VERSION"
    git tag -a "v$VERSION" -m "v$VERSION"
fi

read -p "Push to git? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^([Yy]| ) ]] || [[ -z $REPLY ]]; then
    git push
    git push --tags
fi

read -p "Build images? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^([Yy]| ) ]] || [[ -z $REPLY ]]; then
    docker pull debian:buster-slim
    docker build --platform linux/amd64 -t "$IMAGE":"$VERSION"-discord discord
    docker build --platform linux/amd64 -t "$IMAGE":"$VERSION" .

    read -p "Push the builds to docker? (requires docker login) [Y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^([Yy]| ) ]] || [[ -z $REPLY ]]; then
        docker push "$IMAGE":"$VERSION"-discord
        docker push "$IMAGE":"$VERSION"
    fi
fi
