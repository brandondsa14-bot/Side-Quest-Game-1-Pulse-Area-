package main

import "core:math"
import rl "vendor:raylib"

// A small, asset-free game. All measurements are pixels and seconds.
WIDTH :: 960
HEIGHT :: 640
LEFT :: f32(24)
RIGHT :: f32(936)
TOP :: f32(100)
BOTTOM :: f32(596)
PLAYER_RADIUS :: f32(13)
ROUND_SECONDS :: f32(60)
MAX_CHARGE :: f32(1.2)

State :: enum { Title, Playing, Won, Lost }
Enemy :: struct {
    active: bool,
    pos: rl.Vector2,
    heavy: bool,
    stun: f32,
}
Game :: struct {
    state: State,
    player: rl.Vector2,
    enemies: [128]Enemy,
    health: int,
    score: int,
    elapsed: f32,
    spawn_timer: f32,
    invulnerable: f32,
    charge: f32,
    charging: bool,
    cooldown: f32,
    pulse_time: f32,
    pulse_pos: rl.Vector2,
    pulse_radius: f32,
    paused: bool,
}

BACKGROUND :: rl.Color{12, 18, 31, 255}
PANEL :: rl.Color{22, 34, 51, 255}
TEAL :: rl.Color{71, 230, 195, 255}
MUTED :: rl.Color{161, 177, 199, 255}

// Avoid division by zero when two objects occupy the same point.
unit :: proc(v: rl.Vector2) -> rl.Vector2 {
    length := math.sqrt(v.x*v.x + v.y*v.y)
    if length < 0.001 { return rl.Vector2{1, 0} }
    return rl.Vector2{v.x/length, v.y/length}
}

distance :: proc(a, b: rl.Vector2) -> f32 {
    dx, dy := a.x-b.x, a.y-b.y
    return math.sqrt(dx*dx + dy*dy)
}

start_round :: proc(g: ^Game) {
    // Reset the entire struct, including every timer and enemy slot.
    g^ = Game{state = .Playing, player = {480, 348}, health = 3, spawn_timer = 0.7}
}

spawn_enemy :: proc(g: ^Game) {
    for i in 0..<len(g.enemies) {
        if g.enemies[i].active { continue }
        heavy := g.elapsed >= 15 && rl.GetRandomValue(0, 3) == 0
        radius: f32 = 11
        if heavy { radius = 17 }
        pos := rl.Vector2{}
        switch rl.GetRandomValue(0, 3) {
        case 0: pos = {LEFT+radius, f32(rl.GetRandomValue(130, 560))}
        case 1: pos = {RIGHT-radius, f32(rl.GetRandomValue(130, 560))}
        case 2: pos = {f32(rl.GetRandomValue(60, 900)), TOP+radius}
        case 3: pos = {f32(rl.GetRandomValue(60, 900)), BOTTOM-radius}
        }
        // Do not spawn directly on top of the player; try at the next interval.
        if distance(pos, g.player) < 110 { return }
        g.enemies[i] = Enemy{active = true, pos = pos, heavy = heavy}
        return
    }
}

release_pulse :: proc(g: ^Game) {
    power := clamp(g.charge/MAX_CHARGE, f32(0), f32(1))
    radius := 75 + power*100
    push := 85 + power*230
    g.pulse_pos = g.player
    g.pulse_radius = radius
    g.pulse_time = 0.25
    for i in 0..<len(g.enemies) {
        e := &g.enemies[i]
        if !e.active || distance(e.pos, g.player) > radius { continue }
        direction := unit(rl.Vector2{e.pos.x-g.player.x, e.pos.y-g.player.y})
        amount := push
        enemy_radius: f32 = 11
        if e.heavy { amount *= 0.60; enemy_radius = 17 }
        e.pos.x += direction.x*amount
        e.pos.y += direction.y*amount
        e.stun = 0.35
        // Wall impacts are the only way to eliminate enemies.
        if e.pos.x-enemy_radius <= LEFT || e.pos.x+enemy_radius >= RIGHT ||
           e.pos.y-enemy_radius <= TOP || e.pos.y+enemy_radius >= BOTTOM {
            e.active = false
            g.score += 1
        }
    }
    g.charging = false
    g.charge = 0
    g.cooldown = 0.85
}

