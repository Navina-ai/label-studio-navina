SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if docker build -t heartexlabs/label-studio "${SCRIPT_DIR}/.."; then
  docker run -it -p 8080:8080 -v "$(pwd)/mydata:/label-studio/data" heartexlabs/label-studio
else
  echo "Docker build failed."
fi
