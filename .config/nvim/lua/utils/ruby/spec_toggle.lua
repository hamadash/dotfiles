local M = {}

-- spec ファイルのテンプレートを生成
local function generate_spec_template(spec_file, source_file)
	local class_name = vim.fn.fnamemodify(source_file, ":t:r")
	class_name = class_name:gsub("^%l", string.upper):gsub("_%l", string.upper):gsub("_", "")

	local spec_type = ""
	local template = ""

	if spec_file:match("/models/") then
		spec_type = ":model"
		template = string.format(
			[[require 'rails_helper'

RSpec.describe %s, type: %s do
  pending "add some examples to (or delete) #{__FILE__}"
end
]],
			class_name,
			spec_type
		)
	elseif spec_file:match("/controllers/") then
		spec_type = ":controller"
		template = string.format(
			[[require 'rails_helper'

RSpec.describe %s, type: %s do
  pending "add some examples to (or delete) #{__FILE__}"
end
]],
			class_name,
			spec_type
		)
	else
		template = string.format(
			[[require 'rails_helper'

RSpec.describe %s do
  pending "add some examples to (or delete) #{__FILE__}"
end
]],
			class_name
		)
	end

	return template
end

-- Ruby ファイルと spec ファイルを切り替える
function M.toggle_spec()
	local current_file = vim.fn.expand("%:p")
	local target_file = ""
	local is_spec_to_impl = current_file:match("_spec%.rb$") ~= nil

	if is_spec_to_impl then
		-- spec → implementation
		-- spec/models/user_spec.rb → app/models/user.rb
		-- spec/lib/service_spec.rb → lib/service.rb
		target_file = current_file:gsub("^(.*/)spec/", "%1"):gsub("_spec%.rb$", ".rb")

		-- spec/ 配下で app/ がない場合は app/ を追加
		if target_file:match("^.*/models/") or target_file:match("^.*/controllers/") then
			target_file = target_file:gsub("^(.*/)models/", "%1app/models/")
			target_file = target_file:gsub("^(.*/)controllers/", "%1app/controllers/")
			target_file = target_file:gsub("^(.*/)helpers/", "%1app/helpers/")
			target_file = target_file:gsub("^(.*/)mailers/", "%1app/mailers/")
			target_file = target_file:gsub("^(.*/)jobs/", "%1app/jobs/")
		end
	else
		-- implementation → spec
		-- app/models/user.rb → spec/models/user_spec.rb
		-- lib/service.rb → spec/lib/service_spec.rb
		if current_file:match("^.*/app/") then
			target_file = current_file:gsub("^(.*/)app/", "%1spec/"):gsub("%.rb$", "_spec.rb")
		else
			-- lib など app 以外のファイル
			target_file = current_file:gsub("^(.*/)lib/", "%1spec/lib/"):gsub("%.rb$", "_spec.rb")
		end
	end

	if vim.fn.filereadable(target_file) == 1 then
		vim.cmd("edit " .. target_file)
	else
		-- spec → implementation の場合は作成しない
		if is_spec_to_impl then
			vim.notify("File not found: " .. target_file, vim.log.levels.WARN)
			return
		end

		-- implementation → spec の場合は作成確認
		local choice = vim.fn.confirm("Spec file not found. Create it?", "&Yes\n&No", 2)
		if choice == 1 then
			-- ディレクトリを作成
			local dir = vim.fn.fnamemodify(target_file, ":h")
			vim.fn.mkdir(dir, "p")

			-- テンプレートを生成してファイルを作成
			local template = generate_spec_template(target_file, current_file)
			local lines = vim.split(template, "\n")
			vim.fn.writefile(lines, target_file)

			-- ファイルを開く
			vim.cmd("edit " .. target_file)
			vim.notify("Created: " .. target_file, vim.log.levels.INFO)
		end
	end
end

function M.setup()
	vim.api.nvim_create_user_command("ToggleSpec", function()
		M.toggle_spec()
	end, {})
end

return M