update_game :: proc(g: ^Game, dt: f32) {
    if rl.IsKeyPressed(.P) { g.paused = !g.paused }
    if g.paused { return }
    g.elapsed += dt
    g.invulnerable = max(f32(0), g.invulnerable-dt)
    g.cooldown = max(f32(0), g.cooldown-dt)
    g.pulse_time = max(f32(0), g.pulse_time-dt)

    // Press, hold, release: holding reduces movement speed.
    if rl.IsKeyPressed(.SPACE) && g.cooldown <= 0 {
        g.charging = true
        g.charge = 0
    }
    if g.charging {
        g.charge = min(MAX_CHARGE, g.charge+dt)
        // IsKeyDown also handles releasing Space while the game was paused.
        if !rl.IsKeyDown(.SPACE) { release_pulse(g) }
    }

    movement := rl.Vector2{}
    if rl.IsKeyDown(.W) || rl.IsKeyDown(.UP) { movement.y -= 1 }
    if rl.IsKeyDown(.S) || rl.IsKeyDown(.DOWN) { movement.y += 1 }
    if rl.IsKeyDown(.A) || rl.IsKeyDown(.LEFT) { movement.x -= 1 }
    if rl.IsKeyDown(.D) || rl.IsKeyDown(.RIGHT) { movement.x += 1 }
    speed: f32 = 230
    if g.charging { speed = 115 }
    if movement.x != 0 || movement.y != 0 {
        movement = unit(movement)
        g.player.x += movement.x*speed*dt
        g.player.y += movement.y*speed*dt
    }
    g.player.x = clamp(g.player.x, LEFT+PLAYER_RADIUS, RIGHT-PLAYER_RADIUS)
    g.player.y = clamp(g.player.y, TOP+PLAYER_RADIUS, BOTTOM-PLAYER_RADIUS)

    g.spawn_timer -= dt
    if g.spawn_timer <= 0 {
        spawn_enemy(g)
        g.spawn_timer = max(f32(1.0), f32(1.5)-g.elapsed*0.005)
    }
    for i in 0..<len(g.enemies) {
        e := &g.enemies[i]
        if !e.active { continue }
        radius: f32 = 11
        enemy_speed: f32 = 86 + g.elapsed*0.65
        if e.heavy { radius = 17; enemy_speed *= 0.72 }
        if e.stun > 0 {
            e.stun = max(f32(0), e.stun-dt)
        } else {
            direction := unit(rl.Vector2{g.player.x-e.pos.x, g.player.y-e.pos.y})
            e.pos.x += direction.x*enemy_speed*dt
            e.pos.y += direction.y*enemy_speed*dt
        }
        if g.invulnerable <= 0 && distance(e.pos, g.player) < radius+PLAYER_RADIUS {
            g.health -= 1
            g.invulnerable = 1.0
            e.active = false
        }
    }
    // Damage takes priority if the final hit and the timer happen together.
    if g.health <= 0 { g.state = .Lost }
    else if g.elapsed >= ROUND_SECONDS { g.state = .Won }
}

center_text :: proc(text: cstring, y, size: i32, color: rl.Color) {
    x := (i32(WIDTH)-rl.MeasureText(text, size))/2
    rl.DrawText(text, x, y, size, color)
}

