import sys
from netdiag.parser import parse_ping
from netdiag.analyzer import diagnose
from netdiag.analyzer import get_context

def status_from_metrics(m):
    if m["packet_loss"] is None:
        return "UNKNOWN"
    if m["packet_loss"] > 2:
        return "DEGRADED"
    if m["rtt_avg"] and m["rtt_avg"] > 150:
        return "SLOW"
    return "OK"

def main():
    if len(sys.argv) != 2:
        print("Usage: dashboard.py <ping_log>")
        return

    metrics = parse_ping(sys.argv[1])
    # status = status_from_metrics(metrics)
    #status, evidence = diagnose(metrics)
    # status, evidence, context = diagnose(metrics)
    # diagnosis = diagnose(metrics)

    # print("=== Network Status ===")
    # print(f"Status        : {status}")
    # print(f"Packet Loss   : {metrics['packet_loss']} %")
    # print(f"RTT min/avg/max: "
    #       f"{metrics['rtt_min']} / {metrics['rtt_avg']} / {metrics['rtt_max']} ms")
    # print("Diagnosis     :", diagnosis)
    # print("Evidence      :", evidence)
    # if context:
    #     print("Context       :")
    #     for c in context:
    #         print(" -", c)
    status, diagnosis, evidence, context = diagnose(metrics)

    print("Status        :", status)
    print("Diagnosis     :", diagnosis)
    print("Packet Loss   :", metrics["packet_loss"], "%")
    print("RTT min/avg/max:",
          metrics["rtt_min"], "/", metrics["rtt_avg"], "/", metrics["rtt_max"], "ms")
    print("Evidence      :", evidence)
    
    if context:
        print("Context       :")
        for c in context:
            print(" -", c)
    

if __name__ == "__main__":
    main()
