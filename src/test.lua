
local app = require("app")

app:init()
window = app:createWindow(640, 480, "Derp")

window.onUpdate = function()
   print(app.fps)
end

app:start()