draw_game :: proc(g: ^Game) {
    rl.DrawRectangle(i32(LEFT), i32(TOP), i32(RIGHT-LEFT), i32(BOTTOM-TOP), PANEL)
    rl.DrawRectangleLines(i32(LEFT), i32(TOP), i32(RIGHT-LEFT), i32(BOTTOM-TOP), TEAL)
    rl.DrawText("PULSE ARENA", 24, 20, 26, TEAL)
    rl.DrawText(rl.TextFormat("HP: %d / 3", i32(g.health)), 295, 26, 22, rl.WHITE)
    rl.DrawText(rl.TextFormat("Walls: %d", i32(g.score)), 470, 26, 22, rl.WHITE)
    rl.DrawText(rl.TextFormat("Survive: %d s", i32(max(f32(0), ROUND_SECONDS-g.elapsed))), 675, 26, 22, rl.WHITE)
    rl.DrawText("WASD / arrows: move   SPACE: hold then release   P: pause   ESC: quit", 24, 610, 18, MUTED)
    rl.DrawText("PULSE", 24, 68, 16, MUTED)
    rl.DrawRectangle(93, 67, 220, 17, BACKGROUND)
    if g.charging {
        rl.DrawRectangle(93, 67, i32(220*g.charge/MAX_CHARGE), 17, TEAL)
        rl.DrawText("Release SPACE to push enemies into walls", 335, 68, 17, TEAL)
        rl.DrawCircleLines(i32(g.player.x), i32(g.player.y), 75+100*g.charge/MAX_CHARGE, TEAL)
    } else if g.cooldown > 0 {
        rl.DrawRectangle(93, 67, i32(220*(1-g.cooldown/0.85)), 17, rl.GRAY)
        rl.DrawText("Recharging...", 335, 68, 17, MUTED)
    } else {
        rl.DrawRectangle(93, 67, 220, 17, TEAL)
        rl.DrawText("Ready - hold SPACE to charge", 335, 68, 17, TEAL)
    }
    for e in g.enemies {
        if !e.active { continue }
        if e.heavy {
            rl.DrawCircleV(e.pos, 17, rl.ORANGE)
            rl.DrawCircleLines(i32(e.pos.x), i32(e.pos.y), 10, rl.WHITE)
        } else {
            rl.DrawCircleV(e.pos, 11, rl.RED)
        }
    }
    if g.pulse_time > 0 {
        rl.DrawCircleLines(i32(g.pulse_pos.x), i32(g.pulse_pos.y), g.pulse_radius, TEAL)
    }
    color := TEAL
    if g.invulnerable > 0 && int(g.invulnerable*12)%2 == 0 { color = rl.WHITE }
    rl.DrawCircleV(g.player, PLAYER_RADIUS, color)
    if g.paused {
        rl.DrawRectangle(230, 255, 500, 125, BACKGROUND)
        center_text("PAUSED", 277, 34, TEAL)
        center_text("Press P to continue", 330, 22, rl.WHITE)
    }
}

main :: proc() {
    rl.InitWindow(WIDTH, HEIGHT, "Pulse Arena - Agentic Game Jam")
    defer rl.CloseWindow()
    rl.SetTargetFPS(60)
    game := Game{state = .Title}
    for !rl.WindowShouldClose() {
        dt := min(rl.GetFrameTime(), f32(0.05))
        switch game.state {
        case .Title, .Won, .Lost:
            if rl.IsKeyPressed(.ENTER) || rl.IsKeyPressed(.R) { start_round(&game) }
        case .Playing:
            update_game(&game, dt)
        }
        rl.BeginDrawing()
        rl.ClearBackground(BACKGROUND)
        switch game.state {
        case .Title:
            center_text("PULSE ARENA", 120, 54, TEAL)
            center_text("No bullets. Knock enemies into the walls.", 206, 25, rl.WHITE)
            center_text("WASD or arrow keys to move", 278, 23, MUTED)
            center_text("Hold SPACE to charge; release to pulse", 318, 23, MUTED)
            center_text("Charging slows you down. Orange enemies resist pushes.", 362, 20, MUTED)
            center_text("Survive 60 seconds with 3 HP. P pauses.", 404, 23, MUTED)
            center_text("Press ENTER to start", 490, 30, TEAL)
        case .Playing:
            draw_game(&game)
        case .Won, .Lost:
            if game.state == .Won { center_text("YOU SURVIVED!", 175, 48, TEAL) }
            else { center_text("ARENA OVER", 175, 48, rl.ORANGE) }
            center_text(rl.TextFormat("Wall knockouts: %d", i32(game.score)), 270, 27, rl.WHITE)
            center_text(rl.TextFormat("Time survived: %d seconds", i32(min(game.elapsed, ROUND_SECONDS))), 315, 25, MUTED)
            center_text("Try quick pulses for safety, charged pulses for wall hits.", 385, 21, MUTED)
            center_text("Press ENTER or R to play again", 455, 29, TEAL)
        }
        rl.EndDrawing()
    }
}
