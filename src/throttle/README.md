You use it like this
```lua
local useThrottle = require(ReplicatedStorage.Utils.throttle)
local world = require(ReplicatedStorage.World) -- jecs world
local jecs = require(ReplicatedStorage.World.Jecs)

-- creates a cache for this file where entities are stored
local throttle = useThrottle()
local components = {
  health = world:component() :: jecs.Entity<number>
}

local function heal_overtime()
  for e, health in world:query(components.health):iter() do
    -- throttle is unique for each entity
    if health < 100 and throttle(e, 1) then
      world:set(e, components.health, math.clamp(health + 10, 0, 100)
    end
  end
end

-- used while as example
while task.wait(0.05) do
  heal_overtime()
end
```
