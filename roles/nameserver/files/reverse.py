#!/usr/bin/env python

import os
import sys

import dns.zone


def load_ipv4_a_records_from_zone(zone):
    return None


def get_origin_from_zone_file_name(zone_file):
    """
    Attempts to get the origin name from a zone file. Only works for files named '.*/<origin>(.(db|name))?'. Since I
    wrote this for use alongside configuration management that guarantees that zone files are named that way...

    ♫ I DON'T CARE ♫
    I ship it! https://www.youtube.com/watch?v=8Tc7MH5ZXbg

    (ship being a pun on "shipping code"... ah, forget it.)
    :param zone_file: Path to the zone file
    :return: normalized origin
    """
    zone_file = os.path.basename(zone_file)
    for extension in ["db", "zone"]:
        if zone_file.endswith(extension):
            return zone_file[: len(zone_file) - len(extension) - 1]


def main():
    zone_files = sys.argv[1:]
    ptrs = {}
    for zone_file in zone_files:
        try:
            origin = get_origin_from_zone_file_name(zone_file)
            print(origin)
            zone = dns.zone.from_file(zone_file, origin=origin)
            for name, ttl, resource in zone.iterate_rdatas('A'):
                ptrs[resource.address] = name
        except (dns.zone.UnknownOrigin, dns.zone.BadZone) as e:
            sys.stderr.write("Error reading zone file " + zone_file + ": " + str(e))


if __name__ == '__main__':
    main()
