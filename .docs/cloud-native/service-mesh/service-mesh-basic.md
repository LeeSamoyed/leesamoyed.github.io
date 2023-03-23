# 服务网格

## 服务网格分类

**数据平面**

管理实例之间网络流量的部分（运行各个业务实例前端的代理所组成的网络）

**控制平面**

与前端代理通信控制其工作逻辑的组件

## 服务网格功能

=== "Traffic management"

    - Protocol: layer 7 (http, grpc)
    - Dynamic Routing: conditional, weighting, mirroring
    - Resiliency: timeouts, retries, circuit breakers
    - Policy: access control, rate limits, quotas
    - Testing: fault injection

=== "Security"

    - Encryption: mTLS, certificate management, external CA
    - Strong: ldentity: SPIFFE or similar
    - Auth: authentication, authorisation

=== "Observability"

    - Metrics: golden metrics, prometheus, grafana
    - Tracing: traces across workloads
    - Traffic: cluster, ingress/egress

=== "Mesh"

    - Supported Compute: Kubernetes, virtual machines
    - Multi-cluster: gateways, federation
