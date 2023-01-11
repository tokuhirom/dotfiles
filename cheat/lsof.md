    lsof -i TCP:22

Which command opens too much files?

    lsof -U +c 15 | cut -f1 -d' ' | sort | uniq -c | sort -rn | head -3

