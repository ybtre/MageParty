package movep

import "core:fmt"

import sh "../../shared"
import rl "vendor:raylib"

// T: make basic movement feel nice
//    X: constant speed between diags
//    X: figure out move speed
//    X: do sprite banking

// T: make shooting feel nice

player_anim_states :: enum
{
  F_LEFT   = 0,
  HF_LEFT  = 1,
  MID      = 2,
  HF_RIGHT = 3,
  F_RIGHT  = 4,
}

Player :: struct 
{
  anim_state : player_anim_states,

  anim_srcs  : [player_anim_states]rl.Rectangle,

  dest       : rl.Rectangle,
  origin     : rl.Vector2,
  rot        : f32,

  px         : f32,
  py         : f32,
  spd        : f32,
  bank_val   : f32,
}
plr : Player

init :: proc() {

  plr.anim_state = .MID

  plr.spd = 500
  plr.px = 0
  plr.py = sh.SCREEN.x/2

  plr.anim_srcs[.F_LEFT]   = rl.Rectangle{0, 1264, 16, 16}
  plr.anim_srcs[.HF_LEFT]  = rl.Rectangle{16, 1264, 16, 16}
  plr.anim_srcs[.MID]      = rl.Rectangle{32, 1264, 16, 16}
  plr.anim_srcs[.HF_RIGHT] = rl.Rectangle{48, 1264, 16, 16}
  plr.anim_srcs[.F_RIGHT]  = rl.Rectangle{64, 1264, 16, 16}

  plr.dest = rl.Rectangle {
    plr.px,
    plr.py,
    f32(16 * sh.SCALE),
    f32(16 * sh.SCALE),
  }
  plr.origin = rl.Vector2{0, 0}
  plr.rot = 0.0

  plr.bank_val = 0

}

bank_spd :f32= .2
update :: proc() {
  using rl

  plr.anim_state = .MID
  target_state : player_anim_states = .MID

  if IsKeyDown(KeyboardKey.A)
  {
    plr.px -= plr.spd * f32(GetFrameTime())
    target_state = .F_LEFT
    plr.bank_val -= bank_spd
  }
  if IsKeyDown(KeyboardKey.D)
  {
    plr.px += plr.spd * f32(GetFrameTime())
    target_state = .F_RIGHT
    plr.bank_val += bank_spd
  }

  if IsKeyUp(.A) && IsKeyUp(.D)
  {
    if plr.bank_val > bank_spd
      {
        plr.bank_val -= bank_spd
      }
    else if plr.bank_val < -bank_spd
      {
        plr.bank_val += bank_spd
      }

  }

  if IsKeyDown(KeyboardKey.W)
  {
    plr.py -= plr.spd * f32(GetFrameTime())
  }
  if IsKeyDown(KeyboardKey.S)
  {
    plr.py += plr.spd * f32(GetFrameTime())
  }

  plr.bank_val = Clamp(plr.bank_val, -1, 1)
  if plr.bank_val <= .5 && plr.bank_val > 0
  {
    plr.anim_state = .HF_RIGHT
  }
  else if plr.bank_val >= -.5 && plr.bank_val < 0
  {
    plr.anim_state = .HF_LEFT
  }
  else if plr.bank_val > .5
  {
    plr.anim_state = .F_RIGHT
  }
  else if plr.bank_val < -.5
  {
    plr.anim_state = .F_LEFT
  }
  else 
  {
    plr.anim_state = .MID
  }


  plr.dest.x = plr.px
  plr.dest.y = plr.py

  fmt.printfln("%f", plr.bank_val)
}

render :: proc() {
  using rl


  BeginDrawing()

  ClearBackground(BLUE)

  DrawTexturePro(sh.SPRSHEET, plr.anim_srcs[plr.anim_state], plr.dest, plr.origin, 0, WHITE)

  EndDrawing()
}
