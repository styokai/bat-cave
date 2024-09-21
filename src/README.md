### use this
```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local maid = require(ReplicatedStorage.Utils.Maid)

local function run(walkspeed: number)
  local is_running = walkspeed > game.StarterPlayer.CharacterWalkSpeed
  local is_walking = walkspeed > 0.01
  if is_running then
     play('run')
  elseif is_walking then
     play('walk')
  else
     play('idle')
  end
end

maid()
  .insert(humanoid.Running:Connect(run))
  .delete(humanoid.Died)
  -- or
  .todeath(humanoid)
```
### or this
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local maid = require(ReplicatedStorage.Utils.Maid)

local m = maid()

local function new_child(inst: Instance)
  if inst:IsA("Part") then
    m.delete()
  end
end

m.add(workspace.ChildAdded:Connect(new_child))
