-- local ubuntu_path = '/mnt/c/Users/dexte/AppData/Roaming/npm'   -- for npm
-- local ubuntu_path = '/home/dexterspg/.local/share/nvim/mason/bin'


P ={
}

function P.get_constants(os_ver)
	print("The os version is " .. os_ver)
	if os_ver == 'ubuntu' then
		return  get_ubuntu_constants()
	elseif os_ver == 'windows' then
	    return get_windows_constants()
	else
		print("Unsupported os_version argument")
		return nil
	end
end

function get_ubuntu_constants()
  local constants = {} 
  
  constants.path_to_python = '/usr/bin/python3'

--[[  constants.cmd_lua = '/mnt/c/Program Files (x86)/Lua/5.1/lua '
  constants.cmd_python = ubuntu_path .. '/pyright-langserver'
  
  constants.cmd_html = ubuntu_path .. '/html-languageserver'
  constants.cmd_ts = ubuntu_path .. '/typescript-language-server'
  --]]

  return constants
end

function get_windows_constants()
  local constants = {} 
  constants.path_to_python = 'C:/Users/dexte/AppData/Local/Programs/Python/Python38-32/python.exe'
  constants.cmd_python = 'pyright-langserver.cmd'

  constants.cmd_html = 'html-languageserver.cmd'
  constants.cmd_ts = 'typescript-language-server'

  return constants
end



return P
