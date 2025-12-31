import subprocess

def get_context():
    ctx = []

    try:
        out = subprocess.check_output(["ip", "link"], text=True)

        if "wlp" in out or "wlan" in out:
            ctx.append("Active interface appears to be Wi-Fi")

        if "wg0" in out:
            ctx.append("WireGuard interface detected")

    except Exception:
        pass

    return ctx

def diagnose(m):
    context = get_context()

    if m["packet_loss"] is None:
        return (
            "UNKNOWN",
            "Unable to determine network health",
            "No summary data found",
            context
        )

    if m["packet_loss"] > 2:
        return (
            "DEGRADED",
            "Packet loss detected",
            f"Packet loss {m['packet_loss']}% > 2% threshold",
            context
        )

    if m["rtt_avg"] and m["rtt_avg"] > 150:
        return (
            "SLOW",
            "High network latency detected",
            f"Average RTT {m['rtt_avg']} ms > 150 ms threshold",
            context
        )

    return (
        "OK",
        "Network operating normally",
        "All metrics within thresholds",
        context
    )

