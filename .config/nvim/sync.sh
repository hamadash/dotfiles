#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_CONF_DIR="${HOME}/.config/nvim"

rm -rf "${NVIM_CONF_DIR}/"{,.[!.],..?}*

ln -fnsv "${SCRIPT_DIR}/init.lua" "${NVIM_CONF_DIR}/init.lua"
ln -fnsv "${SCRIPT_DIR}/lazy-lock.json" "${NVIM_CONF_DIR}/lazy-lock.json"
ln -fnsv "${SCRIPT_DIR}/lazyvim.json" "${NVIM_CONF_DIR}/lazyvim.json"

LUA_DIR="${NVIM_CONF_DIR}/lua"
mkdir "${LUA_DIR}"

LUA_CONF_DIR="${LUA_DIR}/config"
mkdir "${LUA_CONF_DIR}"
for lua_file in "${SCRIPT_DIR}"/lua/config/*.lua; do
    file_name=$(basename "${lua_file}")
    ln -fnsv "${lua_file}" "${LUA_CONF_DIR}/${file_name}"
done

LUA_PLUGINS_DIR="${LUA_DIR}/plugins"
mkdir "${LUA_PLUGINS_DIR}"
for lua_file in "${SCRIPT_DIR}"/lua/plugins/*.lua; do
    file_name=$(basename "${lua_file}")
    ln -fnsv "${lua_file}" "${LUA_PLUGINS_DIR}/${file_name}"
done

LUA_UTIL_DIR="${LUA_DIR}/util"
mkdir "${LUA_UTIL_DIR}"
for lua_file in "${SCRIPT_DIR}"/lua/util/*.lua; do
    file_name=$(basename "${lua_file}")
    ln -fnsv "${lua_file}" "${LUA_UTIL_DIR}/${file_name}"
done

