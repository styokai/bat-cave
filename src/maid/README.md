### use this
```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local maid = require(ReplicatedStorage.Utils.Maid)

local some_objects = {workspace.Part1, workspace.Part2, workspace.Part3}

-- for the sake of example
local function cleanup()
  maid = nil
  some_objects = nil
end

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
  .insert(cleanup)
  .insert(some_objects)
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
