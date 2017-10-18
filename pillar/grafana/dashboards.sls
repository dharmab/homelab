grafana:
  dashboards:
  - content:
      style: dark
      rows:
      - repeat: ''
        titleSize: h2
        repeatIteration: ''
        title: Row title
        height: 478
        repeatRowId: ''
        panels:
        - bars: false
          timeFrom: ''
          links: []
          thresholds: []
          spaceLength: 10
          nullPointMode: 'null'
          renderer: flot
          linewidth: 1
          steppedLine: false
          id: 1
          fill: 1
          span: 6
          title: CPU
          tooltip:
            sort: 2
            shared: true
            value_type: individual
          legend:
            total: false
            show: true
            max: false
            min: false
            current: false
            values: false
            avg: false
          targets:
          - format: time_series
            expr: sum(node_cpu{instance=~"$node:.*", mode="system"})
            step: 2
            legendFormat: System
            intervalFactor: 2
            refId: A
          - format: time_series
            expr: sum(node_cpu{instance=~"$node:.*", mode="user"})
            step: 2
            legendFormat: User
            intervalFactor: 2
            refId: B
          - format: time_series
            expr: sum(node_cpu{instance=~"$node:.*", mode="iowait"})
            step: 2
            legendFormat: I/O Wait
            intervalFactor: 2
            refId: C
          - format: time_series
            expr: sum(node_cpu{instance=~"$node:.*", mode="idle"})
            step: 2
            legendFormat: Idle
            intervalFactor: 2
            refId: D
          transparent: true
          yaxes:
          - logBase: 1
            min: '0'
            max: '101'
            format: short
            label: ''
            show: true
            decimals: ''
          - logBase: 1
            show: false
            max: ''
            format: short
            min: ''
            label: ''
          xaxis:
            buckets: ''
            show: true
            values: []
            mode: time
            name: ''
          seriesOverrides:
          - alias: Idle
            lines: false
            fill: 0
          - color: '#BF1B00'
            alias: System
          - color: '#EAB839'
            alias: User
          - color: '#6ED0E0'
            alias: I/O Wait
          percentage: true
          type: graph
          dashes: false
          repeat: cpu
          dashLength: 10
          stack: true
          timeShift: ''
          aliasColors: {}
          lines: true
          points: false
          datasource: Prometheus
          pointradius: 5
        - bars: false
          timeFrom: ''
          links: []
          thresholds: []
          spaceLength: 10
          nullPointMode: 'null'
          renderer: flot
          linewidth: 1
          steppedLine: false
          id: 2
          fill: 1
          span: 6
          title: Memory
          tooltip:
            sort: 0
            shared: true
            value_type: individual
            msResolution: true
          stack: true
          targets:
          - format: time_series
            expr: node_memory_MemTotal{instance=~"$node:.*"} - node_memory_MemAvailable
            step: 2
            legendFormat: Used
            intervalFactor: 2
            refId: B
          - format: time_series
            expr: node_memory_Buffers{instance=~"$node:.*"} + node_memory_Cached
            step: 2
            legendFormat: Buffers + Cache
            intervalFactor: 2
            refId: C
          - format: time_series
            expr: node_memory_MemFree{instance=~"$node:.*"}
            step: 2
            legendFormat: Free
            intervalFactor: 2
            refId: A
          transparent: true
          yaxes:
          - logBase: 1
            min: 0
            max: '100'
            format: bytes
            label: ''
            show: true
            decimals: ''
          - logBase: 1
            show: false
            max: ''
            format: short
            min: ''
            label: ''
          xaxis:
            buckets: ''
            show: false
            values: []
            mode: time
            name: ''
          seriesOverrides:
          - alias: Free
            lines: false
            fill: 0
          - color: '#BF1B00'
            alias: Used
            fill: 10
          - color: '#EAB839'
            alias: Buffers + Cache
            dashes: true
          percentage: true
          type: graph
          dashes: false
          error: false
          editable: true
          grid: {}
          dashLength: 10
          legend:
            rightSide: false
            total: false
            sideWidth: ''
            min: false
            max: false
            show: true
            current: true
            values: true
            alignAsTable: true
            avg: false
          timeShift: ''
          aliasColors:
            Unavailable Memory: '#7EB26D'
            Available Memory: '#7EB26D'
          lines: true
          points: false
          datasource: Prometheus
          pointradius: 5
          decimals: 2
        showTitle: false
        collapse: false
      - repeat: ''
        titleSize: h6
        repeatIteration: ''
        title: Dashboard Row
        height: 250
        repeatRowId: ''
        panels:
        - bars: false
          timeFrom: ''
          links: []
          thresholds: []
          spaceLength: 10
          nullPointMode: null as zero
          renderer: flot
          linewidth: 1
          steppedLine: false
          id: 3
          fill: 1
          span: 12
          title: Network Traffic
          tooltip:
            sort: 0
            shared: true
            value_type: individual
          legend:
            rightSide: false
            total: false
            min: false
            max: false
            show: true
            current: true
            values: true
            alignAsTable: true
            avg: false
          targets:
          - format: time_series
            expr: sum(rate(node_network_transmit_bytes{instance=~"$node:.*", device!="lo"}[$interval]))
            step: 2
            legendFormat: Transmit
            intervalFactor: 2
            refId: A
          - format: time_series
            expr: sum(rate(node_network_receive_bytes{instance=~"$node:.*", device!="lo"}[$interval]))
            step: 2
            legendFormat: Receive
            intervalFactor: 2
            refId: B
          transparent: true
          yaxes:
          - logBase: 1
            min: '0'
            max:
            format: Bps
            label: ''
            show: true
            decimals:
          - logBase: 1
            show: true
            max:
            format: short
            min:
            label: ''
          xaxis:
            buckets: ''
            show: true
            values: []
            mode: time
            name: ''
          seriesOverrides:
          - color: '#0A50A1'
            alias: Transmit
          - color: '#BF1B00'
            alias: Receive
          percentage: false
          type: graph
          dashes: false
          description: ''
          dashLength: 10
          stack: false
          timeShift: ''
          aliasColors: {}
          lines: true
          points: false
          datasource: Prometheus
          pointradius: 5
          decimals: 2
        showTitle: false
        collapse: false
      - repeat: ''
        titleSize: h6
        repeatIteration: ''
        title: Dashboard Row
        height: 170
        repeatRowId: ''
        panels:
        - sort:
            col: 0
            desc: true
          styles:
          - alias: Time
            type: hidden
            link: false
            pattern: Time
            dateFormat: YYYY-MM-DD HH:mm:ss
          - type: number
            dateFormat: YYYY-MM-DD HH:mm:ss
            pattern: Value
            thresholds:
            - '75'
            - '90'
            alias: Utilization
            colors:
            - rgba(0, 0, 0, 0)
            - rgba(175, 225, 25, 0.89)
            - rgba(172, 45, 45, 0.97)
            colorMode: cell
            decimals: 2
            unit: percentunit
          timeFrom: 0s
          span: 12
          pageSize: ''
          links: []
          title: Disk Usage
          timeShift: ''
          yaxes: ''
          transform: table
          showHeader: true
          scroll: true
          targets:
          - intervalFactor: 2
            expr: label_replace(sort(1 - (node_filesystem_free{instance=~"$node:.*",
              mountpoint=~"/rootfs/.*", fstype!~"(tmpfs|vboxsf)"} / node_filesystem_size)
              > 0), "mountpoint", "$1", "mountpoint", "/rootfs(.*)")
            step: 2
            refId: A
            format: table
          hideTimeOverride: false
          fontSize: 100%
          datasource: Prometheus
          xaxis: ''
          type: table
          id: 4
          columns: []
        showTitle: false
        collapse: false
      editMode: false
      links: []
      tags: []
      graphTooltip: 0
      hideControls: false
      title: system-performance
      editable: true
      refresh: 5s
      id: 3
      gnetId:
      timepicker:
        time_options:
        - 5m
        - 15m
        - 1h
        - 6h
        - 12h
        - 24h
        - 2d
        - 7d
        - 30d
        refresh_intervals:
        - 5s
        - 10s
        - 30s
        - 1m
        - 5m
        - 15m
        - 30m
        - 1h
        - 2h
        - 1d
      version: 46
      time:
        to: now
        from: now-15m
      timezone: browser
      schemaVersion: 14
      annotations:
        list: []
      templating:
        list:
        - regex: (.*):.*
          sort: 1
          multi: false
          hide: 1
          name: node
          tags: []
          allValue: ''
          tagValuesQuery: ''
          refresh: 1
          label: ''
          current:
            text: server02.lab.dharmab.com
            selected: false
            value: server02.lab.dharmab.com
          datasource: Prometheus
          type: query
          query: label_values(node_boot_time, instance)
          useTags: false
          tagsQuery: ''
          options: []
          includeAll: false
        - hide: 0
          name: interval
          auto_count: 30
          auto: true
          refresh: 2
          label: Interval
          current:
            text: auto
            value: $__auto_interval
          auto_min: 30s
          query: 30s,1m,2m,3m,5m,7m,10m,30m,1h,6h,12h,1d,7d,14d,30d
          type: interval
          options:
          - text: auto
            selected: true
            value: $__auto_interval
          - text: 30s
            selected: false
            value: 30s
          - text: 1m
            selected: false
            value: 1m
          - text: 2m
            selected: false
            value: 2m
          - text: 3m
            selected: false
            value: 3m
          - text: 5m
            selected: false
            value: 5m
          - text: 7m
            selected: false
            value: 7m
          - text: 10m
            selected: false
            value: 10m
          - text: 30m
            selected: false
            value: 30m
          - text: 1h
            selected: false
            value: 1h
          - text: 6h
            selected: false
            value: 6h
          - text: 12h
            selected: false
            value: 12h
          - text: 1d
            selected: false
            value: 1d
          - text: 7d
            selected: false
            value: 7d
          - text: 14d
            selected: false
            value: 14d
          - text: 30d
            selected: false
            value: 30d
    slug: system-performance

