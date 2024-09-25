--!strict

local function cleanup(scope: {any})
	for i = #scope, 1, -1 do
		local item = scope[i]
		local userdata = typeof(item)
		if userdata == 'RBXScriptConnection' then
			item:Disconnect()
		elseif userdata == 'thread' then
			task.cancel(item)
		elseif userdata == 'function' then
			item()
		elseif userdata == 'Instance' then
			item:Destroy()
		elseif userdata == 'table' then
			cleanup(item)
		end
	end
end

return cleanup
