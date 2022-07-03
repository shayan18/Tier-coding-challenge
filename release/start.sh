RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
RESET="\033[0m"

if [ "$VERSION" = "" ]; then
  echo "$RED[release/start.sh]: Error! Variable VERSION not specified, use something like 'VERSION=1.0 release/start.sh' instead.$RESET"
  exit 1
fi

if ! [ -x "$(command -v brew)" ]; then
  echo "$YELLOW[release/start.sh]: Installing Homebrew ...$RESET"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if ! [ -x "$(command -v swift-sh)" ]; then
  echo "$YELLOW[release/start.sh]: Installing swift-sh ...$RESET"
  brew install swift-sh
fi

if [ "/Applications/Xcode.app/Contents/Developer" != $(xcode-select -p) ]; then
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
fi

echo "$YELLOW[release/start.sh]: Installing git-flow ...$RESET"
brew install git-flow
git flow init -d

echo "$YELLOW[release/start.sh]: Pulling latest versions from origin ...$RESET"
git stash
git checkout versions
git pull origin

echo "$YELLOW[release/start.sh]: Pulling lastest main from origin ...$RESET"
git checkout main
git pull origin

echo "$YELLOW[release/start.sh]: Start a new release with git-flow ...$RESET"
git flow release start $VERSION

echo "$YELLOW[release/start.sh]: Bump version num & finalize new Changelog section + committing ...$RESET"
sed -i '' -e "s/MARKETING_VERSION = .*/MARKETING_VERSION = $VERSION;/" Mobility.xcodeproj/project.pbxproj
release/changelog.swift $VERSION
git add Mobility.xcodeproj/project.pbxproj CHANGELOG.md
git commit -m "Bump version num & finalize new Changelog section" -n

echo "$YELLOW[release/start.sh]: Push release branch to remote ...$RESET"
git push origin release/$VERSION

echo "$GREEN[release/start.sh]: Release successfully started! 🚀🚀🚀 Checkout deployment status on GitHub:$RESET"
echo "$GREEN[release/start.sh]: https://github.com/shayan18/Tier-coding-challenge/actions?query=workflow%3ARelease$RESET"
echo "[release/start.sh]: ----------"
echo "$YELLOW[release/start.sh]: Once deploy is successful, finish the release in Git-Fork & push main + versions.$RESET"
