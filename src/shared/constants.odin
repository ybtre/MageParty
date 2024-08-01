package shared

import RL "vendor:raylib"

// ---------- GAME 
WINDOW_SCALE : f32 : 4
SCALE        : f32 : 4

// ---------- WINDOW
SCREEN: RL.Vector2 : {160 * WINDOW_SCALE, 160 * WINDOW_SCALE}


// ---------- COLOR
C_PLAYER           :: RL.Color{235, 162, 84, 255}
C_PLAYER_SPAWN     :: RL.Color{235, 162, 84, 75}
C_PLAYER_TWO       :: RL.Color{99, 157, 48, 255}
C_PLAYER_TWO_SPAWN :: RL.Color{99, 157, 48, 75}
C_CURSOR           :: RL.Color{209, 191, 176, 255}
C_TEXT             :: RL.Color{99, 47, 109, 255}
C_BTN_HOVER        :: RL.Color{200, 200, 200, 255}
C_BACKGROUND       :: RL.Color{29, 29, 39, 255}
C_BG_GRAY          :: RL.Color{40, 40, 40, 255}
C_TILE             :: RL.Color{51, 73, 76, 255}
C_SPIKE            :: RL.Color{41, 103, 151, 255}
C_AI               :: RL.Color{174, 41, 50, 255}


// ---------- TEXTURES
SPRSHEET : RL.Texture2D 
