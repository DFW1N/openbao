module github.com/openbao/openbao

// The go version directive value isn't consulted when building our production binaries,
// and the vault module isn't intended to be imported into other projects.  As such the
// impact of this setting is usually rather limited.  Note however that in some cases the
// Go project introduces new semantics for handling of go.mod depending on the value.
//
// The general policy for updating it is: when the Go major version used on the branch is
// updated. If we choose not to do so at some point (e.g. because we don't want some new
// semantic related to Go module handling), this comment should be updated to explain that.
go 1.22

replace github.com/openbao/openbao/api => ./api

replace github.com/openbao/openbao/api/auth/approle => ./api/auth/approle

replace github.com/openbao/openbao/api/auth/kubernetes => ./api/auth/kubernetes

replace github.com/openbao/openbao/api/auth/userpass => ./api/auth/userpass

replace github.com/openbao/openbao/sdk => ./sdk

require (
	cloud.google.com/go/monitoring v1.15.1
	github.com/ProtonMail/go-crypto v0.0.0-20230626094100-7e9e0395ebec
	github.com/armon/go-metrics v0.4.1
	github.com/armon/go-radix v1.0.0
	github.com/asaskevich/govalidator v0.0.0-20230301143203-a9d515a09cc2
	github.com/axiomhq/hyperloglog v0.0.0-20220105174342-98591331716a
	github.com/cenkalti/backoff/v3 v3.2.2
	github.com/client9/misspell v0.3.4
	github.com/coreos/go-systemd v0.0.0-20191104093116-d3cd4ed1dbcf
	github.com/duosecurity/duo_api_golang v0.0.0-20190308151101-6c680f768e74
	github.com/dustin/go-humanize v1.0.1
	github.com/fatih/color v1.15.0
	github.com/fatih/structs v1.1.0
	github.com/favadi/protoc-go-inject-tag v1.4.0
	github.com/gammazero/workerpool v1.1.3
	github.com/ghodss/yaml v1.0.1-0.20190212211648-25d852aebe32
	github.com/go-errors/errors v1.4.2
	github.com/go-jose/go-jose/v3 v3.0.1
	github.com/go-ldap/ldap/v3 v3.4.4
	github.com/go-ldap/ldif v0.0.0-20200320164324-fd88d9b715b3
	github.com/go-sql-driver/mysql v1.6.0
	github.com/go-test/deep v1.1.0
	github.com/gocql/gocql v1.0.0
	github.com/golang-jwt/jwt/v4 v4.5.0
	github.com/golang/protobuf v1.5.3
	github.com/golangci/revgrep v0.0.0-20220804021717-745bb2f7c2e6
	github.com/google/go-cmp v0.5.9
	github.com/google/go-metrics-stackdriver v0.2.0
	github.com/google/tink/go v1.7.0
	github.com/hashicorp/cap v0.3.0
	github.com/hashicorp/consul/api v1.23.0
	github.com/hashicorp/errwrap v1.1.0
	github.com/hashicorp/eventlogger v0.2.1
	github.com/hashicorp/go-cleanhttp v0.5.2
	github.com/hashicorp/go-discover v0.0.0-20210818145131-c573d69da192
	github.com/hashicorp/go-hclog v1.5.0
	github.com/hashicorp/go-memdb v1.3.4
	github.com/hashicorp/go-metrics v0.5.3
	github.com/hashicorp/go-msgpack v1.1.5
	github.com/hashicorp/go-multierror v1.1.1
	github.com/hashicorp/go-plugin v1.4.9
	github.com/hashicorp/go-raftchunking v0.6.3-0.20191002164813-7e9e8525653a
	github.com/hashicorp/go-retryablehttp v0.7.2
	github.com/hashicorp/go-rootcerts v1.0.2
	github.com/hashicorp/go-secure-stdlib/base62 v0.1.2
	github.com/hashicorp/go-secure-stdlib/fileutil v0.1.0
	github.com/hashicorp/go-secure-stdlib/gatedwriter v0.1.1
	github.com/hashicorp/go-secure-stdlib/kv-builder v0.1.2
	github.com/hashicorp/go-secure-stdlib/mlock v0.1.3
	github.com/hashicorp/go-secure-stdlib/nonceutil v0.1.0
	github.com/hashicorp/go-secure-stdlib/parseutil v0.1.7
	github.com/hashicorp/go-secure-stdlib/password v0.1.1
	github.com/hashicorp/go-secure-stdlib/reloadutil v0.1.1
	github.com/hashicorp/go-secure-stdlib/strutil v0.1.2
	github.com/hashicorp/go-secure-stdlib/tlsutil v0.1.2
	github.com/hashicorp/go-sockaddr v1.0.6
	github.com/hashicorp/go-syslog v1.0.0
	github.com/hashicorp/go-uuid v1.0.3
	github.com/hashicorp/go-version v1.6.0
	github.com/hashicorp/golang-lru v0.5.4
	github.com/hashicorp/hcl v1.0.1-vault-5
	github.com/hashicorp/hcl/v2 v2.16.2
	github.com/hashicorp/raft v1.3.10
	github.com/hashicorp/raft-autopilot v0.2.0
	github.com/hashicorp/raft-boltdb/v2 v2.0.0-20210421194847-a7e34179d62c
	github.com/hashicorp/raft-snapshot v1.0.4
	github.com/hashicorp/vault-plugin-mock v0.16.1
	github.com/influxdata/influxdb1-client v0.0.0-20200827194710-b269163b24ab
	github.com/jackc/pgx/v4 v4.18.1
	github.com/jcmturner/gokrb5/v8 v8.4.4
	github.com/jefferai/isbadcipher v0.0.0-20190226160619-51d2077c035f
	github.com/jefferai/jsonx v1.0.0
	github.com/klauspost/compress v1.16.5
	github.com/kr/pretty v0.3.1
	github.com/kr/text v0.2.0
	github.com/mattn/go-colorable v0.1.13
	github.com/mattn/go-isatty v0.0.19
	github.com/mediocregopher/radix/v4 v4.1.4
	github.com/mholt/archiver/v3 v3.5.1
	github.com/michaelklishin/rabbit-hole/v2 v2.12.0
	github.com/mikesmitty/edkey v0.0.0-20170222072505-3356ea4e686a
	github.com/mitchellh/cli v1.1.5
	github.com/mitchellh/copystructure v1.2.0
	github.com/mitchellh/go-homedir v1.1.0
	github.com/mitchellh/go-testing-interface v1.14.1
	github.com/mitchellh/go-wordwrap v1.0.1
	github.com/mitchellh/mapstructure v1.5.0
	github.com/mitchellh/pointerstructure v1.2.1
	github.com/mitchellh/reflectwalk v1.0.2
	github.com/natefinch/atomic v0.0.0-20150920032501-a62ce929ffcc
	github.com/oklog/run v1.1.0
	github.com/okta/okta-sdk-golang/v2 v2.12.1
	github.com/openbao/go-kms-wrapping/entropy/v2 v2.0.1-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/v2 v2.0.16-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/wrappers/aead/v2 v2.0.9-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/wrappers/alicloudkms/v2 v2.0.3-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/wrappers/awskms/v2 v2.0.9-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/wrappers/azurekeyvault/v2 v2.0.11-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/wrappers/gcpckms/v2 v2.0.11-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/wrappers/ocikms/v2 v2.0.9-0.20240122151027-4d142be5e262
	github.com/openbao/go-kms-wrapping/wrappers/transit/v2 v2.0.11-0.20240122151027-4d142be5e262
	github.com/openbao/openbao-template v0.35.1-0.20240228162143-c99b5c146391
	github.com/openbao/openbao/api v1.9.2
	github.com/openbao/openbao/api/auth/approle v0.1.0
	github.com/openbao/openbao/api/auth/userpass v0.1.0
	github.com/openbao/openbao/sdk v0.9.2
	github.com/ory/dockertest/v3 v3.10.0
	github.com/patrickmn/go-cache v2.1.0+incompatible
	github.com/pires/go-proxyproto v0.6.1
	github.com/pkg/errors v0.9.1
	github.com/posener/complete v1.2.3
	github.com/pquerna/otp v1.2.1-0.20191009055518-468c2dd2b58d
	github.com/prometheus/client_golang v1.14.0
	github.com/prometheus/common v0.37.0
	github.com/rboyer/safeio v0.2.1
	github.com/ryanuber/columnize v2.1.2+incompatible
	github.com/ryanuber/go-glob v1.0.0
	github.com/sasha-s/go-deadlock v0.2.0
	github.com/sethvargo/go-limiter v0.7.1
	github.com/shirou/gopsutil/v3 v3.22.6
	github.com/stretchr/testify v1.8.4
	go.etcd.io/bbolt v1.3.7
	go.opentelemetry.io/otel v1.16.0
	go.opentelemetry.io/otel/sdk v1.14.0
	go.opentelemetry.io/otel/trace v1.16.0
	go.uber.org/atomic v1.11.0
	go.uber.org/goleak v1.2.1
	golang.org/x/crypto v0.17.0
	golang.org/x/exp v0.0.0-20231006140011-7918f672742d
	golang.org/x/net v0.18.0
	golang.org/x/oauth2 v0.14.0
	golang.org/x/sync v0.4.0
	golang.org/x/sys v0.15.0
	golang.org/x/term v0.15.0
	golang.org/x/text v0.14.0
	golang.org/x/tools v0.14.0
	google.golang.org/api v0.126.0
	google.golang.org/grpc v1.58.3
	google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.1.0
	google.golang.org/protobuf v1.31.0
	gopkg.in/jcmturner/goidentity.v3 v3.0.0
	gopkg.in/square/go-jose.v2 v2.6.0
	gotest.tools/gotestsum v1.10.0
	honnef.co/go/tools v0.4.3
	k8s.io/api v0.27.2
	k8s.io/apimachinery v0.27.2
	k8s.io/client-go v0.27.2
	k8s.io/utils v0.0.0-20230220204549-a5ecb0141aa5
	layeh.com/radius v0.0.0-20230922032716-6579be8edf5d
	mvdan.cc/gofumpt v0.3.1
	nhooyr.io/websocket v1.8.7
)

