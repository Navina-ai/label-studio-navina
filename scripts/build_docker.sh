SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker build -t heartexlabs/label-studio "${SCRIPT_DIR}/.."
