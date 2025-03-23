local M = {}

local palettes = require("catppuccin.palettes")
local palette = palettes.get_palette("frappe")

M.palette = palette

-- TODO: 全然理解せずに書いてる、後で理解し直す。
local function hex_to_rgb(s)
	if type(s) == "number" then
		s = string.format("#%06x", s)
	end
	s = tostring(s):gsub("#", "")
	return {
		tonumber(s:sub(1, 2), 16),
		tonumber(s:sub(3, 4), 16),
		tonumber(s:sub(5, 6), 16),
	}
end

local function rgb_to_hex(rgb)
	return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end

function M.opacity(hex, base, a)
	local fg = hex_to_rgb(hex)
	local bg = hex_to_rgb(base)
	local blended = {
		math.floor((1 - a) * bg[1] + a * fg[1] + 0.5),
		math.floor((1 - a) * bg[2] + a * fg[2] + 0.5),
		math.floor((1 - a) * bg[3] + a * fg[3] + 0.5),
	}
	return rgb_to_hex(blended)
end

return M
