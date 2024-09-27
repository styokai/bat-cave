```luau
local cleanup = require '@packages/cleanup'

local scope = {}

local function on_child_added() end
local function on_child_removed() end

table.insert(scope, workspace.ChildAdded:Connect(on_child_added))
table.insert(scope, workspace.ChildRemoved:Connect(on_child_removed))

cleanup(scope)
```
