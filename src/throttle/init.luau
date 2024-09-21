--!strict
-- designed for jecs query

type c = {[string]: {number}}
type debuginfo = (thread, number, string) -> string

local cache: c = {}

return function()
	local f = (debug.info :: debuginfo)(coroutine.running(), 2, "s")
	f = string.split(f, ".")
	f = f[#f]
	
	local source = {}
	cache[f] = source
	
	return function(e: number, duration: number): boolean
		local done = if source[e] then os.clock() - source[e] > duration else true
		if done then
			source[e] = os.clock()
		end
		return done
	end
end
