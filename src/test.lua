
local gl   = require("opengl")
local glfw = require("glfw")

glfw.init()

window = glfw.openWindow(640, 480, glfw.WINDOWED, "Derp", nil)

glfw.swapInterval(0)

local i = 0
repeat

   i = i + 1

   if glfw.getTime() > 1 then
      print(i)
      i = 0
      glfw.setTime(0)
   end

   glfw.swapBuffers()
   glfw.pollEvents()

until glfw.isWindow(window) == 0
