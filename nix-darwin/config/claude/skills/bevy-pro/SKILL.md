---
name: bevy-pro
description: Build games with Bevy engine using idiomatic ECS patterns, plugins, rendering, input, UI, state machines, and asset management. Use when writing Bevy game code, creating components/systems/resources, setting up rendering pipelines, handling input, building UI, managing game states, or working with Bevy projects.
---

# Bevy Pro

## Quick start

```rust
use bevy::prelude::*;

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_systems(Startup, setup)
        .add_systems(Update, movement)
        .run();
}

#[derive(Component)]
struct Player;

#[derive(Component)]
struct Speed(f32);

fn setup(mut commands: Commands) {
    commands.spawn(Camera2d);
    commands.spawn((Player, Speed(200.0), Transform::default()));
}

fn movement(
    keyboard: Res<ButtonInput<KeyCode>>,
    mut query: Query<(&mut Transform, &Speed), With<Player>>,
    time: Res<Time>,
) {
    for (mut tf, speed) in &mut query {
        let mut dir = Vec2::ZERO;
        if keyboard.pressed(KeyCode::KeyW) { dir.y += 1.0; }
        if keyboard.pressed(KeyCode::KeyS) { dir.y -= 1.0; }
        if keyboard.pressed(KeyCode::KeyA) { dir.x -= 1.0; }
        if keyboard.pressed(KeyCode::KeyD) { dir.x += 1.0; }
        tf.translation += dir.normalize_or_zero().extend(0.0) * speed.0 * time.delta_secs();
    }
}
```

## Core patterns

See [REFERENCE.md](REFERENCE.md) for full ECS, rendering, input, UI, state, asset, and architecture patterns.

## Workflows

### New game project
1. `cargo init && cargo add bevy` (current: 0.19.0-dev)
2. Create `main.rs` with `App::new().add_plugins(DefaultPlugins)`
3. Add startup system for camera + initial entities
4. Add update systems for game logic
5. Organize into plugins as complexity grows

### Adding a feature
1. Define components (`#[derive(Component)]`)
2. Define resources if needed (`#[derive(Resource)]`)
3. Write systems as plain functions with typed params
4. Register in a Plugin's `build()` method
5. Use `.chain()` or SystemSets for ordering

### State management
1. Define states enum (`#[derive(States)]`)
2. `.init_state::<MyState>()` in app
3. `OnEnter`/`OnExit` for setup/cleanup
4. `.run_if(in_state(State::X))` for conditional systems
5. `NextState<T>` resource to transition

## Key rules

- **Composition over inheritance** - many small components, not large monoliths
- **Marker components** - empty structs for query filtering with `With<T>`/`Without<T>`
- **Commands for deferred ops** - spawn/despawn/insert via `Commands`, not direct world mutation
- **Change detection** - use `Changed<T>`, `Added<T>` filters; call `set_if_neq()` to avoid false positives
- **Plugin encapsulation** - group related systems/resources/events into plugins
- **Parallel by default** - only use `.chain()` or `.before()`/`.after()` when ordering matters
- **Handle-based assets** - store `Handle<T>`, never clone loaded asset data
- **`DespawnOnExit(State)`** - auto-cleanup entities tied to states
- **Newtype wrappers** - wrap `Timer`, `Handle`, primitives for type safety
- **`Startup` vs `Update`** - one-time setup in `Startup`, per-frame logic in `Update`
