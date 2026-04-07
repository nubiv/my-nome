# Bevy Reference

## ECS Fundamentals

### Components
```rust
#[derive(Component)]
struct Position(Vec3);

#[derive(Component)]
struct Empty; // Marker component

// SparseSet for frequently added/removed
#[derive(Component)]
#[component(storage = "SparseSet")]
struct Temporary;

// Required components (auto-inserted when this component is added)
#[derive(Component)]
#[require(Transform)]
struct Player;

// Immutable components (read-only optimization)
#[derive(Component)]
#[component(immutable)]
struct Id(u64);
```

### Resources
```rust
#[derive(Resource)]
struct Score(u32);

#[derive(Resource, Default)]
struct Config { volume: f32 }

// Access
fn sys(score: Res<Score>, mut config: ResMut<Config>, maybe: Option<Res<Score>>) {}

// Register
app.insert_resource(Score(0));
app.init_resource::<Config>(); // requires Default
```

### Systems
```rust
// Common system parameters
fn my_system(
    commands: Commands,                          // deferred world changes
    query: Query<&Transform, With<Player>>,      // component queries
    res: Res<Score>,                              // immutable resource
    mut res_mut: ResMut<Config>,                  // mutable resource
    time: Res<Time>,                              // frame timing
    keyboard: Res<ButtonInput<KeyCode>>,          // input state
    mut local: Local<u32>,                        // per-system persistent state
    mut msgs: MessageReader<MyMessage>,             // read messages (pull-based)
    mut writer: MessageWriter<MyMessage>,            // write messages (pull-based)
) {}

// Systems can return Result
fn fallible(query: Query<&Player>) -> Result<(), BevyError> {
    let player = query.single()?;
    Ok(())
}
```

### Queries
```rust
// Basic
Query<&Position>
Query<(&Position, &mut Velocity)>
Query<(Entity, &Name)>

// Filters
Query<&Pos, With<Player>>
Query<&Pos, Without<Dead>>
Query<&Pos, (With<A>, Without<B>)>
Query<&Pos, Or<(With<A>, With<B>)>>
Query<&Pos, Changed<Pos>>
Query<&Pos, Added<Pos>>

// Optional
Query<(&Pos, Option<&Health>)>

// Iteration
for pos in &query {}
for mut pos in &mut query {}
let single = query.single();
let result = query.get(entity);

// Combinations (e.g. pairwise collision)
for [a, b] in query.iter_combinations::<2>() {}

// Parallel iteration
query.par_iter().for_each(|pos| {});
```

### Commands (deferred operations)
```rust
// Spawn
commands.spawn((Player, Transform::default(), Speed(100.0)));
commands.spawn_batch(vec![(A, B), (A, B)]);

// With children
commands.spawn(Parent).with_children(|p| {
    p.spawn(Child);
});

// Modify existing
commands.entity(id).insert(NewComponent);
commands.entity(id).remove::<OldComponent>();
commands.entity(id).despawn();           // entity only
commands.entity(id).despawn_recursive(); // with children

// Resources
commands.insert_resource(MyResource(42));
```

## App & Plugin Architecture

### App builder
```rust
App::new()
    .add_plugins(DefaultPlugins)
    .add_plugins(MyPlugin)
    .insert_resource(Score(0))
    .init_resource::<Config>()
    .init_state::<GameState>()
    .add_systems(Startup, setup)
    .add_systems(Update, (input, movement, collision).chain())
    .add_systems(FixedUpdate, physics)
    .add_systems(OnEnter(GameState::Playing), start_game)
    .add_systems(OnExit(GameState::Playing), cleanup)
    .run();
```

### Custom plugin
```rust
pub struct GamePlugin;

impl Plugin for GamePlugin {
    fn build(&self, app: &mut App) {
        app.insert_resource(Score(0))
           .add_event::<ScoreEvent>()
           .add_systems(Startup, setup)
           .add_systems(Update, (scoring, rendering).chain());
    }
}
```

