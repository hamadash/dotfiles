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
      "tabs": [
        {
          "name": "Editor",  // タブ名 (省略可能)
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
            }
          ]
        },
        {
          "name": "Terminal",
          "panes": [
            {
              "commands": ["ls"]
            }
          ]
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
- "tabs" 配列の各要素は "name" と "panes" を持つ。
- "panes" 配列の各要素は "split" と "commands" を指定できる。
- "split" が指定されている場合は、前の pane から split して新しい pane を作成する。
- 最初の要素で "split" が指定されていない場合のみ、既存の pane を使用する。
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

-- pane の設定を適用する共通関数
local function setup_panes(initial_pane, panes_config)
	if not panes_config then
		return
	end

	local current_pane = initial_pane

	for i, pane_config in ipairs(panes_config) do
		-- split が指定されている場合は split を実行
		if pane_config.split then
			current_pane = current_pane:split({
				direction = pane_config.split.direction,
				size = pane_config.split.size,
			})
		elseif i == 1 then
			-- 最初の要素で split が指定されていない場合は既存の pane を使用
			current_pane = initial_pane
		end

		-- commands を実行
		if pane_config.commands then
			for _, command in ipairs(pane_config.commands) do
				current_pane:send_text(command .. "\n")
			end
		end
	end
end

-- setup 設定から関数を動的に生成
local function create_setup_function(setup_config)
	if not setup_config or not setup_config.tabs then
		return nil
	end

	return function(window, pane)
		for i, tab_config in ipairs(setup_config.tabs) do
			local tab_pane
			-- 最初のタブは既存のタブを使用
			if i == 1 then
				tab_pane = pane
				-- タブ名を設定
				if tab_config.name then
					local tab = pane:tab()
					tab:set_title(tab_config.name)
				end
			else
				-- 新しいタブを作成
				local new_tab = window:spawn_tab({})
				tab_pane = new_tab:active_pane()
				-- タブ名を設定
				if tab_config.name then
					new_tab:set_title(tab_config.name)
				end
			end

			-- 各タブに panes を設定
			setup_panes(tab_pane, tab_config.panes)
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
		mods = "SUPER",
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
