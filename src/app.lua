
require "class"
local glfw = require "glfw"

local App = {time = 0, fps = 0}
local Window = class()

local windows = {}
local handles = {}

function App:init()
   glfw.init()
end

function App:start()
   self.time = glfw.getTime()
   local frames = 0
   local nextFPS = self.time + 1
   while true do
      self.time = glfw.getTime()
      frames = frames + 1

      if self.time > nextFPS then
         self.fps = self.fps * 0.6 + frames * 0.4
         frames = 0
         nextFPS = self.time + 1
      end

      for k,window in ipairs(windows) do
         window:update()
      end

   end
end

function App:createWindow(width, height, title)
   win = Window(width, height, title)

   table.insert(windows, win)
   handles[win.handle] = win

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

return App
