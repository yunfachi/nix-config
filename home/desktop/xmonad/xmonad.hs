import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP)

myStartupHook = do
        spawnOnce "kitty &"

main :: IO ()
main = xmonad $ myConfig

myConfig = def
  { terminal = "kitty"
  , modMask = mod4Mask
  , borderWidth = 0
  , startupHook = myStartupHook }
  `additionalKeysP` [
    ("M-<Return>", spawn "kitty")
  , ("M-q", kill) ]
