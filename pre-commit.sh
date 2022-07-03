RED="\033[0;31m"
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
RESET="\033[0m"

if ! [ -x "$(command -v brew)" ]; then
  echo "$YELLOW[pre-commit.sh]: Installing Homebrew ...$RESET"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if ! [ -x "$(command -v swift-sh)" ]; then
  echo "$YELLOW[pre-commit.sh]: Installing swift-sh ...$RESET"
  brew install swift-sh
fi

if ! [ -x "$(command -v anylint)" ]; then
  echo "$YELLOW[pre-commit.sh]: Installing AnyLint ...$RESET"
  brew tap Flinesoft/AnyLint https://github.com/Flinesoft/AnyLint.git
  brew install anylint
fi

if ! [ -x "$(command -v mint)" ]; then
  echo "$YELLOW[pre-commit.sh]: Installing Mint ...$RESET"
  brew install mint
fi

if ! [ -x "$(command -v swift-format)" ]; then
  echo "$YELLOW[pre-commit.sh]: Installing swift-format ...$RESET"
  mint install apple/swift-format
fi

if [ "/Applications/Xcode.app/Contents/Developer" != $(xcode-select -p) ]; then
  echo "$YELLOW[pre-commit.sh]: Setting the Xcode developer path ...$RESET"
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
fi

echo "$YELLOW[pre-commit.sh]: Configuring git pre-commit hook ...$RESET"
mkdir -p .git/hooks
touch .git/hooks/pre-commit
echo "swift-format format --in-place --recursive Mobility/Sources Tests/Sources lint.swift && anylint" > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

echo "$YELLOW[pre-commit.sh]: Configuration was successful! 🎉$RESET"
