```lua
local usethrottle = require '@packages/throttle'
local world = require '@ecs/world'
local components = require '@ecs/components'

local throttle = usethrottle()

while task.wait() do
   for e, health in world.next(components.health) do
      if throttle(e, 1) and health < 100 then
         world.update(e, components.health, math.min(100,  health + 10))
      end
   end
end
```