### Schedules
| Schedule | When |
|----------|------|
| `Startup` | Once at launch |
| `First` | Start of each frame |
| `PreUpdate` | Before main update |
| `Update` | Main game logic |
| `PostUpdate` | After update (transform propagation) |
| `Last` | End of frame |
| `FixedUpdate` | Fixed timestep (physics) |
| `OnEnter(S)` | When entering state S |
| `OnExit(S)` | When exiting state S |

### System ordering
```rust
// Chain (sequential)
(system_a, system_b, system_c).chain()

// Explicit ordering
system_a.before(system_b)
system_b.after(system_a)

// System sets
#[derive(SystemSet, Hash, PartialEq, Eq, Clone, Debug)]
enum GameSet { Input, Movement, Physics }

app.configure_sets(Update, (GameSet::Input, GameSet::Movement, GameSet::Physics).chain())
   .add_systems(Update, handle_input.in_set(GameSet::Input))
   .add_systems(Update, move_entities.in_set(GameSet::Movement));
```

### Run conditions
```rust
.run_if(in_state(GameState::Playing))
.run_if(resource_exists::<MyResource>)
.run_if(resource_changed::<Config>)
.run_if(|score: Res<Score>| score.0 > 100)
.run_if(condition_a.and(condition_b))
.run_if(not(in_state(GameState::Paused)))
```

## Rendering

### 2D setup
```rust
fn setup_2d(mut commands: Commands, asset_server: Res<AssetServer>) {
    commands.spawn(Camera2d);
    commands.spawn((
        Sprite::from_image(asset_server.load("player.png")),
        Transform::from_xyz(0.0, 0.0, 0.0),
    ));
}
```

### Sprite with custom properties
```rust
Sprite {
    image: asset_server.load("image.png"),
    color: Color::WHITE,
    flip_x: false,
    custom_size: Some(Vec2::new(100.0, 100.0)),
    texture_atlas: Some(TextureAtlas { layout: atlas_handle, index: 0 }),
    ..default()
}
```

### 3D setup
```rust
fn setup_3d(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<StandardMaterial>>,
) {
    // Mesh
    commands.spawn((
        Mesh3d(meshes.add(Cuboid::new(1.0, 1.0, 1.0))),
        MeshMaterial3d(materials.add(StandardMaterial {
            base_color: Color::srgb(0.8, 0.7, 0.6),
            ..default()
        })),
        Transform::from_xyz(0.0, 0.5, 0.0),
    ));

    // Light
    commands.spawn((
        PointLight { shadow_maps_enabled: true, ..default() },
        Transform::from_xyz(4.0, 8.0, 4.0),
    ));

    // Camera
    commands.spawn((
        Camera3d::default(),
        Transform::from_xyz(-2.5, 4.5, 9.0).looking_at(Vec3::ZERO, Vec3::Y),
    ));
}
```

### 2D meshes
```rust
commands.spawn((
    Mesh2d(meshes.add(Circle::new(50.0))),
    MeshMaterial2d(materials.add(Color::srgb(0.2, 0.6, 0.8))),
    Transform::from_xyz(0.0, 0.0, 0.0),
));
```

## Transform & Hierarchy

```rust
Transform {
    translation: Vec3::new(x, y, z),
    rotation: Quat::from_rotation_z(angle),
    scale: Vec3::ONE,
}

// Helpers
Transform::from_xyz(x, y, z)
Transform::from_rotation(quat)
Transform::from_scale(Vec3::splat(2.0))
transform.looking_at(target, Vec3::Y)
transform.rotate_z(radians)
transform.translate_around(point, rotation)

// GlobalTransform: auto-computed from hierarchy, read-only
```

### Parent-child hierarchy
```rust
commands.spawn(ParentComponent).with_children(|parent| {
    parent.spawn(ChildComponent);
});

// Or manually
commands.entity(parent_id).add_child(child_id);

// Query hierarchy
Query<&Children>  // children of entity
Query<&Parent>    // parent of entity

// Cleanup
commands.entity(parent_id).despawn_recursive();
```

## Input

### Keyboard
```rust
fn input(keyboard: Res<ButtonInput<KeyCode>>) {
    if keyboard.pressed(KeyCode::KeyW) { /* held */ }
    if keyboard.just_pressed(KeyCode::Space) { /* this frame */ }
    if keyboard.just_released(KeyCode::Escape) { /* released */ }
}
```

