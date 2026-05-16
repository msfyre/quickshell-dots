pragma Singleton

import Quickshell

Singleton {
    id: root

    function truncateStringLeft(from: string, maxLength: int) {
        if (from.length <= maxLength)
            return from;

        return from.substring(0, maxLength) + "…";
    }

    function truncateStringRight(from: string, maxLength: int) {
        if (from.length <= maxLength)
            return from;

        return "…" + from.substring(from.length - maxLength);
    }
}
