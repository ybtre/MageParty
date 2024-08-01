
package perf

import rl "vendor:raylib"
import sh "../../shared"

bul_amount :: 100000
buls : [bul_amount]rl.Vector2
bul_tex : rl.Texture2D

init :: proc()
{
    using rl

    bul_tex = LoadTexture("../assets/bul_tex.png")

    for i in 0 ..< bul_amount
    {
        x := rl.GetRandomValue(0, i32(sh.SCREEN.x))
        y := rl.GetRandomValue(0, i32(sh.SCREEN.y))
        
        buls[i].x = f32(x)
        buls[i].y = f32(y)
    }
}

update :: proc()
{
        using rl

        for i in 0 ..< bul_amount
            {
                bul := &buls[i]

                bul.y += .5
                if bul.y > sh.SCREEN.x
                    {
                        bul.y -= sh.SCREEN.x
                    }
            }

}

render :: proc()
{
    using rl

    BeginDrawing()

        ClearBackground(MAROON)

        for bul in buls
            {
                DrawTextureEx(bul_tex, bul, 0, sh.SCALE, WHITE)
            }

    EndDrawing()
}
