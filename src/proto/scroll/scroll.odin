
package scroll

import rl "vendor:raylib"
import sh "../../shared"
import "core:fmt"
import "core:strings"
import "core:strconv"
import "core:math"
// 2.  Scrolling Prototype
// 	- How long of a level can we make?
// 	- Scrolling speed?
// 	- (Tileset?)

// Map
// 160 tiles
// 40 tiles

// Screen 
// 20 x 20 tiles

// 8 screens
// 2 screens

// 16 screens of level speed ( 15 screens )
// speed 40
// ~60s
// speed 20
// ~120s
// speed 10
// ~220s

// goal: 6minutes (360s)
//       4minutes (240s)

scroll : f32

Map_Segment :: struct
{
    src    : rl.Rectangle,
    dest   : rl.Rectangle,
    origin : rl.Vector2,
    rot    : f32,
}

seglib : [32]Map_Segment
mapsegs : [4]int

tile_names :: enum 
{
    default = 0,
    tile_1  = 1,
    tile_2  = 2,
    tile_3  = 3,
    tile_4  = 4,
    num_1   = 5,
    num_2   = 6,
    num_3   = 7,
    num_4   = 8,
    seg1    = 9,
}
tiles_tex : [tile_names]rl.Texture2D
bul_tex : rl.Texture2D
 
init :: proc()
{
    using rl
    
    tiles_tex[.seg1]   = LoadTexture("../assets/spritesheet.png")

        src    := Rectangle{0, 0, 319, 319}
        dest   := Rectangle{0, 0 * sh.SCALE,  f32(160 * sh.SCALE), f32(160 * sh.SCALE)}
        origin := Vector2{0,0}
        rot    : f32 = 0

        //i   /4    *160
        //--------------
        //0   0     0
        //1   0     0
        //2   0     0
        //3   0     0
        //4   1     160

        //i   %4    *160
        //--------------
        //0   0     0
        //1   1     160
        //2   2     320
        //3   3     480
        //4   0     160

        //i   *80    *160
        //--------------
        //0   0     0
        //1   80    160
        //2   160   320
        //3   240   480
        //4   320   160
        //5   400

        for i in 0..<len(seglib)  
            {
                col := f32(math.floor( f32(i) / 4) * 160)
                row := f32(( i % 4 ) * 80)
                offset_y := (f32(i) * 80)

                t := offset_y * sh.SCALE
                seglib[i].src = Rectangle{ col, row, 160, 80 }
                seglib[i].dest = Rectangle{ 0,  -t, 160 * sh.SCALE, 80 * sh.SCALE }
                seglib[i].origin = Vector2{ 0, 0 }
                seglib[i].rot = 0.0
            }

    mapsegs = { 31, 1, 1, 5 }
}

pause := false
timer : f32
update :: proc()
{
        using rl
        

        if rl.IsKeyPressed(rl.KeyboardKey.P)
            {
                pause = !pause
            }

        if pause
            {
                timer += rl.GetFrameTime()
                scroll += 100 * sh.WINDOW_SCALE * rl.GetFrameTime()
            }

    fmt.printfln("%f s", timer)
}

render :: proc()
{
    using rl

    BeginDrawing()

        ClearBackground(MAROON)

        for i in 0..<len(mapsegs)
    {
        my_seg := seglib[mapsegs[i]]
        seg_y := scroll - ( f32(i) * f32(80 * sh.SCALE))
        my_seg.dest.y = seg_y
        
        DrawTexturePro( 
            tiles_tex[tile_names.seg1],
            my_seg.src,
            my_seg.dest,
            my_seg.origin,
            my_seg.rot,
            WHITE)
    }

    EndDrawing()
}
