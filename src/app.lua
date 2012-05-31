
local class = require "class"
local glfw = require "glfw"

local App = {time = 0, fps = 0}
local Window = class()

local windows = {}
local numWindows = 0

function App.init()
   glfw.init()
end

function App.start()
   local frames = 0
   local nextFPS = glfw.getTime() + 1
   while numWindows > 0 do
      App.time = glfw.getTime()
      frames = frames + 1

      -- update fps
      if App.time > nextFPS then
         App.fps = App.fps * 0.6 + frames * 0.4
         frames = 0
         nextFPS = App.time + 1
      end

      -- update windows
      for k,window in pairs(windows) do
         window:update()
         if glfw.isWindow(window.handle) == 0 then
            windows[window.handle] = nil
            numWindows = numWindows - 1
         end
      end
   end

   glfw.terminate()
end

function App.createWindow(width, height, title)
   win = Window(width, height, title)
   windows[win.handle] = win
   numWindows = numWindows + 1
   return win
end

function Window:init(width, height, title)
   self.handle = glfw.openWindow(width, height, glfw.WINDOWED, title, nil)
   glfw.makeContextCurrent(self.handle)
   glfw.swapInterval(0)
   self.onUpdate = function() end
end

function Window:update()
   glfw.makeContextCurrent(self.handle)
   self.onUpdate()
   glfw.swapBuffers()
   glfw.pollEvents()
end

function Window:setTitle(title)
   glfw.makeContextCurrent(self.handle)
   glfw.setWindowTitle(title)
end

return App
