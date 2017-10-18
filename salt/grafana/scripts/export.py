#!/usr/bin/env python2

import ruamel.yaml
import os
import requests


def main():
    username = os.getenv('GRAFANA_USERNAME')
    password = os.getenv('GRAFANA_PASSWORD')
    baseurl = os.getenv('GRAFANA_URL')

    session = requests.Session()
    session.auth = (username, password)
    session.timeout = 5

    current_dashboards = get_dashboard_list(session, baseurl)

    exported_dashboards = []
    for meta in current_dashboards:
        dashboard = get_dashboard(session, baseurl, meta['uri'])
        # When time range keys are not set, the grafana4_dashboard Salt module
        # incorrectly imports them as the string 'None'
        for row in dashboard['dashboard']['rows']:
            for panel in row['panels']:
                for key in ['timeShift', 'timeFrom']:
                    if not panel.get(key, None):
                        panel[key] = ''
        exported_dashboards.append(
            {
                'slug': dashboard['meta']['slug'],
                'content': dashboard['dashboard'],
            }
        )
    sls = ruamel.yaml.dump({
        'grafana': {
            'dashboards': exported_dashboards
        }
    }, Dumper=ruamel.yaml.RoundTripDumper)
    print(sls)


def get_dashboard_list(session, baseurl):
    response = session.get(baseurl + '/api/search')
    response.raise_for_status()
    return [d for d in response.json() if d['type'] == 'dash-db' and d['uri'] != 'db/']


def get_dashboard(session, baseurl, path):
    response = session.get(baseurl + '/api/dashboards/' + path)
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    main()
