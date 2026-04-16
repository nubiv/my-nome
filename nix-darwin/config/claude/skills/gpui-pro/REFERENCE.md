# GPUI Reference

## Styling API (Tailwind-like)

All methods available on anything implementing `Styled` (e.g., `div()`).

### Layout
| Method | CSS Equivalent |
|--------|---------------|
| `flex()` | `display: flex` |
| `block()` | `display: block` |
| `grid()` | `display: grid` |
| `hidden()` | `display: none` |
| `flex_row()` | `flex-direction: row` |
| `flex_col()` | `flex-direction: column` |
| `flex_wrap()` | `flex-wrap: wrap` |
| `flex_1()` | `flex: 1 1 0` |
| `flex_auto()` | `flex: 1 1 auto` |
| `flex_none()` | `flex: 0 0` |
| `flex_grow()` | `flex-grow: 1` |
| `flex_shrink_0()` | `flex-shrink: 0` |

### Alignment
| Method | CSS Equivalent |
|--------|---------------|
| `items_start()` | `align-items: flex-start` |
| `items_center()` | `align-items: center` |
| `items_end()` | `align-items: flex-end` |
| `items_baseline()` | `align-items: baseline` |
| `items_stretch()` | `align-items: stretch` |
| `justify_start()` | `justify-content: start` |
| `justify_center()` | `justify-content: center` |
| `justify_end()` | `justify-content: end` |
| `justify_between()` | `justify-content: space-between` |
| `justify_around()` | `justify-content: space-around` |
| `justify_evenly()` | `justify-content: space-evenly` |
| `self_center()` | `align-self: center` |

### Sizing (macro-generated `style_helpers!`)
```
w_{n}()     — width      (w_full, w_auto, w_1, w_2, ... w_96)
h_{n}()     — height     (h_full, h_auto, h_1, h_2, ... h_96)
size_{n}()  — w + h      (size_full, size_4, size_8, ...)
min_w_{n}() — min-width  | max_w_{n}() — max-width
min_h_{n}() — min-height | max_h_{n}() — max-height
```

### Spacing
```
p_{n}()  — padding all    | px_{n}() — padding x | py_{n}() — padding y
pt, pb, pl, pr — individual padding sides
m_{n}()  — margin all     | mx_{n}() — margin x  | my_{n}() — margin y
mt, mb, ml, mr — individual margin sides
gap_{n}() — flex/grid gap | gap_x_{n}() | gap_y_{n}()
```

### Position
```
relative() | absolute() | fixed()
top_{n}() | bottom_{n}() | left_{n}() | right_{n}()
inset_{n}() — all sides
```

### Borders & Rounded
```
border_{n}()     — all borders (border_1, border_2, ...)
border_t/b/l/r() — individual sides
border_color()   — border color (Hsla)
border_dashed()  — dashed style
rounded_{size}() — border-radius (rounded_sm, rounded_md, rounded_lg, rounded_full)
```

### Shadows
```
shadow_sm() | shadow_md() | shadow_lg() | shadow_xl() | shadow_2xl() | shadow_none()
```

### Overflow
```
overflow_hidden() | overflow_x_hidden() | overflow_y_hidden()
overflow_scroll() | overflow_x_scroll() | overflow_y_scroll()
overflow_visible()
```

### Colors & Background
```
bg(fill)           — background (accepts Hsla, gpui::rgb(), theme colors)
text_color(color)   — text color
opacity(f32)        — 0.0 to 1.0
```

### Typography
```
text_xs() | text_sm() | text_base() | text_lg() | text_xl() | text_2xl() | text_3xl()
text_color(color) | font_weight(weight) | font_family(name)
italic() | underline() | line_through() | truncate()
text_left() | text_center() | text_right()
line_height(height) | whitespace_nowrap()
```

### Grid
```
grid_cols(count) | grid_rows(count)
col_span(n) | col_start(n) | col_end(n) | col_span_full()
row_span(n) | row_start(n) | row_end(n) | row_span_full()
```

