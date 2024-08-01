package game

import "core:fmt"
import movep "proto/move"
import perf "proto/perf"
import scroll "proto/scroll"
import sh "shared"
import rl "vendor:raylib"

Game :: struct 
{
  state  : GlobalState,
  editor : EditorState,
}
GAME : Game

GlobalState :: enum 
{
  PLAYING = 1,
}

EditorState :: enum
{
  PROTO_MOVEMENT    = 1,
  PROTO_SCROLLING   = 2,
  PROTO_PERFORMANCE = 3,
  GAME              = 4,
}

game_init :: proc()
{
  sh.SPRSHEET = rl.LoadTexture("../assets/spritesheet.png")

  GAME.state = .PLAYING 
  GAME.editor = .PROTO_MOVEMENT

  switch(GAME.editor)
  {
    case .PROTO_MOVEMENT:
      {
        movep.init()
      }
    case .PROTO_SCROLLING:
      {
        scroll.init()
      }
    case .PROTO_PERFORMANCE:
      {
        perf.init()
      }
    case .GAME:
      {
        //TODO
      }
  }
}

game_update :: proc()
{
  switch(GAME.state)
  {
    case .PLAYING:
    {
    switch(GAME.editor)
      {
        case .PROTO_MOVEMENT:
        {
          movep.update()
        }
        case .PROTO_SCROLLING:
        {
          scroll.update()
        }
        case .PROTO_PERFORMANCE:
        {
          perf.update()
        }
        case .GAME:
        {
          //TODO
        }
      }
    }
  }
}

game_render :: proc()
{
  using rl

  DrawFPS(30, 35)

  //fmt.printf("%f ms\n", rl.GetFrameTime())
  switch(GAME.state)
  {
    case .PLAYING:
    {
    switch(GAME.editor)
      {
        case .PROTO_MOVEMENT:
        {
          movep.render()
        }
        case .PROTO_SCROLLING:
        {
          scroll.render()
        }
        case .PROTO_PERFORMANCE:
        {
          perf.render()
        }
        case .GAME:
        {
          //TODO
        }
      }
    }
  }
}

