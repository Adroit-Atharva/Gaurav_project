import re

def parse_ping(file_path):
    stats = {
        "packet_loss": None,
        "rtt_min": None,
        "rtt_avg": None,
        "rtt_max": None,
    }

    with open(file_path) as f:
        for line in f:
            if "packet loss" in line:
                # e.g. "20 packets transmitted, 20 received, 0% packet loss"
                loss = re.search(r"(\d+)% packet loss", line)
                if loss:
                    stats["packet_loss"] = float(loss.group(1))

            if "min/avg/max" in line:
                # e.g. "rtt min/avg/max/mdev = 12.3/15.4/18.9/1.2 ms"
                parts = re.search(r"= ([\d.]+)/([\d.]+)/([\d.]+)", line)
                if parts:
                    stats["rtt_min"] = float(parts.group(1))
                    stats["rtt_avg"] = float(parts.group(2))
                    stats["rtt_max"] = float(parts.group(3))

    return stats