require (
	cloud.google.com/go/compute v1.21.0 // indirect
	cloud.google.com/go/compute/metadata v0.2.3 // indirect
	cloud.google.com/go/iam v1.1.1 // indirect
	cloud.google.com/go/kms v1.12.1 // indirect
	github.com/Azure/azure-sdk-for-go v67.2.0+incompatible // indirect
	github.com/Azure/azure-sdk-for-go/sdk/azcore v1.9.0 // indirect
	github.com/Azure/azure-sdk-for-go/sdk/azidentity v1.4.0 // indirect
	github.com/Azure/azure-sdk-for-go/sdk/internal v1.5.0 // indirect
	github.com/Azure/azure-sdk-for-go/sdk/keyvault/azkeys v0.10.0 // indirect
	github.com/Azure/azure-sdk-for-go/sdk/keyvault/internal v0.7.1 // indirect
	github.com/Azure/go-ansiterm v0.0.0-20230124172434-306776ec8161 // indirect
	github.com/Azure/go-autorest v14.2.0+incompatible // indirect
	github.com/Azure/go-autorest/autorest v0.11.29 // indirect
	github.com/Azure/go-autorest/autorest/adal v0.9.22 // indirect
	github.com/Azure/go-autorest/autorest/azure/auth v0.5.12 // indirect
	github.com/Azure/go-autorest/autorest/azure/cli v0.4.5 // indirect
	github.com/Azure/go-autorest/autorest/date v0.3.0 // indirect
	github.com/Azure/go-autorest/autorest/to v0.4.0 // indirect
	github.com/Azure/go-autorest/autorest/validation v0.3.1 // indirect
	github.com/Azure/go-autorest/logger v0.2.1 // indirect
	github.com/Azure/go-autorest/tracing v0.6.0 // indirect
	github.com/Azure/go-ntlmssp v0.0.0-20221128193559-754e69321358 // indirect
	github.com/AzureAD/microsoft-authentication-library-for-go v1.1.1 // indirect
	github.com/BurntSushi/toml v1.3.2 // indirect
	github.com/DataDog/datadog-go v3.2.0+incompatible // indirect
	github.com/Jeffail/gabs v1.1.1 // indirect
	github.com/Masterminds/goutils v1.1.1 // indirect
	github.com/Masterminds/semver/v3 v3.2.1 // indirect
	github.com/Masterminds/sprig/v3 v3.2.3 // indirect
	github.com/Microsoft/go-winio v0.6.1 // indirect
	github.com/Nvveen/Gotty v0.0.0-20120604004816-cd527374f1e5 // indirect
	github.com/agext/levenshtein v1.2.1 // indirect
	github.com/aliyun/alibaba-cloud-sdk-go v1.62.301 // indirect
	github.com/andybalholm/brotli v1.0.4 // indirect
	github.com/apparentlymart/go-textseg/v13 v13.0.0 // indirect
	github.com/aws/aws-sdk-go v1.44.269 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/bgentry/speakeasy v0.1.0 // indirect
	github.com/boombuler/barcode v1.0.1 // indirect
	github.com/cenkalti/backoff/v4 v4.2.0 // indirect
	github.com/cespare/xxhash/v2 v2.2.0 // indirect
	github.com/circonus-labs/circonus-gometrics v2.3.1+incompatible // indirect
	github.com/circonus-labs/circonusllhist v0.1.3 // indirect
	github.com/cloudflare/circl v1.3.3 // indirect
	github.com/containerd/containerd v1.7.0 // indirect
	github.com/containerd/continuity v0.3.0 // indirect
	github.com/coreos/go-oidc/v3 v3.5.0 // indirect
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/denverdino/aliyungo v0.0.0-20190125010748-a747050bb1ba // indirect
	github.com/dgryski/go-metro v0.0.0-20180109044635-280f6062b5bc // indirect
	github.com/digitalocean/godo v1.7.5 // indirect
	github.com/dimchansky/utfbom v1.1.1 // indirect
	github.com/dnephin/pflag v1.0.7 // indirect
	github.com/docker/cli v20.10.20+incompatible // indirect
	github.com/docker/distribution v2.8.2+incompatible // indirect
	github.com/docker/docker v24.0.5+incompatible // indirect
	github.com/docker/go-connections v0.4.0 // indirect
	github.com/docker/go-units v0.5.0 // indirect
	github.com/dsnet/compress v0.0.2-0.20210315054119-f66993602bf5 // indirect
	github.com/emicklei/go-restful/v3 v3.10.1 // indirect
	github.com/evanphx/json-patch/v5 v5.6.0 // indirect
	github.com/fsnotify/fsnotify v1.6.0 // indirect
	github.com/gammazero/deque v0.2.1 // indirect
	github.com/go-asn1-ber/asn1-ber v1.5.4 // indirect
	github.com/go-logr/logr v1.2.4 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-ole/go-ole v1.2.6 // indirect
	github.com/go-openapi/jsonpointer v0.20.0 // indirect
	github.com/go-openapi/jsonreference v0.20.2 // indirect
	github.com/go-openapi/swag v0.22.4 // indirect
	github.com/gofrs/uuid v4.3.0+incompatible // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang-jwt/jwt/v5 v5.0.0 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/google/gnostic v0.5.7-v3refs // indirect
	github.com/google/go-querystring v1.1.0 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/google/s2a-go v0.1.4 // indirect
	github.com/google/shlex v0.0.0-20191202100458-e7afc7fbc510 // indirect
	github.com/google/uuid v1.3.1 // indirect
	github.com/googleapis/enterprise-certificate-proxy v0.2.3 // indirect
	github.com/googleapis/gax-go/v2 v2.11.0 // indirect
	github.com/gophercloud/gophercloud v0.1.0 // indirect
	github.com/gorilla/websocket v1.5.0 // indirect
	github.com/hailocab/go-hostpool v0.0.0-20160125115350-e80d13ce29ed // indirect
	github.com/hashicorp/go-immutable-radix v1.3.1 // indirect
	github.com/hashicorp/go-secure-stdlib/awsutil v0.2.3 // indirect
	github.com/hashicorp/logutils v1.0.0 // indirect
	github.com/hashicorp/mdns v1.0.4 // indirect
	github.com/hashicorp/serf v0.10.1 // indirect
	github.com/hashicorp/vic v1.5.1-0.20190403131502-bbfe86ec9443 // indirect
	github.com/hashicorp/yamux v0.1.1 // indirect
	github.com/huandu/xstrings v1.4.0 // indirect
	github.com/imdario/mergo v0.3.15 // indirect
	github.com/jackc/chunkreader/v2 v2.0.1 // indirect
	github.com/jackc/pgconn v1.14.0 // indirect
	github.com/jackc/pgio v1.0.0 // indirect
	github.com/jackc/pgpassfile v1.0.0 // indirect
	github.com/jackc/pgproto3/v2 v2.3.2 // indirect
	github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a // indirect
	github.com/jackc/pgtype v1.14.0 // indirect
	github.com/jcmturner/aescts/v2 v2.0.0 // indirect
	github.com/jcmturner/dnsutils/v2 v2.0.0 // indirect
	github.com/jcmturner/gofork v1.7.6 // indirect
	github.com/jcmturner/goidentity/v6 v6.0.1 // indirect
	github.com/jcmturner/rpc/v2 v2.0.3 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/joyent/triton-go v1.7.1-0.20200416154420-6801d15b779f // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/kelseyhightower/envconfig v1.4.0 // indirect
	github.com/klauspost/pgzip v1.2.5 // indirect
	github.com/kylelemons/godebug v1.1.0 // indirect
	github.com/lib/pq v1.10.9 // indirect
	github.com/linode/linodego v0.7.1 // indirect
	github.com/lufia/plan9stats v0.0.0-20211012122336-39d0f177ccd0 // indirect
	github.com/mailru/easyjson v0.7.7 // indirect
	github.com/matttproud/golang_protobuf_extensions v1.0.4 // indirect
	github.com/miekg/dns v1.1.43 // indirect
	github.com/moby/patternmatcher v0.5.0 // indirect
	github.com/moby/sys/sequential v0.5.0 // indirect
	github.com/moby/term v0.0.0-20221205130635-1aeaba878587 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/nicolai86/scaleway-sdk v1.10.2-0.20180628010248-798f60e20bb2 // indirect
	github.com/nwaples/rardecode v1.1.2 // indirect
	github.com/openbao/openbao/api/auth/kubernetes v0.0.0-20240227182507-a8c90d250c17 // indirect
	github.com/opencontainers/go-digest v1.0.0 // indirect
	github.com/opencontainers/image-spec v1.1.0-rc2.0.20221005185240-3a7f492d3f1b // indirect
	github.com/opencontainers/runc v1.1.6 // indirect
	github.com/opentracing/opentracing-go v1.2.1-0.20220228012449-10b1cf09e00b // indirect
	github.com/oracle/oci-go-sdk/v60 v60.0.0 // indirect
	github.com/packethost/packngo v0.1.1-0.20180711074735-b9cb5096f54c // indirect
	github.com/petermattis/goid v0.0.0-20180202154549-b0b1615b78e5 // indirect
	github.com/pierrec/lz4 v2.6.1+incompatible // indirect
	github.com/pierrec/lz4/v4 v4.1.17 // indirect
	github.com/pkg/browser v0.0.0-20210911075715-681adbf594b8 // indirect
	github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2 // indirect
	github.com/power-devops/perfstat v0.0.0-20210106213030-5aafc221ea8c // indirect
	github.com/prometheus/client_model v0.4.0 // indirect
	github.com/prometheus/procfs v0.8.0 // indirect
	github.com/renier/xmlrpc v0.0.0-20170708154548-ce4a1a486c03 // indirect
	github.com/rogpeppe/go-internal v1.11.0 // indirect
	github.com/sergi/go-diff v1.1.0 // indirect
	github.com/shopspring/decimal v1.3.1 // indirect
	github.com/sirupsen/logrus v1.9.0 // indirect
	github.com/softlayer/softlayer-go v0.0.0-20180806151055-260589d94c7d // indirect
	github.com/sony/gobreaker v0.5.0 // indirect
	github.com/spf13/cast v1.5.1 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
	github.com/stretchr/objx v0.5.0 // indirect
	github.com/tencentcloud/tencentcloud-sdk-go v1.0.162 // indirect
	github.com/tilinna/clock v1.0.2 // indirect
	github.com/tklauser/go-sysconf v0.3.10 // indirect
	github.com/tklauser/numcpus v0.4.0 // indirect
	github.com/tv42/httpunix v0.0.0-20191220191345-2ba4b9c3382c // indirect
	github.com/ulikunitz/xz v0.5.10 // indirect
	github.com/vmware/govmomi v0.18.0 // indirect
	github.com/xeipuuv/gojsonpointer v0.0.0-20190905194746-02993c407bfb // indirect
	github.com/xeipuuv/gojsonreference v0.0.0-20180127040603-bd5ef7bd5415 // indirect
	github.com/xeipuuv/gojsonschema v1.2.0 // indirect
	github.com/xi2/xz v0.0.0-20171230120015-48954b6210f8 // indirect
	github.com/yusufpapurcu/wmi v1.2.2 // indirect
	github.com/zclconf/go-cty v1.12.1 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.opentelemetry.io/otel/metric v1.16.0 // indirect
	golang.org/x/exp/typeparams v0.0.0-20221208152030-732eee02a75a // indirect
	golang.org/x/mod v0.13.0 // indirect
	golang.org/x/time v0.3.0 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/genproto v0.0.0-20230711160842-782d3b101e98 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20230711160842-782d3b101e98 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20230711160842-782d3b101e98 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/ini.v1 v1.66.2 // indirect
	gopkg.in/resty.v1 v1.12.0 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	k8s.io/klog/v2 v2.90.1 // indirect
	k8s.io/kube-openapi v0.0.0-20230501164219-8b0f38b5fd1f // indirect
	sigs.k8s.io/json v0.0.0-20221116044647-bc3834ca7abd // indirect
	sigs.k8s.io/structured-merge-diff/v4 v4.2.3 // indirect
	sigs.k8s.io/yaml v1.3.0 // indirect
)
