--!strict

--# cleanup function designed for my own projects
local function cleanup_fn(item: any)
	local tof = typeof(item)
	if tof == 'Instance' then
		item:Destroy()
	elseif tof == 'thread' then
		task.cancel(item)
	elseif tof == 'function' then
		-- prevent infinite yield
		task.cancel(task.spawn(item))
	elseif tof == 'RBXScriptConnection' then
		item:Disconnect()
	elseif tof == 'table' then
		if item.delete then
			item.delete()
		else
			for k, j in item do
				cleanup_fn(j)
				cleanup_fn(k)
			end
		end
	end
end

return function()
	local world: {any} = {}
	local t = {}
	
	function t.insert(item: any)
		table.insert(world, item)
		return t
	end
	
	-- same as insert but returns the item over t
	function t.add(item: any)
		t.insert(item)
		return item
	end
	
	--[[
		1. delete() with signal as first argument means that once the signal is fired delete is called
		otherwise you should call delete manually to clean up
		
		2.cleanup_vars is a callback that you can pass to delete to clean up variables or do something else
		```
	]]
	function t.delete(event: RBXScriptSignal?, cleanup_vars: (...any?) -> ()?)
		if event then
			event:Once(function(...: any)
				if cleanup_vars then cleanup_vars(...) end
				t.delete()
			end)
		else
			for k, j in world do
				world[k] = nil
				cleanup_fn(j)
			end
			table.clear(t)
		end
		return t
	end
	
	local function handle_death(_, parent: Instance)
		if not parent then
			t.delete()
		end
	end
	
	-- todeath means that delete() is called when the instance provided is destroyed
	function t.todeath(inst: Instance)
		t.insert(inst.AncestryChanged:Connect(handle_death))
		t.insert(inst.Destroying:Once(t.delete :: any))
		return t
	end
	
	return t :: typeof(t)
end
