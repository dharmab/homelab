grafana:
  dashboards:
  - content:
      style: dark
      rows:
      - repeat: None
        titleSize: h2
        repeatIteration: None
        title: Row title
        height: 478
        repeatRowId: None
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
            expr: (node_cpu{instance=~"$node:.*", mode="system"})
            step: 2
            legendFormat: System
            intervalFactor: 2
            refId: A
          - format: time_series
            expr: (node_cpu{instance=~"$node:.*", mode="user"})
            step: 2
            legendFormat: User
            intervalFactor: 2
            refId: B
          - format: time_series
            expr: (node_cpu{instance=~"$node:.*", mode="iowait"})
            step: 2
            legendFormat: I/O Wait
            intervalFactor: 2
            refId: C
          - format: time_series
            expr: (node_cpu{instance=~"$node:.*", mode="idle"})
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
            decimals: None
          - logBase: 1
            show: false
            max: None
            format: short
            min: None
            label: ''
          xaxis:
            buckets: None
            show: true
            values: []
            mode: time
            name: None
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
          timeFrom: None
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
            decimals: None
          - logBase: 1
            show: false
            max: None
            format: short
            min: None
            label: None
          xaxis:
            buckets: None
            show: false
            values: []
            mode: time
            name: None
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
            sideWidth: None
            min: false
            max: false
            show: true
            current: true
            values: true
            alignAsTable: false
            avg: false
          timeShift: None
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
      editMode: false
      links: []
      tags: []
      graphTooltip: 0
      hideControls: false
      title: system-performance
      editable: true
      refresh: false
      id: 3
      gnetId: None
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
      version: 35
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
          allValue: None
          tagValuesQuery: ''
          refresh: 1
          label: None
          current:
            text: server01.lab.dharmab.com
            value: server01.lab.dharmab.com
          datasource: Prometheus
          type: query
          query: label_values(node_boot_time, instance)
          useTags: false
          tagsQuery: ''
          options: []
          includeAll: false
    slug: system-performance

