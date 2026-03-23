local M = {}

local palettes = require("catppuccin.palettes")
local palette = palettes.get_palette("frappe")

M.palette = palette

-- 16進カラーコード (#rrggbb) を RGB のテーブル {r, g, b} に変換
local function hex_to_rgb(hex_value)
	local hex_string

	if type(hex_value) == "number" then
		-- 例: 0xffffff → "#ffffff"
		hex_string = string.format("#%06x", hex_value)
	else
		hex_string = tostring(hex_value)
	end

	hex_string = hex_string:gsub("#", "")

	return {
		tonumber(hex_string:sub(1, 2), 16), -- 赤
		tonumber(hex_string:sub(3, 4), 16), -- 緑
		tonumber(hex_string:sub(5, 6), 16), -- 青
	}
end

-- RGB テーブル {r, g, b} を16進カラーコード (#rrggbb) に変換
local function rgb_to_hex(rgb)
	return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

-- 2つの色 (前景色と背景色) を透過率 alpha で合成した結果を返す
-- alpha: 0.0 = 完全に背景色, 1.0 = 完全に前景色
function M.blend_with_opacity(foreground_hex, background_hex, alpha)
	local fg_rgb = hex_to_rgb(foreground_hex)
	local bg_rgb = hex_to_rgb(background_hex)

	local blended_rgb = {
		math.floor((1 - alpha) * bg_rgb[1] + alpha * fg_rgb[1] + 0.5),
		math.floor((1 - alpha) * bg_rgb[2] + alpha * fg_rgb[2] + 0.5),
		math.floor((1 - alpha) * bg_rgb[3] + alpha * fg_rgb[3] + 0.5),
	}

	return rgb_to_hex(blended_rgb)
end

return M
