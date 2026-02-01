local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

local M = {}

--[[
workspaces.json を .config/wezterm に以下のように用意すると、workspace をプリセットできる。
workspaces.json の記載例:
{
  "workspace_key": {
    "name": "workspace_name",
    "cwd": "~/path/to/directory",
    "setup": {
      "panes": [
        {
          "commands": ["nvim"]
        },
        {
          "split": {
            "direction": "Right",  // "Right", "Left", "Top", "Bottom"
            "size": 0.6            // 0.0 〜 1.0 の範囲で分割サイズを指定
          },
          "commands": ["git status", "ls"]
        },
        {
          "split": {
            "direction": "Bottom",
            "size": 0.3
          }
          // commands は省略可能
        }
      ]
    }
  },
  "simple_workspace": {
    "name": "simple",
    "cwd": "~/projects/simple"
    // setup は省略可能
  }
}

注意:
- "cwd" は ~ で始めることで home_dir に展開される。
- "setup" フィールドは省略可能。
- "panes" 配列の最初の要素は既存の pane を使用する。 (split なし)
- 2番目以降の pane では "split" を指定して新しい pane を作成する。
- "commands" は各 pane で実行するコマンドの配列。 (省略可能)
- "commands" で定義したコマンドは、対応する pane で順番に実行される。
--]]

local function decode_json(json_string)
	local success, result = pcall(wezterm.json_parse, json_string)
	if success then
		return result
	else
		wezterm.log_error("JSON parse error: " .. tostring(result))
		return nil
	end
end

-- JSON ファイルから workspace 設定を読み込む
local function load_workspaces_from_json()
	local config_dir = wezterm.config_dir
	local json_path = config_dir .. "/workspaces.json"

	local file = io.open(json_path, "r")
	if not file then
		wezterm.log_error("Failed to open workspaces.json")
		return {}
	end

	local content = file:read("*all")
	file:close()

	local workspaces_data = decode_json(content)
	if not workspaces_data then
		return {}
	end

	return workspaces_data
end

-- setup 設定から関数を動的に生成
local function create_setup_function(setup_config)
	if not setup_config then
		return nil
	end

	return function(window, pane)
		if not setup_config.panes then
			return
		end

		local current_pane = pane

		for i, pane_config in ipairs(setup_config.panes) do
			-- 最初の pane 以外は split を実行
			if i > 1 and pane_config.split then
				current_pane = current_pane:split({
					direction = pane_config.split.direction,
					size = pane_config.split.size,
				})
			end

			-- commands を実行
			if pane_config.commands then
				for _, command in ipairs(pane_config.commands) do
					current_pane:send_text(command .. "\n")
				end
			end
		end
	end
end

-- JSON から読み込んだ設定を M.workspaces に展開
local function build_workspaces()
	local workspaces_data = load_workspaces_from_json()
	local workspaces = {}

	for key, config in pairs(workspaces_data) do
		-- ~ を home_dir に展開
		local cwd = config.cwd:gsub("^~", wezterm.home_dir)

		workspaces[key] = {
			name = config.name,
			cwd = cwd,
			setup = create_setup_function(config.setup),
		}
	end

	return workspaces
end

M.workspaces = build_workspaces()

function M.create_workspace(workspace_config)
	local _tab, pane, window = mux.spawn_window({
		workspace = workspace_config.name,
		cwd = workspace_config.cwd,
	})

	if workspace_config.setup then
		workspace_config.setup(window, pane)
	end
end

function M.show_workspace_menu()
	return act.InputSelector({
		action = wezterm.action_callback(function(window, pane, id, _label)
			if not id then
				return
			end
			-- 既存のworkspaceに切り替え
			if id:match("^switch:") then
				local workspace_name = id:gsub("^switch:", "")
				window:perform_action(act.SwitchToWorkspace({ name = workspace_name }), pane)
			-- 新しいworkspaceを作成
			elseif id:match("^create:") then
				local workspace_name = id:gsub("^create:", "")
				local config = M.workspaces[workspace_name]
				if config then
					M.create_workspace(config)
					window:perform_action(act.SwitchToWorkspace({ name = workspace_name }), pane)
				end
			end
		end),
		title = "Select Workspace",
		choices = (function()
			local choices = {}
			-- 既存のworkspaceを表示
			for _, name in ipairs(mux.get_workspace_names()) do
				table.insert(choices, {
					id = "switch:" .. name,
					label = "🔄 Switch to: " .. name,
				})
			end
			-- 新規作成可能なworkspaceを表示
			for name, _ in pairs(M.workspaces) do
				table.insert(choices, {
					id = "create:" .. name,
					label = "✨ Create: " .. name,
				})
			end
			return choices
		end)(),
	})
end

-- Workspace のキーは Tmux のキーと揃える
M.keys = {
	-- Show workspace menu
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(M.show_workspace_menu(), pane)
		end),
	},
	{
		-- Create new workspace
		mods = "LEADER|SHIFT",
		key = "C",
		action = act.PromptInputLine({
			description = "(wezterm) Create new workspace:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	-- Switch to next workspace
	{ key = "n", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
	-- Switch to previous workspace
	{ key = "p", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
	-- Select workspace
	{
		mods = "LEADER",
		key = "s",
		action = wezterm.action_callback(function(win, pane)
			local workspaces = {}
			for i, name in ipairs(wezterm.mux.get_workspace_names()) do
				table.insert(workspaces, {
					id = name,
					label = string.format("%d. %s", i, name),
				})
			end
			win:perform_action(
				act.InputSelector({
					action = wezterm.action_callback(function(_, _, id, label)
						if not id and not label then
							wezterm.log_info("Workspace selection canceled")
						else
							win:perform_action(act.SwitchToWorkspace({ name = id }), pane)
						end
					end),
					title = "Select workspace",
					choices = workspaces,
					fuzzy = true,
				}),
				pane
			)
		end),
	},
}

return M
