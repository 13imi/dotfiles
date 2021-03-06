local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:disable()
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      -- hs.alert.show(name)
      if (name ~= "iTerm2") and (name ~= "Emacs") then
         enableAllHotkeys()
      else
         disableAllHotkeys()
      end
   end
end

local function keyCtrlK()
   keyCode('right', {'shift', 'cmd'})()
   keyCode('x', {'cmd'})()
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))
remapKey({'ctrl'}, 'a', keyCode('left', {'cmd'}))

remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))

remapKey({'ctrl'}, 's', keyCode('f', {'cmd'}))
remapKey({'ctrl'}, 'm', keyCode('return'))
remapKey({'ctrl'}, 'w', keyCode('x', {'cmd'}))
remapKey({'ctrl'}, 'd', keyCode('forwarddelete'))
remapKey({'ctrl'}, 'h', keyCode('delete'))
remapKey({'ctrl'}, 'i', keyCode('tab'))
remapKey({'ctrl'}, 'k', keyCtrlK)

remapKey({'ctrl'}, 'y', keyCode('v', {'cmd'}))
remapKey({'ctrl'}, '/', keyCode('z', {'cmd'}))

remapKey({'option'}, 'f', keyCode('right', {'option'}))
remapKey({'option'}, 'b', keyCode('left', {'option'}))
remapKey({'option'}, 'd', keyCode('forwarddelete', {'option'}))
remapKey({'option'}, 'h', keyCode('delete', {'option'}))
remapKey({'option', 'shift'}, ',', keyCode('home'))
remapKey({'option', 'shift'}, '.', keyCode('end'))

remapKey({'ctrl'}, 'v', keyCode('pagedown'))
remapKey({'option'}, 'v', keyCode('pageup'))