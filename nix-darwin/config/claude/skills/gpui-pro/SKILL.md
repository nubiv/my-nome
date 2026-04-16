---
name: gpui-pro
description: Build desktop GUI applications using GPUI (Zed's GPU-accelerated Rust UI framework) and gpui-component library. Use when user mentions GPUI, building desktop apps with Zed's framework, gpui-component, or wants to create GPU-rendered Rust UIs.
---

# GPUI Pro

## Quick Start

Minimal GPUI app with gpui-component:

```rust
use gpui::*;
use gpui_component::{button::*, *};

pub struct MyApp;

impl Render for MyApp {
    fn render(&mut self, _: &mut Window, _: &mut Context<Self>) -> impl IntoElement {
        div()
            .v_flex()
            .gap_2()
            .size_full()
            .items_center()
            .justify_center()
            .child("Hello, GPUI!")
            .child(
                Button::new("go")
                    .primary()
                    .label("Click Me")
                    .on_click(|_, _, _| println!("Clicked!")),
            )
    }
}

fn main() {
    gpui_platform::application().run(move |cx| {
        gpui_component::init(cx);
        cx.spawn(async move |cx| {
            cx.open_window(WindowOptions::default(), |window, cx| {
                let view = cx.new(|_| MyApp);
                cx.new(|cx| Root::new(view, window, cx).bg(cx.theme().background))
            })
            .expect("Failed to open window");
        })
        .detach();
    });
}
```

## Architecture

GPUI has three layers:

1. **Entities** — State containers accessed via `Entity<T>` handles. Created with `cx.new(|cx| State { .. })`.
2. **Views** — Entities implementing `Render` trait. Produce element trees each frame.
3. **Elements** — Low-level rendering primitives. Most code uses `div()` + `RenderOnce` components.

### Rendering Pipeline (per frame)

`request_layout` (compute size via Taffy) → `prepaint` (hitboxes, focus) → `paint` (GPU draw)

## Core Patterns

See [REFERENCE.md](REFERENCE.md) for:
- Full styling API (Tailwind-like methods)
- All gpui-component components (60+)
- Entity & event system
- Actions & keybindings
- Window management
- Custom element creation

## Key Rules

1. **Always wrap in Root** — First child of window must be `Root::new(view, window, cx)`
2. **Call `gpui_component::init(cx)`** before using any component
3. **Builder pattern everywhere** — Components use method chaining: `Button::new("id").primary().label("OK")`
4. **`div()` is your flex container** — Use `.flex_row()` / `.flex_col()` (or shorthand `.h_flex()` / `.v_flex()`)
5. **State lives in entities** — Mutate via `cx.notify()` to trigger re-render
6. **`RenderOnce` for components** — Stateless reusable components implement `RenderOnce` + `#[derive(IntoElement)]`
7. **`Render` for views** — Stateful views implement `Render` trait on an entity struct
