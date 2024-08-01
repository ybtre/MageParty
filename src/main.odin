package game

import "core:fmt"
import "core:strconv"
import "core:strings"
import sh "shared"
import rl "vendor:raylib"

main :: proc() {
  using strings

  rl.SetRandomSeed(42)

  name := clone_to_cstring(sh.project_name)
  xxx: i32 = i32(sh.SCREEN.x)
  yyy: i32 = i32(sh.SCREEN.y)
  rl.InitWindow(xxx, yyy, name)

  rl.InitAudioDevice()

  setup_window()

  game_init()


  is_running: bool = true
  for is_running && !rl.WindowShouldClose() {

    {// Update
      game_update()
    }

    {// Render
      game_render()
    }

  }

  rl.CloseWindow()
}


setup_window :: proc() {
  using rl
  SetTargetFPS(60)

  // icon: Image = LoadImage("../assets/icons/window_icon.png")
  //
  // ImageFormat(&icon, PixelFormat.UNCOMPRESSED_R8G8B8A8)
  //
  // SetWindowIcon(icon)
  //
  // UnloadImage(icon)
}