### Mouse
```rust
fn mouse(
    buttons: Res<ButtonInput<MouseButton>>,
    motion: Res<AccumulatedMouseMotion>,
    scroll: Res<AccumulatedMouseScroll>,
) {
    if buttons.pressed(MouseButton::Left) {}
    let delta = motion.delta;         // Vec2
    let scroll_delta = scroll.delta;  // Vec2
}
```

### Gamepad
```rust
fn gamepad(gamepads: Query<(Entity, &Gamepad)>) {
    for (entity, gamepad) in &gamepads {
        if gamepad.just_pressed(GamepadButton::South) {}
        let x = gamepad.get(GamepadAxis::LeftStickX).unwrap_or(0.0);
    }
}
```

## Events & Messages

Bevy has two event systems:
- **Events** (push-based): Use observers with `On<T>` — immediate, reactive
- **Messages** (pull-based): Use `MessageReader<T>`/`MessageWriter<T>` — polled each frame

### Events (observer-based, push)
```rust
#[derive(Event)]
struct Explosion { position: Vec3, radius: f32 }

// Entity-targeted events
#[derive(EntityEvent)]
struct Damage { amount: f32 }

// Trigger events
commands.trigger(Explosion { position: Vec3::ZERO, radius: 10.0 });
commands.entity(target).trigger(Damage { amount: 25.0 });

// React with observers (immediate)
app.add_observer(|trigger: On<Explosion>| {
    println!("Boom at {:?}", trigger.event().position);
});

// Entity observer
commands.spawn(Player).observe(|trigger: On<Pointer<Click>>| {
    println!("Player clicked");
});

// Component lifecycle observers
app.add_observer(|trigger: On<Add, Health>| { /* health added */ });
```

### Messages (pull-based, polled)
```rust
#[derive(Event)]
struct ScoreChanged { new_score: u32 }

// Write messages
fn score_system(mut writer: MessageWriter<ScoreChanged>) {
    writer.write(ScoreChanged { new_score: 100 });
}

// Read messages (polled each frame)
fn display_score(mut reader: MessageReader<ScoreChanged>) {
    for msg in reader.read() {
        println!("Score: {}", msg.new_score);
    }
}

// Register
app.add_event::<ScoreChanged>();
```

## State Management

### States
```rust
#[derive(States, Default, Debug, Clone, Copy, PartialEq, Eq, Hash)]
enum GameState {
    #[default]
    Menu,
    Playing,
    Paused,
    GameOver,
}

app.init_state::<GameState>()
   .add_systems(OnEnter(GameState::Playing), start_game)
   .add_systems(Update, game_logic.run_if(in_state(GameState::Playing)))
   .add_systems(OnExit(GameState::Playing), cleanup);

// Transition
fn transition(mut next: ResMut<NextState<GameState>>) {
    next.set(GameState::Playing);
}
```

### Sub-states (active only when parent in specific state)
```rust
#[derive(SubStates, Default, Debug, Clone, Copy, PartialEq, Eq, Hash)]
#[source(GameState = GameState::Playing)]
enum PauseState {
    #[default]
    Running,
    Paused,
}

app.add_sub_state::<PauseState>();
```

### Auto-cleanup on state exit
```rust
commands.spawn((Player, DespawnOnExit(GameState::Playing)));
```

## Assets

```rust
// Load (async, returns handle immediately)
let texture: Handle<Image> = asset_server.load("textures/player.png");
let font: Handle<Font> = asset_server.load("fonts/main.ttf");
let scene: Handle<Scene> = asset_server.load("models/level.glb#Scene0");

// Create runtime assets
let mesh_handle = meshes.add(Cuboid::new(1.0, 1.0, 1.0));
let mat_handle = materials.add(StandardMaterial { base_color: Color::RED, ..default() });

// Check loaded
if asset_server.is_loaded_with_dependencies(&handle) { /* ready */ }
```

## UI

