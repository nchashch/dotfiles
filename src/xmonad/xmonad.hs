import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.CustomKeys
import XMonad.Hooks.EwmhDesktops

main = do
      xmonad =<< statusBar myBar myPP toggleStrutsKey xmonadConfig
      xmonad xmonadConfig

xmonadConfig =  defaultConfig
    { borderWidth = 0
    , modMask = mod4Mask
    , terminal = "urxvt"
    , keys = customKeys delkeys inskeys
    , handleEventHook =
            handleEventHook defaultConfig <+> fullscreenEventHook
    }

myBar :: String
myBar = "xmobar ~/.xmonad/xmobar.hs"

myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "[" "]" }

toggleStrutsKey :: XConfig l -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


delkeys :: XConfig l -> [(KeyMask, KeySym)]
delkeys XConfig {modMask = modm} =
    []

inskeys :: XConfig l -> [((KeyMask, KeySym), X ())]
inskeys conf@(XConfig {modMask = modm}) =
    [ ((modm, xK_o), spawn secondaryDisplayOn)
    , ((modm, xK_f), spawn secondaryDisplayOff)
    ]

primaryDisplay = "LVDS1"
secondaryDisplay = "VGA1"
secondaryDisplayOn = "xrandr --output " ++ secondaryDisplay ++ " --auto --right-of " ++ primaryDisplay
secondaryDisplayOff = "xrandr --output " ++ secondaryDisplay ++ " --off"
