-------------
-- imports --
-------------
import XMonad
import XMonad.Actions.UpdateFocus

{-- layouts --}
import XMonad.Layout.Gaps (gaps, Direction2D(D, L, R, U))
import XMonad.Layout.Spacing (spacingRaw, Border(Border))
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders

{-- launch process --}
import XMonad.Util.SpawnOnce (spawnOnce)

{-- for keybinds --}
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

---------------
-- variables --
---------------
myTerminal              = "kitty"
myModMask               = mod4Mask  {-- super --}
myFocusFollowsMouse     = True
myBorderWidth           = 1
myNormalBorderColor     = "#666666"
myFocusedBorderColor    = "#ffffff" 
myWorkspaces            = ["1", "2", "3", "4", "5"]

-------------------------
-- auto start programs --
-------------------------
myStartupHook = do
    spawnOnce "xrandr --output DP-3 --mode 1920x1080 --rate 144 --primary --brightness 1.0"

----------------------------------------------------------------------
-- keybinds
----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = super}) = M.fromList $
    [
        {-- launch a terminal --}
        ((super, xK_Return),
        spawn myTerminal),

        {-- kill active window --}
        ((super, xK_q),
        kill),

        {-- rebuild XMonad --}
        ((super, xK_r),
        spawn "xmonad --recompile; xmonad --restart"),



        {-- swap the focused window and master window --}
        ((super, xK_z),
        windows W.swapMaster),

        {-- shrink the master window --}
        ((super, xK_x),
        sendMessage Shrink),

        {-- expand the master window --}
        ((super, xK_c),
        sendMessage Expand),

        {-- back to tiling mode --}
        ((super, xK_v),
        withFocused $ windows . W.sink),

        {-- change layout --}
        ((super, xK_l),
        sendMessage NextLayout)
    ]

    ++

    [
        {-- move the workspace or send the window to the any workspaces --}
        ((m .|. super, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

------------------
-- window rules --
------------------
myManageHook = composeAll
    [ 
        className =? "Bar"       --> doIgnore
    ]

------------
-- layout --
------------
myLayoutHook = 
    gaps [(L, 0), (R, 0), (U, 0), (D, 0)] $

    spacingRaw True (Border gap gap gap gap)
                 True (Border gap gap gap gap)
                 True $

    Grid |||
    Mirror (Tall 1 (3/100) (3/5)) |||
    noBorders Full

    where
            nmaster = 1
            delta = 3/100
            fraction = 1/2

            gap = 5
----------
-- main --
----------
main :: IO ()
main = xmonad $ defaults

defaults = def
    {
        terminal            = myTerminal,
        modMask             = myModMask,
        focusFollowsMouse   = myFocusFollowsMouse,
        borderWidth         = myBorderWidth,
        normalBorderColor   = myNormalBorderColor,
        focusedBorderColor  = myFocusedBorderColor,
        workspaces          = myWorkspaces, 
        keys                = myKeys,
        manageHook          = myManageHook, 
        layoutHook          = myLayoutHook,
        startupHook         = myStartupHook,
        handleEventHook     = focusOnMouseMove
    } 