-- Configure a keybinding with an Application
hs.loadSpoon("AppLauncher")
spoon.AppLauncher.modifiers = {"ctrl", "alt", "command"}
hs.spoons.use("AppLauncher", {
  hotkeys = {
    i = "iTerm",
    o = "Safari", 
    p = "Obsidian"
  }
})