### Layout (Flexbox)
```rust
commands.spawn((
    Node {
        width: Val::Percent(100.0),
        height: Val::Percent(100.0),
        flex_direction: FlexDirection::Column,
        justify_content: JustifyContent::Center,
        align_items: AlignItems::Center,
        row_gap: Val::Px(10.0),
        column_gap: Val::Px(10.0),
        ..default()
    },
)).with_children(|parent| {
    parent.spawn((
        Button,
        Node { width: Val::Px(150.0), height: Val::Px(50.0), ..default() },
        BackgroundColor(Color::srgb(0.2, 0.2, 0.2)),
    )).with_children(|btn| {
        btn.spawn((
            Text::new("Play"),
            TextFont { font_size: FontSize::Px(24.0), ..default() },
            TextColor(Color::WHITE),
        ));
    });
});
```

### Button interaction
```rust
fn button_system(
    mut query: Query<(&Interaction, &mut BackgroundColor), (Changed<Interaction>, With<Button>)>,
) {
    for (interaction, mut color) in &mut query {
        *color = match *interaction {
            Interaction::Pressed => Color::srgb(0.35, 0.75, 0.35).into(),
            Interaction::Hovered => Color::srgb(0.25, 0.25, 0.25).into(),
            Interaction::None => Color::srgb(0.15, 0.15, 0.15).into(),
        };
    }
}
```

## Animation

### Timer-based sprite animation
```rust
#[derive(Component, Deref, DerefMut)]
struct AnimTimer(Timer);

#[derive(Component)]
struct AnimFrames { first: usize, last: usize }

fn animate(time: Res<Time>, mut query: Query<(&mut AnimTimer, &AnimFrames, &mut Sprite)>) {
    for (mut timer, frames, mut sprite) in &mut query {
        timer.tick(time.delta());
        if timer.just_finished() {
            if let Some(atlas) = &mut sprite.texture_atlas {
                atlas.index = if atlas.index >= frames.last { frames.first } else { atlas.index + 1 };
            }
        }
    }
}
```

## Timing

```rust
// Frame delta
fn sys(time: Res<Time>) {
    let dt = time.delta_secs();
    let elapsed = time.elapsed_secs();
}

// Fixed timestep
app.insert_resource(Time::<Fixed>::from_seconds(1.0 / 60.0));
app.add_systems(FixedUpdate, physics);

// Custom timer resource
#[derive(Resource)]
struct SpawnTimer(Timer);

fn tick_timer(time: Res<Time>, mut timer: ResMut<SpawnTimer>) {
    if timer.0.tick(time.delta()).just_finished() {
        // spawn something
    }
}
```

## Component Hooks

```rust
world.register_component_hooks::<MyComponent>()
    .on_add(|mut world, ctx| { /* first time added */ })
    .on_insert(|mut world, ctx| { /* any insert */ })
    .on_remove(|mut world, ctx| { /* before removal */ })
    .on_discard(|mut world, ctx| { /* before replacement */ });
```

## Generic Systems

```rust
fn cleanup<T: Component>(mut commands: Commands, q: Query<Entity, With<T>>) {
    for e in &q { commands.entity(e).despawn_recursive(); }
}

app.add_systems(OnExit(GameState::Playing), cleanup::<Player>);
```

## Custom SystemParam

```rust
#[derive(SystemParam)]
struct GameState<'w, 's> {
    score: Res<'w, Score>,
    players: Query<'w, 's, &'static Player>,
}

fn sys(state: GameState) {
    println!("Score: {}, Players: {}", state.score.0, state.players.iter().len());
}
```

## Debug (Gizmos)

```rust
fn debug(mut gizmos: Gizmos) {
    gizmos.line(start, end, Color::WHITE);
    gizmos.circle_2d(center, radius, Color::RED);
    gizmos.sphere(Isometry3d::from_translation(pos), radius, Color::GREEN);
}
```

## Performance Tips

- `#[component(storage = "SparseSet")]` for frequently toggled components
- `#[component(immutable)]` for read-only data
- `commands.spawn_batch()` for bulk spawning
- `query.par_iter()` for parallel iteration
- Run conditions to skip idle systems
- `Changed<T>` / `Added<T>` to avoid processing unchanged data
- `set_if_neq()` to prevent false change detection triggers
