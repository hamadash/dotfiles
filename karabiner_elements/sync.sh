#!/bin/zsh

BASE_JSON_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_KARABINER_DIR="${HOME}/.config/karabiner"

COMPLEX_MODIFICATIONS_JSONS_DIR="${BASE_JSON_DIR}/complex_modifications"
KARABINER_COMPLEX_MODIFICATIONS_DIR="${CONFIG_KARABINER_DIR}/assets/complex_modifications"

# Link karanier.json
ln -fnsv "${BASE_JSON_DIR}/karabiner.json" "${CONFIG_KARABINER_DIR}/karabiner.json"

# Link complex_modifications json
mkdir -p "${KARABINER_COMPLEX_MODIFICATIONS_DIR}"

for json_file in "${COMPLEX_MODIFICATIONS_JSONS_DIR}"/*.json; do
  ln -fnsv "${json_file}" "${KARABINER_COMPLEX_MODIFICATIONS_DIR}/$(basename "${json_file}")"
done