### Cursors
```
cursor_default() | cursor_pointer() | cursor_text() | cursor_move()
cursor_not_allowed() | cursor_grab() | cursor_grabbing()
```

### Aspect Ratio
```
aspect_ratio(f32) | aspect_square()
```

## Element Interactivity

Event handlers on `div()` and interactive elements:

```rust
div()
    .id("my-el")  // Required for interactivity
    .on_click(cx.listener(|this, event, window, cx| { ... }))
    .on_mouse_down(MouseButton::Left, cx.listener(|this, event, window, cx| { ... }))
    .on_mouse_up(MouseButton::Left, cx.listener(|this, event, window, cx| { ... }))
    .on_mouse_move(cx.listener(|this, event, window, cx| { ... }))
    .on_hover(cx.listener(|this, hovered, window, cx| { ... }))
    .on_key_down(cx.listener(|this, event, window, cx| { ... }))
    .on_key_up(cx.listener(|this, event, window, cx| { ... }))
    .on_action::<MyAction>(cx.listener(|this, action, window, cx| { ... }))
    .on_drag(DragPayload, |payload, window, cx| { ... })
    .on_drop::<DragPayload>(cx.listener(|this, payload, window, cx| { ... }))
```

**Important**: Elements need `.id("unique")` to receive events.

## Entity & State Management

```rust
// Define state
struct Counter { count: i32 }

// Create entity
let entity: Entity<Counter> = cx.new(|_cx| Counter { count: 0 });

// Read state
let val = entity.read(cx).count;

// Update state (triggers re-render if view)
entity.update(cx, |this, cx| {
    this.count += 1;
    cx.notify(); // Signal that view needs re-render
});

// Observe changes
cx.observe(&entity, |this, entity, cx| { /* entity changed */ }).detach();

// Subscribe to events
cx.subscribe(&entity, |this, entity, event, cx| { /* handle event */ }).detach();
```

### Emitting Events

```rust
// Define event
struct Submitted(String);

// In your view
impl Counter {
    fn submit(&mut self, cx: &mut Context<Self>) {
        cx.emit(Submitted(self.value.clone()));
    }
}
```

## Actions & Keybindings

```rust
// Define action
#[derive(Clone, Default, PartialEq, Debug)]
struct Save;
impl_actions!(my_app, [Save]);

// Register handler
cx.on_action::<Save>(|action, window, cx| { ... });

// Bind keys
cx.bind_keys([KeyBinding::new("cmd-s", Save, None)]);
```

## Window Management

```rust
// Open window with options
cx.open_window(
    WindowOptions {
        window_bounds: Some(WindowBounds::Windowed(Bounds {
            origin: point(px(0.), px(0.)),
            size: size(px(800.), px(600.)),
        })),
        titlebar: Some(TitlebarOptions {
            title: Some("My App".into()),
            ..Default::default()
        }),
        ..Default::default()
    },
    |window, cx| { /* create root view */ },
);
```

## Globals

```rust
// Set global state
cx.set_global(AppSettings { dark_mode: true });

// Read global
let settings = cx.global::<AppSettings>();

// Observe changes
cx.observe_global::<AppSettings>(|cx| { /* settings changed */ }).detach();
```

## Custom Components (RenderOnce)

```rust
#[derive(IntoElement)]
struct Card {
    title: SharedString,
    children: Vec<AnyElement>,
}

impl Card {
    fn new(title: impl Into<SharedString>) -> Self {
        Self { title: title.into(), children: vec![] }
    }
}

impl RenderOnce for Card {
    fn render(self, _window: &mut Window, _cx: &mut App) -> impl IntoElement {
        div()
            .p_4()
            .rounded_lg()
            .border_1()
            .border_color(gpui::rgb(0xe0e0e0))
            .bg(gpui::rgb(0xffffff))
            .child(div().text_lg().font_weight(FontWeight::BOLD).child(self.title))
            .children(self.children)
    }
}

// Supports ParentElement for .child() API:
impl ParentElement for Card {
    fn extend(&mut self, elements: impl IntoIterator<Item = AnyElement>) {
        self.children.extend(elements);
    }
}
```

