// Copyright (c) HashiCorp, Inc.
// SPDX-License-Identifier: MPL-2.0

//go:build !enterprise

package vault

import (
	"fmt"

	"github.com/openbao/openbao/helper/namespace"
	"github.com/openbao/openbao/sdk/logical"
)

func (m *ExpirationManager) leaseView(*namespace.Namespace) *BarrierView {
	return m.idView
}

func (m *ExpirationManager) tokenIndexView(*namespace.Namespace) *BarrierView {
	return m.tokenView
}

func (m *ExpirationManager) collectLeases() (map[*namespace.Namespace][]string, int, error) {
	leaseCount := 0
	existing := make(map[*namespace.Namespace][]string)
	keys, err := logical.CollectKeys(m.quitContext, m.leaseView(namespace.RootNamespace))
	if err != nil {
		return nil, 0, fmt.Errorf("failed to scan for leases: %w", err)
	}
	existing[namespace.RootNamespace] = keys
	leaseCount += len(keys)
	return existing, leaseCount, nil
}
