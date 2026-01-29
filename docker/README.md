# BlueROV2 Gazebo Docker

Docker image for running BlueROV2 simulation in Gazebo Harmonic with VNC support.

## Building the Image

**Important:** Build from the parent directory (not from inside `docker/`):

```bash
cd /path/to/bluerov2_gz
docker build -f docker/Dockerfile -t bluerov2_gz:latest .
```

Or use the build script:

```bash
./docker/build.sh
```

This ensures the `models/` and `worlds/` directories are included in the build context.

## Running the Simulation

### GUI Mode (with VNC)

Run Gazebo with a virtual display accessible via VNC:

```bash
docker run -it --rm \
  -p 5900:5900 \
  -p 10317-10330:10317-10330/udp \
  --name gazebo-gui \
  bluerov2_gz:latest \
  /home/bluerov2/start_gui.sh
```

Connect via VNC:
- **Host:** `localhost:5900`
- **Password:** `gazebo`

Use any VNC client (macOS Screen Sharing: `vnc://localhost:5900`, or RealVNC Viewer).

### Headless Mode (Server Only)

Run Gazebo without GUI (for SITL integration):

```bash
docker run -it --rm \
  -p 10317-10330:10317-10330/udp \
  --name gazebo-headless \
  bluerov2_gz:latest
```

### Debug Mode (Interactive Shell)

Get a shell inside the container:

```bash
docker run -it --rm \
  -p 5900:5900 \
  -p 10317-10330:10317-10330/udp \
  --name gazebo-debug \
  bluerov2_gz:latest \
  /bin/bash
```

Then run Gazebo manually:

```bash
gz sim -v 3 -r /home/bluerov2/bluerov2_gz/worlds/bluerov2_underwater.world
```

## Running with ArduSub SITL

1. Start Gazebo in headless mode (or GUI mode)
2. In another terminal, run ArduSub SITL:

```bash
sim_vehicle.py -L RATBeach -v ArduSub --model=JSON --out=udp:0.0.0.0:14550 --no-rebuild
```

## Available World Files

- `bluerov2_underwater.world` - BlueROV2 base configuration
- `bluerov2_heavy_underwater.world` - BlueROV2 Heavy configuration
- `bluerov2_ping.world` - BlueROV2 with Ping sonar

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 5900 | TCP | VNC server |
| 10317 | UDP | Gazebo discovery messages |
| 10318 | UDP | Gazebo service discovery |
