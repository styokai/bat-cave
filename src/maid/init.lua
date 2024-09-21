--!strict

--# cleanup function designed for my own projects
local function cleanup_fn(item: any)
	local tof = typeof(item)
	if tof == 'Instance' then
		item:Destroy()
	elseif tof == 'RBXScriptConnection' then
		item:Disconnect()
	elseif tof == 'table' then
		if item.clear then
			item.clear()
		end
		if item.disconnect then
			item.disconnect()
		end
		if item.destroy then
			item.destroy()
		end
	end
end

return function()
	local world: {any} = {}
	local wizard = {}
	
	function wizard.insert(item: any)
		table.insert(world, item)
		return wizard
	end
	
	function wizard.delete(event: RBXScriptSignal?, cleanup_vars: (...any?) -> ()?)
		if event then
			event:Once(function(...: any)
				if cleanup_vars then cleanup_vars(...) end
				wizard.delete()
			end)
		else
			for k, j in world do
				world[k] = nil
				cleanup_fn(j)
			end
		end
		return wizard
	end
	
	return wizard :: typeof(wizard)
end