## gpui-component Library (60+ components)

### Setup
```rust
// In main(), before opening windows:
gpui_component::init(cx);

// Window root must be wrapped:
cx.new(|cx| Root::new(view, window, cx).bg(cx.theme().background))
```

### Components Available

**Buttons & Actions**
- `Button::new("id").label("Text").primary()` — variants: `.primary()`, `.secondary()`, `.danger()`, `.outline()`, `.ghost()`, `.link()`
- `Button::new("id").icon(Icon::new(IconName::Plus))` — icon button
- `Button::new("id").label("Save").loading(is_loading)` — loading state

**Inputs**
- `TextInput` — text field with validation
- `Checkbox` — toggle with label
- `Radio` — radio button groups
- `Switch` — on/off toggle
- `Select` — dropdown selection
- `Slider` — range input
- `ColorPicker` — color selection

**Display**
- `Label` — text display
- `Badge` — status indicators
- `Tag` — categorization labels
- `Icon` — SVG icon rendering (Lucide icons)
- `Skeleton` — loading placeholders
- `Spinner` — loading indicator
- `Progress` — progress bars
- `Rating` — star ratings

**Layout**
- `Divider` — visual separator
- `Accordion` — collapsible sections
- `Tab` — tabbed navigation
- `Breadcrumb` — navigation trail
- `Sidebar` — side navigation
- `Dock` — panel management with resizing
- `Resizable` — resizable panels

**Overlay**
- `Dialog` — modal dialogs
- `Popover` — contextual popups
- `Tooltip` — hover information
- `Sheet` — slide-in panels
- `Menu` — context/dropdown menus
- `Notification` — toast messages
- `HoverCard` — rich hover content

**Data**
- `Table` — virtualized data table with column resizing
- `List` — virtualized list
- `Tree` — hierarchical tree view
- `VirtualList` — efficient large-list rendering
- `DescriptionList` — key-value pairs
- `Pagination` — page navigation

**Rich Content**
- `TextView` — selectable text
- `Editor` — code editor (200K+ lines, Tree-sitter, LSP)
- Markdown renderer
- HTML renderer
- `Chart` / `Plot` — data visualization

**Navigation**
- `Link` — hyperlink
- `Kbd` — keyboard shortcut display
- `TitleBar` — window title bar
- `Stepper` — step-by-step flow

**Form**
- `Form` — form layout and validation
- `GroupBox` — grouped controls

### Theming

```rust
// Access theme colors
let bg = cx.theme().background;
let fg = cx.theme().foreground;
let primary = cx.theme().primary;

// Theme has: background, foreground, card, primary, secondary,
// destructive, muted, accent, border, ring, ...
```

### Size Variants

Most components support: `.xsmall()`, `.small()`, `.medium()` (default), `.large()`

## Async in GPUI

```rust
// Spawn async task
cx.spawn(async move |cx| {
    let data = fetch_data().await;
    cx.update(|cx| {
        // Update UI on main thread
    });
}).detach();

// Background executor
cx.background_executor().spawn(async { heavy_computation() }).detach();
```

## Testing

```rust
#[gpui::test]
async fn test_my_view(cx: &mut TestAppContext) {
    let view = cx.add_window(|cx| MyView::new(cx));
    // Simulate interactions
    view.update(cx, |view, cx| {
        assert_eq!(view.count, 0);
    });
}
```

## Cargo.toml Template

```toml
[package]
name = "my-gpui-app"
version = "0.1.0"
edition = "2021"

[dependencies]
gpui = { git = "https://github.com/zed-industries/zed" }
gpui_platform = { git = "https://github.com/zed-industries/zed" }
gpui-component = { git = "https://github.com/longbridge/gpui-component" }
anyhow = "1"
```

## Platform Notes

- **macOS**: Metal rendering. Requires Xcode + command line tools.
- **Linux**: Supported. Uses Vulkan/OpenGL.
- **Windows**: Check latest GPUI status.
- GPUI is pre-1.0 — expect breaking changes between versions.
