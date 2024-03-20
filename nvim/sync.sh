#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_CONF_DIR="${HOME}/.config/nvim"

ln -fnsv "${SCRIPT_DIR}/init.lua" "${NVIM_CONF_DIR}/init.lua"
ln -fnsv "${SCRIPT_DIR}/lazy-lock.json" "${NVIM_CONF_DIR}/lazy-lock.json"

LUA_DIR="${NVIM_CONF_DIR}/lua"

mkdir "${LUA_DIR}"
ln -fnsv "${SCRIPT_DIR}/lua/base.lua" "${LUA_DIR}/base.lua"

mkdir "${LUA_DIR}/plugins"
for lua_file in "${SCRIPT_DIR}"/lua/plugins/*.lua; do
    file_name=$(basename "${lua_file}")
    ln -fnsv "${lua_file}" "${LUA_DIR}/plugins/${file_name}"
done
