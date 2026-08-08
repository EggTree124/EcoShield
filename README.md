# EcoShield 🌱

**EcoShield** is a small environmental management strategy game made with **Godot**.

The player manages a neighborhood while dealing with two growing problems: **waste accumulation** and **flooding**. Players must spend limited resources wisely, place infrastructure, and keep the neighborhood safe and clean.

> 🚧 **Status: In Development**
>
> EcoShield is currently an early prototype. Core systems are being developed and balanced.

---

## 🎮 Game Concept

In EcoShield, every house produces waste over time. Environmental problems can develop if the player does not manage the neighborhood properly.

The player has limited:

* 💰 **Money** — used to build infrastructure.
* ⚡ **Action Points (AP)** — used to perform certain actions.
* 🏆 **Score** — represents the player's environmental performance.

The goal is to maintain a healthy neighborhood while managing limited resources.

---

## 🌍 Current Systems

### 🏠 Houses

Each house has its own:

* House name
* Number of residents
* Waste level
* Maximum waste capacity
* Waste generation rate
* Flood status

Waste increases automatically as time passes.

---

### 🗑️ Waste System

Houses continuously generate waste.

If waste is allowed to accumulate, the neighborhood becomes harder to manage.

The player will eventually gain tools to control waste generation and clean up accumulated waste.

---

### 🌊 Flood System
Certain areas of the map can become flooded.
Flood zones have:
* Water level
* Maximum water level
* Flood growth speed

Houses located inside dangerous flood areas can become flooded when the water level becomes high enough.

---

### 🚰 Drainage System

Players can construct drainage infrastructure to reduce water levels.

Drainage:

* Costs money to build
* Occupies space on the map
* Automatically reduces nearby flood-zone water levels

This gives the player a way to actively manage flooding rather than simply reacting to it.

---

### 🗑️ Trash Bin

Trash Bins are planned as one of the main waste-control tools.

**Planned behavior:**

* Costs money to construct
* Costs 1 AP
* Reduces waste generation for houses within its radius
* Example effect: **−50% waste generation**

This creates a strategic decision between preventing waste and dealing with waste after it has already accumulated.

---

### 🧹 Cleanup Action

A planned player action that allows accumulated waste to be removed directly.

Unlike the Trash Bin, which prevents waste from accumulating quickly, Cleanup is intended to deal with waste that already exists.

---

## 🧠 Core Gameplay Loop

```text
Houses generate waste
        ↓
Environmental problems increase
        ↓
Player evaluates the neighborhood
        ↓
Spend money / AP
        ↓
Build infrastructure or perform actions
        ↓
Reduce waste and flooding
        ↓
Continue managing the neighborhood
```

The main challenge is deciding **what problem needs attention first**.

---

## 💰 Resource Management

EcoShield is designed around limited resources.

### Money

Used primarily for construction and infrastructure.

Example:

```text
Starting Money: $100
Drainage Cost:  $30
```

### Action Points

AP limits how many important actions the player can perform during a turn/day.

This prevents the player from solving every problem immediately.

### Score

The score represents the player's environmental performance.

Example:

```text
Score: 150 kg
```

The scoring system is still being developed and will be balanced around waste management, flooding, and successful environmental decisions.

---

## 🛠️ Technology

* **Engine:** Godot 4
* **Language:** GDScript
* **Genre:** Environmental Strategy / Management
* **Perspective:** 2D
* **Platform:** PC
* **Development:** Solo Project


---

## 🚧 Development Roadmap

### Completed

* [x] Basic 2D map
* [x] Houses
* [x] House selection
* [x] House information HUD
* [x] Automatic waste generation
* [x] Waste capacity
* [x] Flood zones
* [x] Flooding detection
* [x] Drainage construction
* [x] Drainage reducing flood levels
* [x] Basic money system

### In Development

* [ ] Trash Bin
* [ ] Cleanup Action
* [ ] Action Point system
* [ ] Improved scoring
* [ ] More environmental consequences
* [ ] Better HUD
* [ ] Balancing
* [ ] Audio
* [ ] Visual polish

### Future Ideas

* [ ] Multiple maps
* [ ] More infrastructure
* [ ] Different types of environmental disasters
* [ ] Increasing difficulty
* [ ] More detailed neighborhood simulation
* [ ] Final scoring system
* [ ] Tutorial
* [ ] Main menu and settings

---

## 🎯 Design Goals

EcoShield aims to make environmental management understandable through gameplay.
The game focuses on three principles:
### 1. Prevention
Prevent environmental problems before they become severe.
### 2. Resource Management
Money and AP are limited, so every decision has an opportunity cost.
### 3. Consequences
Poor environmental management should create problems that affect the neighborhood and the player's score.

---

## 📸 Screenshots

*Screenshots will be added as development progresses.*

---

## 📦 How to Run

1. Install **Godot 4**.
2. Clone or download this repository.
3. Open the project in Godot.
4. Import the project.
5. Run the main scene.

---

## 📜 License

This project is currently a personal development project.

License information will be added when the project is released publicly.

---

## 👤 Developer

**EcoShield** is developed as a solo game development project.

The project is also being used to practice:

* Godot
* GDScript
* 2D game development
* Game design
* UI/UX
* Resource management systems
* Simulation systems
* Environmental game mechanics

---

> **EcoShield — Manage the neighborhood. Protect the environment.**
